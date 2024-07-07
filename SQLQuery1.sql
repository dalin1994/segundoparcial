
--create database BD_SistemaVentas2--
use BD_SistemaVentas2
CREATE TABLE rol (
    idRol INT PRIMARY KEY,
    nombre VARCHAR(255),
    fechaRegistro DATETIME
);

CREATE TABLE permiso (
    idPermiso INT PRIMARY KEY,
    id_rol INT,
    descripcion VARCHAR(255),
    fechaCreacion DATETIME
);

CREATE TABLE proveedor (
    idProveedor INT PRIMARY KEY,
    cedula VARCHAR(255),
    razonSocial VARCHAR(255),
    correo VARCHAR(255),
    telefono VARCHAR(255),
    estado BIT,
    fechaCreacion DATETIME
);
CREATE TABLE cliente (
    idCliente INT PRIMARY KEY,
    cedula VARCHAR(255),
    nombreCompleto VARCHAR(255),
    correo VARCHAR(255),
    telefono VARCHAR(255),
    direccion VARCHAR(255),
    estado BIT,
    fechaCreacion DATETIME
);

CREATE TABLE usuario (
    idUsuario INT PRIMARY KEY,
    id_rol INT,
    cedula VARCHAR(255),
    nombreCompleto VARCHAR(255),
    correo VARCHAR(255),
    clave VARCHAR(255),
    telefono VARCHAR(255),
    estado BIT,
    fechaCreacion DATETIME
);
CREATE TABLE compraProductos (
    idCompra INT PRIMARY KEY,
    id_usuario INT,
    id_proveedor INT,
    tipoDocumento VARCHAR(255),
    numeroDocumento VARCHAR(255),
    montoTotal DECIMAL,
    fechaCreacion DATETIME
);

CREATE TABLE detalleCompra (
    idDetalleCompra INT PRIMARY KEY,
    id_compra INT,
    id_producto INT,
    precioCompra INT,
    precioVenta INT,
    cantidad INT,
    montoTotal INT
);
CREATE TABLE venta (
    idVenta INT PRIMARY KEY,
    id_usuario INT,
    id_cliente INT,
    tipoDocumento VARCHAR(255),
    numeroDocumento VARCHAR(255),
    documentoCliente VARCHAR(255),
    nombreCliente VARCHAR(255),
    montoPago DECIMAL,
    montoCambio DECIMAL,
    montoTotal DECIMAL,
    fechaRegistro DATETIME
);

CREATE TABLE DetalleVenta (
    idDetalleVenta INT PRIMARY KEY,
    id_venta INT,
    id_producto INT,
    precioVenta DECIMAL,
    cantidad INT,
    subtotal DECIMAL,
    fechaRegistro DATETIME
);

CREATE TABLE Producto (
    IdProducto INT PRIMARY KEY,
    Id_descuento INT,
    id_inventario INT,
    codigo VARCHAR(255),
    nombre VARCHAR(255),
    descripcion VARCHAR(255),
    id_categoria INT,
    stock INT,
    precioCompra DECIMAL,
    precioVenta DECIMAL,
    estado BIT,
    fechaRegistro DATETIME
);

CREATE TABLE Categoria (
    idCategoria INT PRIMARY KEY,
    descripcion VARCHAR(255),
    estado BIT,
    fechaRegistro DATETIME
);

CREATE TABLE Inventario (
    idInventario INT PRIMARY KEY,
    nombre VARCHAR(255),
    cantidad INT,
    precio DECIMAL,
    categoria VARCHAR(255),
    proveedor VARCHAR(255),
    fecha_entrada DATE,
    ubicacion_almacen VARCHAR(255),
    estado VARCHAR(255),
    notas TEXT
);

CREATE TABLE Almacen (
    idAlmacen INT PRIMARY KEY,
    id_inventario INT,
    nombre VARCHAR(255),
    direccion VARCHAR(255),
    ciudad VARCHAR(255),
    estado BIT,
    fechaRegistro DATETIME
);
CREATE TABLE Descuento (
    idDescuento INT PRIMARY KEY,
    descripcion VARCHAR(255),
    tipoDescuento VARCHAR(255),
    valorDescuento DECIMAL,
    fechaInicio DATETIME,
    fechaFin DATETIME,
    estado BIT,
    fechaCreacion DATETIME
);

CREATE TABLE DetalleDescuento (
    idDetalleDescuento INT PRIMARY KEY,
    id_descuento INT,
    id_producto INT,
    cantidadMinima INT,
    fechaCreacion DATETIME
);

CREATE TABLE Factura (
    idFactura INT PRIMARY KEY,
    id_Venta INT,
    numeroFactura VARCHAR(255),
    fechaEmision DATETIME,
    total DECIMAL,
    estado VARCHAR(255),
    observaciones TEXT,
    fechaCreacion DATETIME
);

