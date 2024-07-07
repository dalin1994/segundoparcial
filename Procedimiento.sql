
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
