using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Text;
using System.Threading.Tasks;

namespace CRUDUsuariosRoles
{
    class Program
    {
        static string connectionString = "Server=LAPTOP-6SR12CFI\\SQLEXPRESS;Database=BD_SistemaVentas2;Integrated Security=True;";
        static List<string> historialConsultas = new List<string>();

        static void Main(string[] args)
        {
            while (true)
            {
                Console.WriteLine("");
                Console.WriteLine("Seleccione una opción:");
                Console.WriteLine("1. Listar atributos por entidades");
                Console.WriteLine("2. Generar disparadores de auditoría");
                Console.WriteLine("3. Ejecutar consultas con hilos");
                Console.WriteLine("4. Ver historial de consultas");
                Console.WriteLine("5. generar Procedimiento Almacenado");
                Console.WriteLine("6. actualizar stock");
                Console.WriteLine("7. Salir");

                Console.WriteLine("");
                Console.Write("Ingrese la opción seleccionada: ");

                int opcion;
                if (!int.TryParse(Console.ReadLine(), out opcion))
                {
                    Console.WriteLine("Opción no válida. Por favor, ingrese un número del 1 al 4.");
                    continue;
                }

                switch (opcion)
                {
                    case 1:
                        ListarAtributosEntidad();
                        break;
                    case 2:
                        string outputFilePath = "C:/Users/Usuario/Desktop/triggersAudi2.sql";//Users\pinar\OneDrive\Escritorio
                        GenerateTriggers(outputFilePath);
                        break;
                    case 3:
                        EjecutarConsultasConHilos();
                        break;
                    case 4:
                        VerHistorialDeConsultas();
                        return;
                    case 5:
                        string file = "C:/Users/Usuario/Desktop/Procedimiento.sql";//Users\pinar\OneDrive\Escritorio
                        GenerarProcedimiento(file);
                        break;
                    case 6:
                        ejecutarProcedimientoAlmacenado();
                        break;
                    case 7:
                        return;
                    default:
                        Console.WriteLine("Opción no válida. Por favor, ingrese un número del 1 al 5.");
                        break;
                }
            }
        }

        static void ListarAtributosEntidad()
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    string query = "SELECT object_id, name FROM sys.objects WHERE type IN ('U', 'V', 'P', 'FN', 'TF', 'IF') ORDER BY name";

                    Dictionary<int, string> entityDictionary = new Dictionary<int, string>();

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            Console.WriteLine("Lista de entidades en la base de datos:");