CREATE TABLE FormaPago (
    idFormaPago INT PRIMARY KEY,
    id_Venta INT,
    nombre VARCHAR(255),
    descripcion VARCHAR(255)
);

CREATE TABLE Envio (
    idEnvio INT PRIMARY KEY,
    id_cliente INT,
    direccion VARCHAR(255),
    fechaEnvio DATETIME,
    estadoEnvio BIT
);
CREATE TABLE Devolucion (
    IdDevolucion INT PRIMARY KEY,
    id_venta INT,
    fechaDevolucion DATETIME,
    descripcion VARCHAR(255),
    estadoDevolucion BIT
);

CREATE TABLE HistorialCliente (
    idHistorial INT PRIMARY KEY,
    id_factura INT
);

CREATE TABLE Auditoria (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    TableName NVARCHAR(128) NOT NULL,
    Action NVARCHAR(10) NOT NULL,
    RecordId NVARCHAR(256) NOT NULL,
    OldValues NVARCHAR(MAX) NULL,
    NewValues NVARCHAR(MAX) NULL,
    Timestamp DATETIME NOT NULL DEFAULT GETDATE(),
    [User] NVARCHAR(128) NOT NULL
);

-- Agregar relaciones con ALTER TABLE
ALTER TABLE permiso
ADD CONSTRAINT FK_permiso_rol FOREIGN KEY (id_rol) REFERENCES rol(idRol);


ALTER TABLE compraProductos ADD CONSTRAINT FK_compraProductos_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(idUsuario);
 
ALTER TABLE compraProductos ADD CONSTRAINT FK_compraProductos_proveedor FOREIGN KEY (id_proveedor) REFERENCES proveedor(idProveedor);

ALTER TABLE detalleCompra ADD CONSTRAINT FK_detalleCompra_compraProductos FOREIGN KEY (id_compra) REFERENCES compraProductos(idCompra);

ALTER TABLE detalleCompra ADD CONSTRAINT FK_detalleCompra_Producto FOREIGN KEY (id_producto) REFERENCES Producto(IdProducto);

ALTER TABLE venta ADD CONSTRAINT FK_venta_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(idUsuario);
ALTER TABLE venta ADD CONSTRAINT FK_venta_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(idCliente);


ALTER TABLE DetalleVenta ADD CONSTRAINT FK_DetalleVenta_venta FOREIGN KEY (id_venta) REFERENCES venta(idVenta);
ALTER TABLE DetalleVenta ADD CONSTRAINT FK_DetalleVenta_Producto FOREIGN KEY (id_producto) REFERENCES Producto(IdProducto);

ALTER TABLE Producto ADD CONSTRAINT FK_Producto_categoria FOREIGN KEY (id_categoria) REFERENCES Categoria(idCategoria);
ALTER TABLE Producto ADD CONSTRAINT FK_Producto_Descuento FOREIGN KEY (Id_descuento) REFERENCES Descuento(idDescuento);
ALTER TABLE Producto ADD CONSTRAINT FK_Producto_Inventario FOREIGN KEY (id_inventario) REFERENCES Inventario(idInventario);

ALTER TABLE Almacen
ADD CONSTRAINT FK_Almacen_Inventario FOREIGN KEY (id_inventario) REFERENCES Inventario(idInventario);
ALTER TABLE DetalleDescuento
ADD CONSTRAINT FK_DetalleDescuento_Descuento FOREIGN KEY (id_descuento) REFERENCES Descuento(idDescuento);

ALTER TABLE Factura
ADD CONSTRAINT FK_Factura_Venta FOREIGN KEY (id_Venta) REFERENCES venta(idVenta);

ALTER TABLE FormaPago
ADD CONSTRAINT FK_FormaPago_Venta FOREIGN KEY (id_Venta) REFERENCES venta(idVenta);

ALTER TABLE Envio
ADD CONSTRAINT FK_Envio_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(idCliente);

ALTER TABLE Devolucion
ADD CONSTRAINT FK_Devolucion_venta FOREIGN KEY (id_venta) REFERENCES venta(idVenta);

ALTER TABLE HistorialCliente
ADD CONSTRAINT FK_HistorialCliente_Factura FOREIGN KEY (id_factura) REFERENCES Factura(idFactura);

select * from Envio

ALTER TABLE venta
ADD procesado BIT DEFAULT 0;

ALTER TABLE DetalleVenta
ADD procesado BIT DEFAULT 0;

-- Primera inserci n
INSERT INTO Categoria (idCategoria, descripcion, estado, fechaRegistro)
VALUES (1, 'Electronica', 1, '2024-06-17 10:30:00');

-- Segunda inserci n
INSERT INTO Categoria (idCategoria, descripcion, estado, fechaRegistro)
VALUES (2, 'Ropa', 1, '2024-06-17 11:00:00');

select * from Categoria
select * from Auditoria

select * from Producto

------****************
--VALUES (1, 'Electronica', 1, '2024-06-17 10:30:00');

update Categoria set descripcion = 'Electronicaupdate1' where idCategoria=1;

delete from Categoria Where idCategoria= 1
---************************************************************
drop procedure ProcesoVentas2

GO
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
GO
select * from DetalleVenta
-- Tabla Categoria
INSERT INTO Categoria (idCategoria, descripcion, estado, fechaRegistro)
VALUES (1, 'Electrónica', 1, GETDATE()),
       (2, 'Ropa', 1, GETDATE());

-- Tabla Inventario
INSERT INTO Inventario (idInventario, nombre, cantidad, precio, categoria, proveedor, fecha_entrada, ubicacion_almacen, estado, notas)
VALUES (1, 'Inventario Principal', 100, 1500.00, 'Electrónica', 'Proveedor 1', '2023-01-01', 'Almacén A', 'Activo', 'Notas sobre el inventario');

-- Tabla Descuento
INSERT INTO Descuento (idDescuento, descripcion, tipoDescuento, valorDescuento, fechaInicio, fechaFin, estado, fechaCreacion)
VALUES (1, 'Descuento de Temporada', 'Porcentaje', 10.00, '2023-01-01', '2023-12-31', 1, GETDATE());

-- Tabla Almacen
INSERT INTO Almacen (idAlmacen, id_inventario, nombre, direccion, ciudad, estado, fechaRegistro)
VALUES (1, 1, 'Almacén Central', 'Calle Falsa 123', 'Ciudad Falsa', 1, GETDATE());

-- Tabla rol
INSERT INTO rol (idRol, nombre, fechaRegistro)
VALUES (1, 'Admin', GETDATE()),
       (2, 'User', GETDATE());



	   --try
	   select * from Producto
-- Tabla Producto
INSERT INTO Producto (IdProducto, Id_descuento, id_inventario, codigo, nombre, descripcion, id_categoria, stock, precioCompra, precioVenta, estado, fechaRegistro)
VALUES (1, 1, 1, 'P001', 'Laptop', 'Laptop de alta gama', 2, 50, 1200.00, 1500.00, 1, GETDATE());

-- Tabla proveedor
INSERT INTO proveedor (idProveedor, cedula, razonSocial, correo, telefono, estado, fechaCreacion)
VALUES (1, '1234567890', 'Proveedor 1', 'proveedor1@example.com', '123456789', 1, GETDATE());

-- Tabla cliente
INSERT INTO cliente (idCliente, cedula, nombreCompleto, correo, telefono, direccion, estado, fechaCreacion)
VALUES (1, '1234567890', 'Juan Pérez', 'juan@example.com', '123456789', 'Calle Falsa 123', 1, GETDATE());

-- Tabla usuario
INSERT INTO usuario (idUsuario, id_rol, cedula, nombreCompleto, correo, clave, telefono, estado, fechaCreacion)
VALUES (1, 1, '1234567890', 'Admin User', 'admin@example.com', 'admin123', '123456789', 1, GETDATE());

-- Tabla compraProductos
INSERT INTO compraProductos (idCompra, id_usuario, id_proveedor, tipoDocumento, numeroDocumento, montoTotal, fechaCreacion)
VALUES (1, 1, 1, 'Factura', 'F001', 1800.00, GETDATE());

-- Tabla detalleCompra
INSERT INTO detalleCompra (idDetalleCompra, id_compra, id_producto, precioCompra, precioVenta, cantidad, montoTotal)
VALUES (1, 1, 1, 1200, 1500, 1, 1500);

-- Tabla venta
INSERT INTO venta (idVenta, id_usuario, id_cliente, tipoDocumento, numeroDocumento, documentoCliente, nombreCliente, montoPago, montoCambio, montoTotal, fechaRegistro)
VALUES (13, 1, 1, 'Factura', 'V001', '1234567890', 'Juan Pérez', 1500.00, 0.00, 1500.00, GETDATE());

-- Tabla DetalleVenta
INSERT INTO DetalleVenta (idDetalleVenta, id_venta, id_producto, precioVenta, cantidad, subtotal, fechaRegistro)
VALUES (13,13, 1, 1500.00, 5, 1500.00, GETDATE());

EXEC ProcesoVentas2;

select * from Producto
select * from venta
select * from Auditoria

update Producto SET stock = 50 where IdProducto = 1
delete Venta



GO
CREATE TRIGGER trg_AfterInsert_DetalleVenta
ON DetalleVenta
AFTER INSERT
AS
BEGIN
    -- Llamar al procedimiento después de insertar un detalle de venta
    EXEC ProcesoVentas2;
END
GO

drop trigger trg_AfterInsert_DetalleVenta

drop procedure ProcesoVentas2

select * from DetalleVenta