                            int entityId = 1;
                            while (reader.Read())
                            {
                                string entityName = reader.GetString(1);
                                Console.WriteLine($"{entityId}. {entityName}");
                                entityDictionary.Add(entityId, entityName);
                                entityId++;
                            }
                        }
                    }

                    Console.Write("Seleccione el número de la entidad para ver sus atributos (o 0 para salir): ");
                    if (int.TryParse(Console.ReadLine(), out int selectedEntityId) && entityDictionary.ContainsKey(selectedEntityId))
                    {
                        string selectedEntity = entityDictionary[selectedEntityId];
                        MostrarAtributosEntidad(connection, selectedEntity);
                    }
                    else
                    {
                        Console.WriteLine("Selección no válida o no seleccionada. Saliendo del programa.");
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error al listar los atributos de las entidades: " + ex.Message);
            }
        }

        static void MostrarAtributosEntidad(SqlConnection connection, string entityName)
        {
            try
            {
                string query = "SELECT name FROM sys.columns WHERE object_id = OBJECT_ID(@entityName)";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@entityName", entityName);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        Console.WriteLine("Atributos de la entidad " + entityName + ":");

                        while (reader.Read())
                        {
                            string attributeName = reader.GetString(0);
                            Console.WriteLine("- " + attributeName);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error al listar los atributos de la entidad " + entityName + ": " + ex.Message);
            }
        }

        public static void GenerateTriggers(string outputFilePath)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = @"
                SELECT o.name AS TableName, c.name AS ColumnName
                FROM sys.objects o
                JOIN sys.columns c ON o.object_id = c.object_id
                WHERE o.type = 'U'
                ORDER BY o.name, c.column_id";

                SqlCommand command = new SqlCommand(query, connection);
                SqlDataReader reader = command.ExecuteReader();

                StringBuilder script = new StringBuilder();

                string currentTable = null;
                StringBuilder newValues = new StringBuilder();
                StringBuilder oldValues = new StringBuilder();
                string primaryKey = null;

                while (reader.Read())
                {
                    string tableName = reader["TableName"].ToString();
                    string columnName = reader["ColumnName"].ToString();

                    if (currentTable != tableName)
                    {
                        if (currentTable != null)
                        {
                            AppendTriggerScripts(script, currentTable, oldValues.ToString(), newValues.ToString(), primaryKey);
                        }

                        currentTable = tableName;
                        newValues.Clear();
                        oldValues.Clear();
                        primaryKey = columnName; // Assuming the first column is the primary key
                    }

                    newValues.Append($"'New_{columnName}: ' + CONVERT(NVARCHAR(MAX), INSERTED.{columnName}) + ', ' + ");
                    oldValues.Append($"'Old_{columnName}: ' + CONVERT(NVARCHAR(MAX), DELETED.{columnName}) + ', ' + ");
                }

                if (currentTable != null)
                {
                    AppendTriggerScripts(script, currentTable, oldValues.ToString(), newValues.ToString(), primaryKey);
                }

                reader.Close();

                File.WriteAllText(outputFilePath, script.ToString());
                Console.WriteLine($"El archivo con los triggers ha sido generado en: {outputFilePath}");

            }
        }

        private static void AppendTriggerScripts(StringBuilder script, string tableName, string oldValues, string newValues, string primaryKey)
        {
            script.AppendLine($"-- Triggers for {tableName}");
            script.AppendLine(GenerateInsertTrigger(tableName, newValues, primaryKey));
            script.AppendLine(GenerateUpdateTrigger(tableName, oldValues, newValues, primaryKey));
            script.AppendLine(GenerateDeleteTrigger(tableName, oldValues, primaryKey));
            script.AppendLine();
        }

        private static string GenerateInsertTrigger(string tableName, string newValues, string primaryKey)
        {
            return $@"
CREATE TRIGGER trg_{tableName}_Insert
ON {tableName}
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, NewValues, Timestamp, [User])
    SELECT '{tableName}', 'INSERT', INSERTED.{primaryKey}, 
           {newValues.TrimEnd('+', ' ')}, GETDATE(), SYSTEM_USER
    FROM INSERTED;
END;";
        }

        private static string GenerateUpdateTrigger(string tableName, string oldValues, string newValues, string primaryKey)
        {
            return $@"
CREATE TRIGGER trg_{tableName}_Update
ON {tableName}
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, NewValues, Timestamp, [User])
    SELECT '{tableName}', 'UPDATE', INSERTED.{primaryKey}, 
           {oldValues.TrimEnd('+', ' ')}, 
           {newValues.TrimEnd('+', ' ')}, GETDATE(), SYSTEM_USER
    FROM INSERTED
    JOIN DELETED ON INSERTED.{primaryKey} = DELETED.{primaryKey};
END;";
        }

        private static string GenerateDeleteTrigger(string tableName, string oldValues, string primaryKey)
        {
            return $@"
CREATE TRIGGER trg_{tableName}_Delete
ON {tableName}
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, Timestamp, [User])
    SELECT '{tableName}', 'DELETE', DELETED.{primaryKey}, 
           {oldValues.TrimEnd('+', ' ')}, GETDATE(), SYSTEM_USER
    FROM DELETED;
END;";
        }
        static void EjecutarConsultasConHilos()
        {
            string filePath = $@"C:/Users/Usuario/Desktop/Querys.txt";
            List<string> queries = new List<string>();

            Console.WriteLine("Seleccione una opción:");
            Console.WriteLine("1. Ingresar consultas manualmente");
            Console.WriteLine("2. Leer consultas desde archivo");
            Console.Write("Ingrese la opción seleccionada: ");

            if (int.TryParse(Console.ReadLine(), out int opcion) && opcion == 2)
            {
                // Leer las consultas desde el archivo .txt
                try
                {
                    if (File.Exists(filePath))
                    {
                        queries.AddRange(File.ReadAllLines(filePath));
                    }
                    else
                    {
                        Console.WriteLine("El archivo de consultas no existe en la ruta especificada.");
                        return;
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error al leer el archivo de consultas: {ex.Message}");
                    return;
                }

                if (queries.Count == 0)
                {
                    Console.WriteLine("No se encontraron consultas en el archivo.");
                    return;
                }
            }
            else if (opcion == 1)
            {
                // Solicitar al usuario el número de consultas
                Console.Write("Ingrese el número de consultas a ejecutar: ");
                if (!int.TryParse(Console.ReadLine(), out int numConsultas) || numConsultas <= 0)
                {
                    Console.WriteLine("Número de consultas no válido.");
                    return;
                }

                // Solicitar al usuario las consultas
                for (int i = 0; i < numConsultas; i++)
                {
                    Console.Write($"Ingrese la consulta {i + 1}: ");
                    string query = Console.ReadLine();
                    queries.Add(query);
                }
            }
            else
            {
                Console.WriteLine("Opción no válida.");
                return;
            }

            // Añadir las consultas al historial
            historialConsultas.AddRange(queries);

            // Lista para almacenar los resultados de cada consulta
            List<DataTable> results = new List<DataTable>();
            List<long> tiempos = new List<long>();

            // Crear y ejecutar cada consulta en un hilo separado
            List<Task> tasks = new List<Task>();
            foreach (string query in queries)
            {
                Task task = Task.Run(() =>
                {
                    Stopwatch stopwatch = Stopwatch.StartNew();
                    DataTable result = EjecutarConsulta(query);
                    stopwatch.Stop();

                    lock (results) // Bloquea el acceso a las listas compartidas
                    {
                        results.Add(result);
                        tiempos.Add(stopwatch.ElapsedMilliseconds);
                    }
                });
                tasks.Add(task);
            }

            // Esperar a que todos los hilos terminen
            Task.WaitAll(tasks.ToArray());

            // Mostrar los resultados
            Console.WriteLine("Resultados de las consultas:");
            for (int i = 0; i < results.Count; i++)
            {
                Console.WriteLine($"Resultado de la consulta {i + 1} (Tiempo: {tiempos[i]} ms):");
                MostrarResultadoConsulta(results[i]);
            }
        }

        static DataTable EjecutarConsulta(string query)
        {
            DataTable result = new DataTable();

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            result.Load(reader);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error al ejecutar la consulta: {ex.Message}");
            }

            return result;
        }

        static void MostrarResultadoConsulta(DataTable result)
        {
            foreach (DataRow row in result.Rows)
            {
                foreach (DataColumn column in result.Columns)
                {
                    Console.Write($"{column.ColumnName}: {row[column]} ");
                }
                Console.WriteLine();
            }
        }

        static void VerHistorialDeConsultas()
        {
            Console.WriteLine("Historial de consultas realizadas:");
            if (historialConsultas.Count > 0)
            {
                for (int i = 0; i < historialConsultas.Count; i++)
                {
                    Console.WriteLine($"{i + 1}. {historialConsultas[i]}");
                }
            }
            else
            {
                Console.WriteLine("No hay consultas realizadas aun");
            }

        }

        public static void GenerarProcedimiento(string outputFilePath)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = $@"
CREATE PROCEDURE ProcesoVentas2
AS
BEGIN
    DECLARE @idVenta INT,
            @idProducto INT,
            @cantidad INT,
            @stock INT,
            @fechaRegistro DATETIME

    -- Cursor para recorrer todas las ventas no procesadas
    DECLARE SalesCursor CURSOR FOR
    SELECT idVenta, fechaRegistro FROM venta WHERE procesado = 0

    OPEN SalesCursor

    FETCH NEXT FROM SalesCursor INTO @idVenta, @fechaRegistro

    WHILE @@FETCH_STATUS = 0
    BEGIN
        BEGIN TRANSACTION

        -- Cursor para recorrer los detalles de la venta no procesados
        DECLARE SalesDetailsCursor CURSOR FOR
        SELECT id_producto, cantidad FROM DetalleVenta WHERE id_venta = @idVenta AND procesado = 0

        OPEN SalesDetailsCursor

        FETCH NEXT FROM SalesDetailsCursor INTO @idProducto, @cantidad

        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Obtener el stock actual
            SELECT @stock = stock FROM Producto WHERE IdProducto = @idProducto

            IF @stock >= @cantidad
            BEGIN
                -- Actualizar el inventario
                UPDATE Producto SET stock = stock - @cantidad WHERE IdProducto = @idProducto
                -- Marcar detalle de venta como procesado
                UPDATE DetalleVenta SET procesado = 1 WHERE id_venta = @idVenta AND id_producto = @idProducto
            END
            ELSE
            BEGIN
                -- Rollback si no hay suficiente stock
                ROLLBACK TRANSACTION
                PRINT 'Error: Stock insuficiente para el ProductoID ' + CAST(@idProducto AS NVARCHAR(10))
                GOTO ExitProcessing
            END

            FETCH NEXT FROM SalesDetailsCursor INTO @idProducto, @cantidad
        END

        CLOSE SalesDetailsCursor
        DEALLOCATE SalesDetailsCursor

        -- Marcar venta como procesada
        UPDATE venta SET procesado = 1 WHERE idVenta = @idVenta

        -- Registrar el cambio en la tabla de auditoría
        INSERT INTO Auditoria (TableName, Action, RecordId, NewValues, Timestamp, [User])
        VALUES ('venta', 'UPDATE', CAST(@idVenta AS NVARCHAR(10)), 'Procesada', @fechaRegistro, SYSTEM_USER)

        COMMIT TRANSACTION

        FETCH NEXT FROM SalesCursor INTO @idVenta, @fechaRegistro
    END

    CLOSE SalesCursor
    DEALLOCATE SalesCursor

ExitProcessing:
    -- Limpieza de cursores
    IF CURSOR_STATUS('global', 'SalesDetailsCursor') >= 0
    BEGIN
        CLOSE SalesDetailsCursor
        DEALLOCATE SalesDetailsCursor
    END

    IF CURSOR_STATUS('global', 'SalesCursor') >= 0
    BEGIN
        CLOSE SalesCursor
        DEALLOCATE SalesCursor
    END
END
";

                SqlCommand command = new SqlCommand(query, connection);
                SqlDataReader reader = command.ExecuteReader();

                StringBuilder script = new StringBuilder();

                reader.Close();

                File.WriteAllText(outputFilePath, query.ToString());
                Console.WriteLine($"El archivo con el procedimiento almacenado ha sido generado en: {outputFilePath}");

            }
        }

        public static void ejecutarProcedimientoAlmacenado (){
            
            using (SqlConnection connection = new SqlConnection(connectionString)) {

                connection.Open();

                string query = $@"EXEC ProcesoVentas2;";

                SqlCommand command = new SqlCommand(query, connection);
                SqlDataReader reader = command.ExecuteReader();

                StringBuilder script = new StringBuilder();

                reader.Close();
            }
        }

        public static void generarTriggerProcedimiento(string outputFilePath)
        {
            string file2 = "C:/Users/Usuario/Desktop/Procedimiento.sql";

            GenerarProcedimiento(file2);
            using (SqlConnection connection = new SqlConnection(connectionString))
            {

                connection.Open();

                string query = $@"CREATE TRIGGER trg_AfterInsert_DetalleVenta
                    ON DetalleVenta
                    AFTER INSERT
                    AS
                    BEGIN
                        -- Llamar al procedimiento después de insertar un detalle de venta
                        EXEC ProcesoVentas;
                    END";

                SqlCommand command = new SqlCommand(query, connection);
                SqlDataReader reader = command.ExecuteReader();

                StringBuilder script = new StringBuilder();

                reader.Close();

                File.WriteAllText(outputFilePath, query.ToString());
                Console.WriteLine($"El archivo con el trigger ha sido generado en: {outputFilePath}");
            }
        }
    }
}
