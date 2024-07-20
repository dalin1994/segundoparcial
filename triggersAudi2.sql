-- Triggers for Almacen

CREATE TRIGGER trg_Almacen_Insert
ON Almacen
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, NewValues, Timestamp, [User])
    SELECT 'Almacen', 'INSERT', INSERTED.idAlmacen, 
           'New_idAlmacen: ' + CONVERT(NVARCHAR(MAX), INSERTED.idAlmacen) + ', ' + 'New_id_inventario: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_inventario) + ', ' + 'New_nombre: ' + CONVERT(NVARCHAR(MAX), INSERTED.nombre) + ', ' + 'New_direccion: ' + CONVERT(NVARCHAR(MAX), INSERTED.direccion) + ', ' + 'New_ciudad: ' + CONVERT(NVARCHAR(MAX), INSERTED.ciudad) + ', ' + 'New_estado: ' + CONVERT(NVARCHAR(MAX), INSERTED.estado) + ', ' + 'New_fechaRegistro: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaRegistro) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED;
END;

CREATE TRIGGER trg_Almacen_Update
ON Almacen
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, NewValues, Timestamp, [User])
    SELECT 'Almacen', 'UPDATE', INSERTED.idAlmacen, 
           'Old_idAlmacen: ' + CONVERT(NVARCHAR(MAX), DELETED.idAlmacen) + ', ' + 'Old_id_inventario: ' + CONVERT(NVARCHAR(MAX), DELETED.id_inventario) + ', ' + 'Old_nombre: ' + CONVERT(NVARCHAR(MAX), DELETED.nombre) + ', ' + 'Old_direccion: ' + CONVERT(NVARCHAR(MAX), DELETED.direccion) + ', ' + 'Old_ciudad: ' + CONVERT(NVARCHAR(MAX), DELETED.ciudad) + ', ' + 'Old_estado: ' + CONVERT(NVARCHAR(MAX), DELETED.estado) + ', ' + 'Old_fechaRegistro: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaRegistro) + ', ', 
           'New_idAlmacen: ' + CONVERT(NVARCHAR(MAX), INSERTED.idAlmacen) + ', ' + 'New_id_inventario: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_inventario) + ', ' + 'New_nombre: ' + CONVERT(NVARCHAR(MAX), INSERTED.nombre) + ', ' + 'New_direccion: ' + CONVERT(NVARCHAR(MAX), INSERTED.direccion) + ', ' + 'New_ciudad: ' + CONVERT(NVARCHAR(MAX), INSERTED.ciudad) + ', ' + 'New_estado: ' + CONVERT(NVARCHAR(MAX), INSERTED.estado) + ', ' + 'New_fechaRegistro: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaRegistro) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED
    JOIN DELETED ON INSERTED.idAlmacen = DELETED.idAlmacen;
END;

CREATE TRIGGER trg_Almacen_Delete
ON Almacen
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, Timestamp, [User])
    SELECT 'Almacen', 'DELETE', DELETED.idAlmacen, 
           'Old_idAlmacen: ' + CONVERT(NVARCHAR(MAX), DELETED.idAlmacen) + ', ' + 'Old_id_inventario: ' + CONVERT(NVARCHAR(MAX), DELETED.id_inventario) + ', ' + 'Old_nombre: ' + CONVERT(NVARCHAR(MAX), DELETED.nombre) + ', ' + 'Old_direccion: ' + CONVERT(NVARCHAR(MAX), DELETED.direccion) + ', ' + 'Old_ciudad: ' + CONVERT(NVARCHAR(MAX), DELETED.ciudad) + ', ' + 'Old_estado: ' + CONVERT(NVARCHAR(MAX), DELETED.estado) + ', ' + 'Old_fechaRegistro: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaRegistro) + ', ', GETDATE(), SYSTEM_USER
    FROM DELETED;
END;

-- Triggers for Auditoria

CREATE TRIGGER trg_Auditoria_Insert
ON Auditoria
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, NewValues, Timestamp, [User])
    SELECT 'Auditoria', 'INSERT', INSERTED.Id, 
           'New_Id: ' + CONVERT(NVARCHAR(MAX), INSERTED.Id) + ', ' + 'New_TableName: ' + CONVERT(NVARCHAR(MAX), INSERTED.TableName) + ', ' + 'New_Action: ' + CONVERT(NVARCHAR(MAX), INSERTED.Action) + ', ' + 'New_RecordId: ' + CONVERT(NVARCHAR(MAX), INSERTED.RecordId) + ', ' + 'New_OldValues: ' + CONVERT(NVARCHAR(MAX), INSERTED.OldValues) + ', ' + 'New_NewValues: ' + CONVERT(NVARCHAR(MAX), INSERTED.NewValues) + ', ' + 'New_Timestamp: ' + CONVERT(NVARCHAR(MAX), INSERTED.Timestamp) + ', ' + 'New_User: ' + CONVERT(NVARCHAR(MAX), INSERTED.User) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED;
END;

CREATE TRIGGER trg_Auditoria_Update
ON Auditoria
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, NewValues, Timestamp, [User])
    SELECT 'Auditoria', 'UPDATE', INSERTED.Id, 
           'Old_Id: ' + CONVERT(NVARCHAR(MAX), DELETED.Id) + ', ' + 'Old_TableName: ' + CONVERT(NVARCHAR(MAX), DELETED.TableName) + ', ' + 'Old_Action: ' + CONVERT(NVARCHAR(MAX), DELETED.Action) + ', ' + 'Old_RecordId: ' + CONVERT(NVARCHAR(MAX), DELETED.RecordId) + ', ' + 'Old_OldValues: ' + CONVERT(NVARCHAR(MAX), DELETED.OldValues) + ', ' + 'Old_NewValues: ' + CONVERT(NVARCHAR(MAX), DELETED.NewValues) + ', ' + 'Old_Timestamp: ' + CONVERT(NVARCHAR(MAX), DELETED.Timestamp) + ', ' + 'Old_User: ' + CONVERT(NVARCHAR(MAX), DELETED.User) + ', ', 
           'New_Id: ' + CONVERT(NVARCHAR(MAX), INSERTED.Id) + ', ' + 'New_TableName: ' + CONVERT(NVARCHAR(MAX), INSERTED.TableName) + ', ' + 'New_Action: ' + CONVERT(NVARCHAR(MAX), INSERTED.Action) + ', ' + 'New_RecordId: ' + CONVERT(NVARCHAR(MAX), INSERTED.RecordId) + ', ' + 'New_OldValues: ' + CONVERT(NVARCHAR(MAX), INSERTED.OldValues) + ', ' + 'New_NewValues: ' + CONVERT(NVARCHAR(MAX), INSERTED.NewValues) + ', ' + 'New_Timestamp: ' + CONVERT(NVARCHAR(MAX), INSERTED.Timestamp) + ', ' + 'New_User: ' + CONVERT(NVARCHAR(MAX), INSERTED.User) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED
    JOIN DELETED ON INSERTED.Id = DELETED.Id;
END;

CREATE TRIGGER trg_Auditoria_Delete
ON Auditoria
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, Timestamp, [User])
    SELECT 'Auditoria', 'DELETE', DELETED.Id, 
           'Old_Id: ' + CONVERT(NVARCHAR(MAX), DELETED.Id) + ', ' + 'Old_TableName: ' + CONVERT(NVARCHAR(MAX), DELETED.TableName) + ', ' + 'Old_Action: ' + CONVERT(NVARCHAR(MAX), DELETED.Action) + ', ' + 'Old_RecordId: ' + CONVERT(NVARCHAR(MAX), DELETED.RecordId) + ', ' + 'Old_OldValues: ' + CONVERT(NVARCHAR(MAX), DELETED.OldValues) + ', ' + 'Old_NewValues: ' + CONVERT(NVARCHAR(MAX), DELETED.NewValues) + ', ' + 'Old_Timestamp: ' + CONVERT(NVARCHAR(MAX), DELETED.Timestamp) + ', ' + 'Old_User: ' + CONVERT(NVARCHAR(MAX), DELETED.User) + ', ', GETDATE(), SYSTEM_USER
    FROM DELETED;
END;

-- Triggers for Categoria

CREATE TRIGGER trg_Categoria_Insert
ON Categoria
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, NewValues, Timestamp, [User])
    SELECT 'Categoria', 'INSERT', INSERTED.idCategoria, 
           'New_idCategoria: ' + CONVERT(NVARCHAR(MAX), INSERTED.idCategoria) + ', ' + 'New_descripcion: ' + CONVERT(NVARCHAR(MAX), INSERTED.descripcion) + ', ' + 'New_estado: ' + CONVERT(NVARCHAR(MAX), INSERTED.estado) + ', ' + 'New_fechaRegistro: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaRegistro) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED;
END;

CREATE TRIGGER trg_Categoria_Update
ON Categoria
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, NewValues, Timestamp, [User])
    SELECT 'Categoria', 'UPDATE', INSERTED.idCategoria, 
           'Old_idCategoria: ' + CONVERT(NVARCHAR(MAX), DELETED.idCategoria) + ', ' + 'Old_descripcion: ' + CONVERT(NVARCHAR(MAX), DELETED.descripcion) + ', ' + 'Old_estado: ' + CONVERT(NVARCHAR(MAX), DELETED.estado) + ', ' + 'Old_fechaRegistro: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaRegistro) + ', ', 
           'New_idCategoria: ' + CONVERT(NVARCHAR(MAX), INSERTED.idCategoria) + ', ' + 'New_descripcion: ' + CONVERT(NVARCHAR(MAX), INSERTED.descripcion) + ', ' + 'New_estado: ' + CONVERT(NVARCHAR(MAX), INSERTED.estado) + ', ' + 'New_fechaRegistro: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaRegistro) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED
    JOIN DELETED ON INSERTED.idCategoria = DELETED.idCategoria;
END;

CREATE TRIGGER trg_Categoria_Delete
ON Categoria
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, Timestamp, [User])
    SELECT 'Categoria', 'DELETE', DELETED.idCategoria, 
           'Old_idCategoria: ' + CONVERT(NVARCHAR(MAX), DELETED.idCategoria) + ', ' + 'Old_descripcion: ' + CONVERT(NVARCHAR(MAX), DELETED.descripcion) + ', ' + 'Old_estado: ' + CONVERT(NVARCHAR(MAX), DELETED.estado) + ', ' + 'Old_fechaRegistro: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaRegistro) + ', ', GETDATE(), SYSTEM_USER
    FROM DELETED;
END;

-- Triggers for cliente

CREATE TRIGGER trg_cliente_Insert
ON cliente
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, NewValues, Timestamp, [User])
    SELECT 'cliente', 'INSERT', INSERTED.idCliente, 
           'New_idCliente: ' + CONVERT(NVARCHAR(MAX), INSERTED.idCliente) + ', ' + 'New_cedula: ' + CONVERT(NVARCHAR(MAX), INSERTED.cedula) + ', ' + 'New_nombreCompleto: ' + CONVERT(NVARCHAR(MAX), INSERTED.nombreCompleto) + ', ' + 'New_correo: ' + CONVERT(NVARCHAR(MAX), INSERTED.correo) + ', ' + 'New_telefono: ' + CONVERT(NVARCHAR(MAX), INSERTED.telefono) + ', ' + 'New_direccion: ' + CONVERT(NVARCHAR(MAX), INSERTED.direccion) + ', ' + 'New_estado: ' + CONVERT(NVARCHAR(MAX), INSERTED.estado) + ', ' + 'New_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaCreacion) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED;
END;

CREATE TRIGGER trg_cliente_Update
ON cliente
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, NewValues, Timestamp, [User])
    SELECT 'cliente', 'UPDATE', INSERTED.idCliente, 
           'Old_idCliente: ' + CONVERT(NVARCHAR(MAX), DELETED.idCliente) + ', ' + 'Old_cedula: ' + CONVERT(NVARCHAR(MAX), DELETED.cedula) + ', ' + 'Old_nombreCompleto: ' + CONVERT(NVARCHAR(MAX), DELETED.nombreCompleto) + ', ' + 'Old_correo: ' + CONVERT(NVARCHAR(MAX), DELETED.correo) + ', ' + 'Old_telefono: ' + CONVERT(NVARCHAR(MAX), DELETED.telefono) + ', ' + 'Old_direccion: ' + CONVERT(NVARCHAR(MAX), DELETED.direccion) + ', ' + 'Old_estado: ' + CONVERT(NVARCHAR(MAX), DELETED.estado) + ', ' + 'Old_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaCreacion) + ', ', 
           'New_idCliente: ' + CONVERT(NVARCHAR(MAX), INSERTED.idCliente) + ', ' + 'New_cedula: ' + CONVERT(NVARCHAR(MAX), INSERTED.cedula) + ', ' + 'New_nombreCompleto: ' + CONVERT(NVARCHAR(MAX), INSERTED.nombreCompleto) + ', ' + 'New_correo: ' + CONVERT(NVARCHAR(MAX), INSERTED.correo) + ', ' + 'New_telefono: ' + CONVERT(NVARCHAR(MAX), INSERTED.telefono) + ', ' + 'New_direccion: ' + CONVERT(NVARCHAR(MAX), INSERTED.direccion) + ', ' + 'New_estado: ' + CONVERT(NVARCHAR(MAX), INSERTED.estado) + ', ' + 'New_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaCreacion) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED
    JOIN DELETED ON INSERTED.idCliente = DELETED.idCliente;
END;

CREATE TRIGGER trg_cliente_Delete
ON cliente
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, Timestamp, [User])
    SELECT 'cliente', 'DELETE', DELETED.idCliente, 
           'Old_idCliente: ' + CONVERT(NVARCHAR(MAX), DELETED.idCliente) + ', ' + 'Old_cedula: ' + CONVERT(NVARCHAR(MAX), DELETED.cedula) + ', ' + 'Old_nombreCompleto: ' + CONVERT(NVARCHAR(MAX), DELETED.nombreCompleto) + ', ' + 'Old_correo: ' + CONVERT(NVARCHAR(MAX), DELETED.correo) + ', ' + 'Old_telefono: ' + CONVERT(NVARCHAR(MAX), DELETED.telefono) + ', ' + 'Old_direccion: ' + CONVERT(NVARCHAR(MAX), DELETED.direccion) + ', ' + 'Old_estado: ' + CONVERT(NVARCHAR(MAX), DELETED.estado) + ', ' + 'Old_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaCreacion) + ', ', GETDATE(), SYSTEM_USER
    FROM DELETED;
END;

-- Triggers for compraProductos

CREATE TRIGGER trg_compraProductos_Insert
ON compraProductos
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, NewValues, Timestamp, [User])
    SELECT 'compraProductos', 'INSERT', INSERTED.idCompra, 
           'New_idCompra: ' + CONVERT(NVARCHAR(MAX), INSERTED.idCompra) + ', ' + 'New_id_usuario: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_usuario) + ', ' + 'New_id_proveedor: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_proveedor) + ', ' + 'New_tipoDocumento: ' + CONVERT(NVARCHAR(MAX), INSERTED.tipoDocumento) + ', ' + 'New_numeroDocumento: ' + CONVERT(NVARCHAR(MAX), INSERTED.numeroDocumento) + ', ' + 'New_montoTotal: ' + CONVERT(NVARCHAR(MAX), INSERTED.montoTotal) + ', ' + 'New_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaCreacion) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED;
END;

CREATE TRIGGER trg_compraProductos_Update
ON compraProductos
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, NewValues, Timestamp, [User])
    SELECT 'compraProductos', 'UPDATE', INSERTED.idCompra, 
           'Old_idCompra: ' + CONVERT(NVARCHAR(MAX), DELETED.idCompra) + ', ' + 'Old_id_usuario: ' + CONVERT(NVARCHAR(MAX), DELETED.id_usuario) + ', ' + 'Old_id_proveedor: ' + CONVERT(NVARCHAR(MAX), DELETED.id_proveedor) + ', ' + 'Old_tipoDocumento: ' + CONVERT(NVARCHAR(MAX), DELETED.tipoDocumento) + ', ' + 'Old_numeroDocumento: ' + CONVERT(NVARCHAR(MAX), DELETED.numeroDocumento) + ', ' + 'Old_montoTotal: ' + CONVERT(NVARCHAR(MAX), DELETED.montoTotal) + ', ' + 'Old_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaCreacion) + ', ', 
           'New_idCompra: ' + CONVERT(NVARCHAR(MAX), INSERTED.idCompra) + ', ' + 'New_id_usuario: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_usuario) + ', ' + 'New_id_proveedor: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_proveedor) + ', ' + 'New_tipoDocumento: ' + CONVERT(NVARCHAR(MAX), INSERTED.tipoDocumento) + ', ' + 'New_numeroDocumento: ' + CONVERT(NVARCHAR(MAX), INSERTED.numeroDocumento) + ', ' + 'New_montoTotal: ' + CONVERT(NVARCHAR(MAX), INSERTED.montoTotal) + ', ' + 'New_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaCreacion) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED
    JOIN DELETED ON INSERTED.idCompra = DELETED.idCompra;
END;

CREATE TRIGGER trg_compraProductos_Delete
ON compraProductos
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, Timestamp, [User])
    SELECT 'compraProductos', 'DELETE', DELETED.idCompra, 
           'Old_idCompra: ' + CONVERT(NVARCHAR(MAX), DELETED.idCompra) + ', ' + 'Old_id_usuario: ' + CONVERT(NVARCHAR(MAX), DELETED.id_usuario) + ', ' + 'Old_id_proveedor: ' + CONVERT(NVARCHAR(MAX), DELETED.id_proveedor) + ', ' + 'Old_tipoDocumento: ' + CONVERT(NVARCHAR(MAX), DELETED.tipoDocumento) + ', ' + 'Old_numeroDocumento: ' + CONVERT(NVARCHAR(MAX), DELETED.numeroDocumento) + ', ' + 'Old_montoTotal: ' + CONVERT(NVARCHAR(MAX), DELETED.montoTotal) + ', ' + 'Old_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaCreacion) + ', ', GETDATE(), SYSTEM_USER
    FROM DELETED;
END;

-- Triggers for Descuento

CREATE TRIGGER trg_Descuento_Insert
ON Descuento
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, NewValues, Timestamp, [User])
    SELECT 'Descuento', 'INSERT', INSERTED.idDescuento, 
           'New_idDescuento: ' + CONVERT(NVARCHAR(MAX), INSERTED.idDescuento) + ', ' + 'New_descripcion: ' + CONVERT(NVARCHAR(MAX), INSERTED.descripcion) + ', ' + 'New_tipoDescuento: ' + CONVERT(NVARCHAR(MAX), INSERTED.tipoDescuento) + ', ' + 'New_valorDescuento: ' + CONVERT(NVARCHAR(MAX), INSERTED.valorDescuento) + ', ' + 'New_fechaInicio: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaInicio) + ', ' + 'New_fechaFin: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaFin) + ', ' + 'New_estado: ' + CONVERT(NVARCHAR(MAX), INSERTED.estado) + ', ' + 'New_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaCreacion) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED;
END;

CREATE TRIGGER trg_Descuento_Update
ON Descuento
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, NewValues, Timestamp, [User])
    SELECT 'Descuento', 'UPDATE', INSERTED.idDescuento, 
           'Old_idDescuento: ' + CONVERT(NVARCHAR(MAX), DELETED.idDescuento) + ', ' + 'Old_descripcion: ' + CONVERT(NVARCHAR(MAX), DELETED.descripcion) + ', ' + 'Old_tipoDescuento: ' + CONVERT(NVARCHAR(MAX), DELETED.tipoDescuento) + ', ' + 'Old_valorDescuento: ' + CONVERT(NVARCHAR(MAX), DELETED.valorDescuento) + ', ' + 'Old_fechaInicio: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaInicio) + ', ' + 'Old_fechaFin: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaFin) + ', ' + 'Old_estado: ' + CONVERT(NVARCHAR(MAX), DELETED.estado) + ', ' + 'Old_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaCreacion) + ', ', 
           'New_idDescuento: ' + CONVERT(NVARCHAR(MAX), INSERTED.idDescuento) + ', ' + 'New_descripcion: ' + CONVERT(NVARCHAR(MAX), INSERTED.descripcion) + ', ' + 'New_tipoDescuento: ' + CONVERT(NVARCHAR(MAX), INSERTED.tipoDescuento) + ', ' + 'New_valorDescuento: ' + CONVERT(NVARCHAR(MAX), INSERTED.valorDescuento) + ', ' + 'New_fechaInicio: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaInicio) + ', ' + 'New_fechaFin: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaFin) + ', ' + 'New_estado: ' + CONVERT(NVARCHAR(MAX), INSERTED.estado) + ', ' + 'New_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaCreacion) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED
    JOIN DELETED ON INSERTED.idDescuento = DELETED.idDescuento;
END;

CREATE TRIGGER trg_Descuento_Delete
ON Descuento
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, Timestamp, [User])
    SELECT 'Descuento', 'DELETE', DELETED.idDescuento, 
           'Old_idDescuento: ' + CONVERT(NVARCHAR(MAX), DELETED.idDescuento) + ', ' + 'Old_descripcion: ' + CONVERT(NVARCHAR(MAX), DELETED.descripcion) + ', ' + 'Old_tipoDescuento: ' + CONVERT(NVARCHAR(MAX), DELETED.tipoDescuento) + ', ' + 'Old_valorDescuento: ' + CONVERT(NVARCHAR(MAX), DELETED.valorDescuento) + ', ' + 'Old_fechaInicio: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaInicio) + ', ' + 'Old_fechaFin: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaFin) + ', ' + 'Old_estado: ' + CONVERT(NVARCHAR(MAX), DELETED.estado) + ', ' + 'Old_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaCreacion) + ', ', GETDATE(), SYSTEM_USER
    FROM DELETED;
END;

-- Triggers for detalleCompra

CREATE TRIGGER trg_detalleCompra_Insert
ON detalleCompra
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, NewValues, Timestamp, [User])
    SELECT 'detalleCompra', 'INSERT', INSERTED.idDetalleCompra, 
           'New_idDetalleCompra: ' + CONVERT(NVARCHAR(MAX), INSERTED.idDetalleCompra) + ', ' + 'New_id_compra: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_compra) + ', ' + 'New_id_producto: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_producto) + ', ' + 'New_precioCompra: ' + CONVERT(NVARCHAR(MAX), INSERTED.precioCompra) + ', ' + 'New_precioVenta: ' + CONVERT(NVARCHAR(MAX), INSERTED.precioVenta) + ', ' + 'New_cantidad: ' + CONVERT(NVARCHAR(MAX), INSERTED.cantidad) + ', ' + 'New_montoTotal: ' + CONVERT(NVARCHAR(MAX), INSERTED.montoTotal) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED;
END;

CREATE TRIGGER trg_detalleCompra_Update
ON detalleCompra
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, NewValues, Timestamp, [User])
    SELECT 'detalleCompra', 'UPDATE', INSERTED.idDetalleCompra, 
           'Old_idDetalleCompra: ' + CONVERT(NVARCHAR(MAX), DELETED.idDetalleCompra) + ', ' + 'Old_id_compra: ' + CONVERT(NVARCHAR(MAX), DELETED.id_compra) + ', ' + 'Old_id_producto: ' + CONVERT(NVARCHAR(MAX), DELETED.id_producto) + ', ' + 'Old_precioCompra: ' + CONVERT(NVARCHAR(MAX), DELETED.precioCompra) + ', ' + 'Old_precioVenta: ' + CONVERT(NVARCHAR(MAX), DELETED.precioVenta) + ', ' + 'Old_cantidad: ' + CONVERT(NVARCHAR(MAX), DELETED.cantidad) + ', ' + 'Old_montoTotal: ' + CONVERT(NVARCHAR(MAX), DELETED.montoTotal) + ', ', 
           'New_idDetalleCompra: ' + CONVERT(NVARCHAR(MAX), INSERTED.idDetalleCompra) + ', ' + 'New_id_compra: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_compra) + ', ' + 'New_id_producto: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_producto) + ', ' + 'New_precioCompra: ' + CONVERT(NVARCHAR(MAX), INSERTED.precioCompra) + ', ' + 'New_precioVenta: ' + CONVERT(NVARCHAR(MAX), INSERTED.precioVenta) + ', ' + 'New_cantidad: ' + CONVERT(NVARCHAR(MAX), INSERTED.cantidad) + ', ' + 'New_montoTotal: ' + CONVERT(NVARCHAR(MAX), INSERTED.montoTotal) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED
    JOIN DELETED ON INSERTED.idDetalleCompra = DELETED.idDetalleCompra;
END;

CREATE TRIGGER trg_detalleCompra_Delete
ON detalleCompra
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, Timestamp, [User])
    SELECT 'detalleCompra', 'DELETE', DELETED.idDetalleCompra, 
           'Old_idDetalleCompra: ' + CONVERT(NVARCHAR(MAX), DELETED.idDetalleCompra) + ', ' + 'Old_id_compra: ' + CONVERT(NVARCHAR(MAX), DELETED.id_compra) + ', ' + 'Old_id_producto: ' + CONVERT(NVARCHAR(MAX), DELETED.id_producto) + ', ' + 'Old_precioCompra: ' + CONVERT(NVARCHAR(MAX), DELETED.precioCompra) + ', ' + 'Old_precioVenta: ' + CONVERT(NVARCHAR(MAX), DELETED.precioVenta) + ', ' + 'Old_cantidad: ' + CONVERT(NVARCHAR(MAX), DELETED.cantidad) + ', ' + 'Old_montoTotal: ' + CONVERT(NVARCHAR(MAX), DELETED.montoTotal) + ', ', GETDATE(), SYSTEM_USER
    FROM DELETED;
END;

-- Triggers for DetalleDescuento

CREATE TRIGGER trg_DetalleDescuento_Insert
ON DetalleDescuento
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, NewValues, Timestamp, [User])
    SELECT 'DetalleDescuento', 'INSERT', INSERTED.idDetalleDescuento, 
           'New_idDetalleDescuento: ' + CONVERT(NVARCHAR(MAX), INSERTED.idDetalleDescuento) + ', ' + 'New_id_descuento: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_descuento) + ', ' + 'New_id_producto: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_producto) + ', ' + 'New_cantidadMinima: ' + CONVERT(NVARCHAR(MAX), INSERTED.cantidadMinima) + ', ' + 'New_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaCreacion) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED;
END;

CREATE TRIGGER trg_DetalleDescuento_Update
ON DetalleDescuento
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, NewValues, Timestamp, [User])
    SELECT 'DetalleDescuento', 'UPDATE', INSERTED.idDetalleDescuento, 
           'Old_idDetalleDescuento: ' + CONVERT(NVARCHAR(MAX), DELETED.idDetalleDescuento) + ', ' + 'Old_id_descuento: ' + CONVERT(NVARCHAR(MAX), DELETED.id_descuento) + ', ' + 'Old_id_producto: ' + CONVERT(NVARCHAR(MAX), DELETED.id_producto) + ', ' + 'Old_cantidadMinima: ' + CONVERT(NVARCHAR(MAX), DELETED.cantidadMinima) + ', ' + 'Old_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaCreacion) + ', ', 
           'New_idDetalleDescuento: ' + CONVERT(NVARCHAR(MAX), INSERTED.idDetalleDescuento) + ', ' + 'New_id_descuento: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_descuento) + ', ' + 'New_id_producto: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_producto) + ', ' + 'New_cantidadMinima: ' + CONVERT(NVARCHAR(MAX), INSERTED.cantidadMinima) + ', ' + 'New_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaCreacion) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED
    JOIN DELETED ON INSERTED.idDetalleDescuento = DELETED.idDetalleDescuento;
END;

CREATE TRIGGER trg_DetalleDescuento_Delete
ON DetalleDescuento
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, Timestamp, [User])
    SELECT 'DetalleDescuento', 'DELETE', DELETED.idDetalleDescuento, 
           'Old_idDetalleDescuento: ' + CONVERT(NVARCHAR(MAX), DELETED.idDetalleDescuento) + ', ' + 'Old_id_descuento: ' + CONVERT(NVARCHAR(MAX), DELETED.id_descuento) + ', ' + 'Old_id_producto: ' + CONVERT(NVARCHAR(MAX), DELETED.id_producto) + ', ' + 'Old_cantidadMinima: ' + CONVERT(NVARCHAR(MAX), DELETED.cantidadMinima) + ', ' + 'Old_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaCreacion) + ', ', GETDATE(), SYSTEM_USER
    FROM DELETED;
END;

-- Triggers for DetalleVenta

CREATE TRIGGER trg_DetalleVenta_Insert
ON DetalleVenta
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, NewValues, Timestamp, [User])
    SELECT 'DetalleVenta', 'INSERT', INSERTED.idDetalleVenta, 
           'New_idDetalleVenta: ' + CONVERT(NVARCHAR(MAX), INSERTED.idDetalleVenta) + ', ' + 'New_id_venta: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_venta) + ', ' + 'New_id_producto: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_producto) + ', ' + 'New_precioVenta: ' + CONVERT(NVARCHAR(MAX), INSERTED.precioVenta) + ', ' + 'New_cantidad: ' + CONVERT(NVARCHAR(MAX), INSERTED.cantidad) + ', ' + 'New_subtotal: ' + CONVERT(NVARCHAR(MAX), INSERTED.subtotal) + ', ' + 'New_fechaRegistro: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaRegistro) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED;
END;

CREATE TRIGGER trg_DetalleVenta_Update
ON DetalleVenta
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, NewValues, Timestamp, [User])
    SELECT 'DetalleVenta', 'UPDATE', INSERTED.idDetalleVenta, 
           'Old_idDetalleVenta: ' + CONVERT(NVARCHAR(MAX), DELETED.idDetalleVenta) + ', ' + 'Old_id_venta: ' + CONVERT(NVARCHAR(MAX), DELETED.id_venta) + ', ' + 'Old_id_producto: ' + CONVERT(NVARCHAR(MAX), DELETED.id_producto) + ', ' + 'Old_precioVenta: ' + CONVERT(NVARCHAR(MAX), DELETED.precioVenta) + ', ' + 'Old_cantidad: ' + CONVERT(NVARCHAR(MAX), DELETED.cantidad) + ', ' + 'Old_subtotal: ' + CONVERT(NVARCHAR(MAX), DELETED.subtotal) + ', ' + 'Old_fechaRegistro: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaRegistro) + ', ', 
           'New_idDetalleVenta: ' + CONVERT(NVARCHAR(MAX), INSERTED.idDetalleVenta) + ', ' + 'New_id_venta: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_venta) + ', ' + 'New_id_producto: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_producto) + ', ' + 'New_precioVenta: ' + CONVERT(NVARCHAR(MAX), INSERTED.precioVenta) + ', ' + 'New_cantidad: ' + CONVERT(NVARCHAR(MAX), INSERTED.cantidad) + ', ' + 'New_subtotal: ' + CONVERT(NVARCHAR(MAX), INSERTED.subtotal) + ', ' + 'New_fechaRegistro: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaRegistro) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED
    JOIN DELETED ON INSERTED.idDetalleVenta = DELETED.idDetalleVenta;
END;

CREATE TRIGGER trg_DetalleVenta_Delete
ON DetalleVenta
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, Timestamp, [User])
    SELECT 'DetalleVenta', 'DELETE', DELETED.idDetalleVenta, 
           'Old_idDetalleVenta: ' + CONVERT(NVARCHAR(MAX), DELETED.idDetalleVenta) + ', ' + 'Old_id_venta: ' + CONVERT(NVARCHAR(MAX), DELETED.id_venta) + ', ' + 'Old_id_producto: ' + CONVERT(NVARCHAR(MAX), DELETED.id_producto) + ', ' + 'Old_precioVenta: ' + CONVERT(NVARCHAR(MAX), DELETED.precioVenta) + ', ' + 'Old_cantidad: ' + CONVERT(NVARCHAR(MAX), DELETED.cantidad) + ', ' + 'Old_subtotal: ' + CONVERT(NVARCHAR(MAX), DELETED.subtotal) + ', ' + 'Old_fechaRegistro: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaRegistro) + ', ', GETDATE(), SYSTEM_USER
    FROM DELETED;
END;

-- Triggers for Devolucion

CREATE TRIGGER trg_Devolucion_Insert
ON Devolucion
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, NewValues, Timestamp, [User])
    SELECT 'Devolucion', 'INSERT', INSERTED.IdDevolucion, 
           'New_IdDevolucion: ' + CONVERT(NVARCHAR(MAX), INSERTED.IdDevolucion) + ', ' + 'New_id_venta: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_venta) + ', ' + 'New_fechaDevolucion: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaDevolucion) + ', ' + 'New_descripcion: ' + CONVERT(NVARCHAR(MAX), INSERTED.descripcion) + ', ' + 'New_estadoDevolucion: ' + CONVERT(NVARCHAR(MAX), INSERTED.estadoDevolucion) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED;
END;

CREATE TRIGGER trg_Devolucion_Update
ON Devolucion
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, NewValues, Timestamp, [User])
    SELECT 'Devolucion', 'UPDATE', INSERTED.IdDevolucion, 
           'Old_IdDevolucion: ' + CONVERT(NVARCHAR(MAX), DELETED.IdDevolucion) + ', ' + 'Old_id_venta: ' + CONVERT(NVARCHAR(MAX), DELETED.id_venta) + ', ' + 'Old_fechaDevolucion: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaDevolucion) + ', ' + 'Old_descripcion: ' + CONVERT(NVARCHAR(MAX), DELETED.descripcion) + ', ' + 'Old_estadoDevolucion: ' + CONVERT(NVARCHAR(MAX), DELETED.estadoDevolucion) + ', ', 
           'New_IdDevolucion: ' + CONVERT(NVARCHAR(MAX), INSERTED.IdDevolucion) + ', ' + 'New_id_venta: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_venta) + ', ' + 'New_fechaDevolucion: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaDevolucion) + ', ' + 'New_descripcion: ' + CONVERT(NVARCHAR(MAX), INSERTED.descripcion) + ', ' + 'New_estadoDevolucion: ' + CONVERT(NVARCHAR(MAX), INSERTED.estadoDevolucion) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED
    JOIN DELETED ON INSERTED.IdDevolucion = DELETED.IdDevolucion;
END;

CREATE TRIGGER trg_Devolucion_Delete
ON Devolucion
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, Timestamp, [User])
    SELECT 'Devolucion', 'DELETE', DELETED.IdDevolucion, 
           'Old_IdDevolucion: ' + CONVERT(NVARCHAR(MAX), DELETED.IdDevolucion) + ', ' + 'Old_id_venta: ' + CONVERT(NVARCHAR(MAX), DELETED.id_venta) + ', ' + 'Old_fechaDevolucion: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaDevolucion) + ', ' + 'Old_descripcion: ' + CONVERT(NVARCHAR(MAX), DELETED.descripcion) + ', ' + 'Old_estadoDevolucion: ' + CONVERT(NVARCHAR(MAX), DELETED.estadoDevolucion) + ', ', GETDATE(), SYSTEM_USER
    FROM DELETED;
END;

-- Triggers for Envio

CREATE TRIGGER trg_Envio_Insert
ON Envio
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, NewValues, Timestamp, [User])
    SELECT 'Envio', 'INSERT', INSERTED.idEnvio, 
           'New_idEnvio: ' + CONVERT(NVARCHAR(MAX), INSERTED.idEnvio) + ', ' + 'New_id_cliente: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_cliente) + ', ' + 'New_direccion: ' + CONVERT(NVARCHAR(MAX), INSERTED.direccion) + ', ' + 'New_fechaEnvio: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaEnvio) + ', ' + 'New_estadoEnvio: ' + CONVERT(NVARCHAR(MAX), INSERTED.estadoEnvio) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED;
END;

CREATE TRIGGER trg_Envio_Update
ON Envio
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, NewValues, Timestamp, [User])
    SELECT 'Envio', 'UPDATE', INSERTED.idEnvio, 
           'Old_idEnvio: ' + CONVERT(NVARCHAR(MAX), DELETED.idEnvio) + ', ' + 'Old_id_cliente: ' + CONVERT(NVARCHAR(MAX), DELETED.id_cliente) + ', ' + 'Old_direccion: ' + CONVERT(NVARCHAR(MAX), DELETED.direccion) + ', ' + 'Old_fechaEnvio: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaEnvio) + ', ' + 'Old_estadoEnvio: ' + CONVERT(NVARCHAR(MAX), DELETED.estadoEnvio) + ', ', 
           'New_idEnvio: ' + CONVERT(NVARCHAR(MAX), INSERTED.idEnvio) + ', ' + 'New_id_cliente: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_cliente) + ', ' + 'New_direccion: ' + CONVERT(NVARCHAR(MAX), INSERTED.direccion) + ', ' + 'New_fechaEnvio: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaEnvio) + ', ' + 'New_estadoEnvio: ' + CONVERT(NVARCHAR(MAX), INSERTED.estadoEnvio) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED
    JOIN DELETED ON INSERTED.idEnvio = DELETED.idEnvio;
END;

CREATE TRIGGER trg_Envio_Delete
ON Envio
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, Timestamp, [User])
    SELECT 'Envio', 'DELETE', DELETED.idEnvio, 
           'Old_idEnvio: ' + CONVERT(NVARCHAR(MAX), DELETED.idEnvio) + ', ' + 'Old_id_cliente: ' + CONVERT(NVARCHAR(MAX), DELETED.id_cliente) + ', ' + 'Old_direccion: ' + CONVERT(NVARCHAR(MAX), DELETED.direccion) + ', ' + 'Old_fechaEnvio: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaEnvio) + ', ' + 'Old_estadoEnvio: ' + CONVERT(NVARCHAR(MAX), DELETED.estadoEnvio) + ', ', GETDATE(), SYSTEM_USER
    FROM DELETED;
END;

-- Triggers for Factura

CREATE TRIGGER trg_Factura_Insert
ON Factura
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, NewValues, Timestamp, [User])
    SELECT 'Factura', 'INSERT', INSERTED.idFactura, 
           'New_idFactura: ' + CONVERT(NVARCHAR(MAX), INSERTED.idFactura) + ', ' + 'New_id_Venta: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_Venta) + ', ' + 'New_numeroFactura: ' + CONVERT(NVARCHAR(MAX), INSERTED.numeroFactura) + ', ' + 'New_fechaEmision: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaEmision) + ', ' + 'New_total: ' + CONVERT(NVARCHAR(MAX), INSERTED.total) + ', ' + 'New_estado: ' + CONVERT(NVARCHAR(MAX), INSERTED.estado) + ', ' + 'New_observaciones: ' + CONVERT(NVARCHAR(MAX), INSERTED.observaciones) + ', ' + 'New_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaCreacion) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED;
END;

CREATE TRIGGER trg_Factura_Update
ON Factura
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, NewValues, Timestamp, [User])
    SELECT 'Factura', 'UPDATE', INSERTED.idFactura, 
           'Old_idFactura: ' + CONVERT(NVARCHAR(MAX), DELETED.idFactura) + ', ' + 'Old_id_Venta: ' + CONVERT(NVARCHAR(MAX), DELETED.id_Venta) + ', ' + 'Old_numeroFactura: ' + CONVERT(NVARCHAR(MAX), DELETED.numeroFactura) + ', ' + 'Old_fechaEmision: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaEmision) + ', ' + 'Old_total: ' + CONVERT(NVARCHAR(MAX), DELETED.total) + ', ' + 'Old_estado: ' + CONVERT(NVARCHAR(MAX), DELETED.estado) + ', ' + 'Old_observaciones: ' + CONVERT(NVARCHAR(MAX), DELETED.observaciones) + ', ' + 'Old_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaCreacion) + ', ', 
           'New_idFactura: ' + CONVERT(NVARCHAR(MAX), INSERTED.idFactura) + ', ' + 'New_id_Venta: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_Venta) + ', ' + 'New_numeroFactura: ' + CONVERT(NVARCHAR(MAX), INSERTED.numeroFactura) + ', ' + 'New_fechaEmision: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaEmision) + ', ' + 'New_total: ' + CONVERT(NVARCHAR(MAX), INSERTED.total) + ', ' + 'New_estado: ' + CONVERT(NVARCHAR(MAX), INSERTED.estado) + ', ' + 'New_observaciones: ' + CONVERT(NVARCHAR(MAX), INSERTED.observaciones) + ', ' + 'New_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaCreacion) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED
    JOIN DELETED ON INSERTED.idFactura = DELETED.idFactura;
END;

CREATE TRIGGER trg_Factura_Delete
ON Factura
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, Timestamp, [User])
    SELECT 'Factura', 'DELETE', DELETED.idFactura, 
           'Old_idFactura: ' + CONVERT(NVARCHAR(MAX), DELETED.idFactura) + ', ' + 'Old_id_Venta: ' + CONVERT(NVARCHAR(MAX), DELETED.id_Venta) + ', ' + 'Old_numeroFactura: ' + CONVERT(NVARCHAR(MAX), DELETED.numeroFactura) + ', ' + 'Old_fechaEmision: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaEmision) + ', ' + 'Old_total: ' + CONVERT(NVARCHAR(MAX), DELETED.total) + ', ' + 'Old_estado: ' + CONVERT(NVARCHAR(MAX), DELETED.estado) + ', ' + 'Old_observaciones: ' + CONVERT(NVARCHAR(MAX), DELETED.observaciones) + ', ' + 'Old_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaCreacion) + ', ', GETDATE(), SYSTEM_USER
    FROM DELETED;
END;

-- Triggers for FormaPago

CREATE TRIGGER trg_FormaPago_Insert
ON FormaPago
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, NewValues, Timestamp, [User])
    SELECT 'FormaPago', 'INSERT', INSERTED.idFormaPago, 
           'New_idFormaPago: ' + CONVERT(NVARCHAR(MAX), INSERTED.idFormaPago) + ', ' + 'New_id_Venta: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_Venta) + ', ' + 'New_nombre: ' + CONVERT(NVARCHAR(MAX), INSERTED.nombre) + ', ' + 'New_descripcion: ' + CONVERT(NVARCHAR(MAX), INSERTED.descripcion) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED;
END;

CREATE TRIGGER trg_FormaPago_Update
ON FormaPago
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, NewValues, Timestamp, [User])
    SELECT 'FormaPago', 'UPDATE', INSERTED.idFormaPago, 
           'Old_idFormaPago: ' + CONVERT(NVARCHAR(MAX), DELETED.idFormaPago) + ', ' + 'Old_id_Venta: ' + CONVERT(NVARCHAR(MAX), DELETED.id_Venta) + ', ' + 'Old_nombre: ' + CONVERT(NVARCHAR(MAX), DELETED.nombre) + ', ' + 'Old_descripcion: ' + CONVERT(NVARCHAR(MAX), DELETED.descripcion) + ', ', 
           'New_idFormaPago: ' + CONVERT(NVARCHAR(MAX), INSERTED.idFormaPago) + ', ' + 'New_id_Venta: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_Venta) + ', ' + 'New_nombre: ' + CONVERT(NVARCHAR(MAX), INSERTED.nombre) + ', ' + 'New_descripcion: ' + CONVERT(NVARCHAR(MAX), INSERTED.descripcion) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED
    JOIN DELETED ON INSERTED.idFormaPago = DELETED.idFormaPago;
END;

CREATE TRIGGER trg_FormaPago_Delete
ON FormaPago
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, Timestamp, [User])
    SELECT 'FormaPago', 'DELETE', DELETED.idFormaPago, 
           'Old_idFormaPago: ' + CONVERT(NVARCHAR(MAX), DELETED.idFormaPago) + ', ' + 'Old_id_Venta: ' + CONVERT(NVARCHAR(MAX), DELETED.id_Venta) + ', ' + 'Old_nombre: ' + CONVERT(NVARCHAR(MAX), DELETED.nombre) + ', ' + 'Old_descripcion: ' + CONVERT(NVARCHAR(MAX), DELETED.descripcion) + ', ', GETDATE(), SYSTEM_USER
    FROM DELETED;
END;

-- Triggers for HistorialCliente

CREATE TRIGGER trg_HistorialCliente_Insert
ON HistorialCliente
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, NewValues, Timestamp, [User])
    SELECT 'HistorialCliente', 'INSERT', INSERTED.idHistorial, 
           'New_idHistorial: ' + CONVERT(NVARCHAR(MAX), INSERTED.idHistorial) + ', ' + 'New_id_factura: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_factura) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED;
END;

CREATE TRIGGER trg_HistorialCliente_Update
ON HistorialCliente
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, NewValues, Timestamp, [User])
    SELECT 'HistorialCliente', 'UPDATE', INSERTED.idHistorial, 
           'Old_idHistorial: ' + CONVERT(NVARCHAR(MAX), DELETED.idHistorial) + ', ' + 'Old_id_factura: ' + CONVERT(NVARCHAR(MAX), DELETED.id_factura) + ', ', 
           'New_idHistorial: ' + CONVERT(NVARCHAR(MAX), INSERTED.idHistorial) + ', ' + 'New_id_factura: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_factura) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED
    JOIN DELETED ON INSERTED.idHistorial = DELETED.idHistorial;
END;

CREATE TRIGGER trg_HistorialCliente_Delete
ON HistorialCliente
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, Timestamp, [User])
    SELECT 'HistorialCliente', 'DELETE', DELETED.idHistorial, 
           'Old_idHistorial: ' + CONVERT(NVARCHAR(MAX), DELETED.idHistorial) + ', ' + 'Old_id_factura: ' + CONVERT(NVARCHAR(MAX), DELETED.id_factura) + ', ', GETDATE(), SYSTEM_USER
    FROM DELETED;
END;

-- Triggers for Inventario

CREATE TRIGGER trg_Inventario_Insert
ON Inventario
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, NewValues, Timestamp, [User])
    SELECT 'Inventario', 'INSERT', INSERTED.idInventario, 
           'New_idInventario: ' + CONVERT(NVARCHAR(MAX), INSERTED.idInventario) + ', ' + 'New_nombre: ' + CONVERT(NVARCHAR(MAX), INSERTED.nombre) + ', ' + 'New_cantidad: ' + CONVERT(NVARCHAR(MAX), INSERTED.cantidad) + ', ' + 'New_precio: ' + CONVERT(NVARCHAR(MAX), INSERTED.precio) + ', ' + 'New_categoria: ' + CONVERT(NVARCHAR(MAX), INSERTED.categoria) + ', ' + 'New_proveedor: ' + CONVERT(NVARCHAR(MAX), INSERTED.proveedor) + ', ' + 'New_fecha_entrada: ' + CONVERT(NVARCHAR(MAX), INSERTED.fecha_entrada) + ', ' + 'New_ubicacion_almacen: ' + CONVERT(NVARCHAR(MAX), INSERTED.ubicacion_almacen) + ', ' + 'New_estado: ' + CONVERT(NVARCHAR(MAX), INSERTED.estado) + ', ' + 'New_notas: ' + CONVERT(NVARCHAR(MAX), INSERTED.notas) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED;
END;

CREATE TRIGGER trg_Inventario_Update
ON Inventario
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, NewValues, Timestamp, [User])
    SELECT 'Inventario', 'UPDATE', INSERTED.idInventario, 
           'Old_idInventario: ' + CONVERT(NVARCHAR(MAX), DELETED.idInventario) + ', ' + 'Old_nombre: ' + CONVERT(NVARCHAR(MAX), DELETED.nombre) + ', ' + 'Old_cantidad: ' + CONVERT(NVARCHAR(MAX), DELETED.cantidad) + ', ' + 'Old_precio: ' + CONVERT(NVARCHAR(MAX), DELETED.precio) + ', ' + 'Old_categoria: ' + CONVERT(NVARCHAR(MAX), DELETED.categoria) + ', ' + 'Old_proveedor: ' + CONVERT(NVARCHAR(MAX), DELETED.proveedor) + ', ' + 'Old_fecha_entrada: ' + CONVERT(NVARCHAR(MAX), DELETED.fecha_entrada) + ', ' + 'Old_ubicacion_almacen: ' + CONVERT(NVARCHAR(MAX), DELETED.ubicacion_almacen) + ', ' + 'Old_estado: ' + CONVERT(NVARCHAR(MAX), DELETED.estado) + ', ' + 'Old_notas: ' + CONVERT(NVARCHAR(MAX), DELETED.notas) + ', ', 
           'New_idInventario: ' + CONVERT(NVARCHAR(MAX), INSERTED.idInventario) + ', ' + 'New_nombre: ' + CONVERT(NVARCHAR(MAX), INSERTED.nombre) + ', ' + 'New_cantidad: ' + CONVERT(NVARCHAR(MAX), INSERTED.cantidad) + ', ' + 'New_precio: ' + CONVERT(NVARCHAR(MAX), INSERTED.precio) + ', ' + 'New_categoria: ' + CONVERT(NVARCHAR(MAX), INSERTED.categoria) + ', ' + 'New_proveedor: ' + CONVERT(NVARCHAR(MAX), INSERTED.proveedor) + ', ' + 'New_fecha_entrada: ' + CONVERT(NVARCHAR(MAX), INSERTED.fecha_entrada) + ', ' + 'New_ubicacion_almacen: ' + CONVERT(NVARCHAR(MAX), INSERTED.ubicacion_almacen) + ', ' + 'New_estado: ' + CONVERT(NVARCHAR(MAX), INSERTED.estado) + ', ' + 'New_notas: ' + CONVERT(NVARCHAR(MAX), INSERTED.notas) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED
    JOIN DELETED ON INSERTED.idInventario = DELETED.idInventario;
END;

CREATE TRIGGER trg_Inventario_Delete
ON Inventario
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, Timestamp, [User])
    SELECT 'Inventario', 'DELETE', DELETED.idInventario, 
           'Old_idInventario: ' + CONVERT(NVARCHAR(MAX), DELETED.idInventario) + ', ' + 'Old_nombre: ' + CONVERT(NVARCHAR(MAX), DELETED.nombre) + ', ' + 'Old_cantidad: ' + CONVERT(NVARCHAR(MAX), DELETED.cantidad) + ', ' + 'Old_precio: ' + CONVERT(NVARCHAR(MAX), DELETED.precio) + ', ' + 'Old_categoria: ' + CONVERT(NVARCHAR(MAX), DELETED.categoria) + ', ' + 'Old_proveedor: ' + CONVERT(NVARCHAR(MAX), DELETED.proveedor) + ', ' + 'Old_fecha_entrada: ' + CONVERT(NVARCHAR(MAX), DELETED.fecha_entrada) + ', ' + 'Old_ubicacion_almacen: ' + CONVERT(NVARCHAR(MAX), DELETED.ubicacion_almacen) + ', ' + 'Old_estado: ' + CONVERT(NVARCHAR(MAX), DELETED.estado) + ', ' + 'Old_notas: ' + CONVERT(NVARCHAR(MAX), DELETED.notas) + ', ', GETDATE(), SYSTEM_USER
    FROM DELETED;
END;

-- Triggers for permiso

CREATE TRIGGER trg_permiso_Insert
ON permiso
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, NewValues, Timestamp, [User])
    SELECT 'permiso', 'INSERT', INSERTED.idPermiso, 
           'New_idPermiso: ' + CONVERT(NVARCHAR(MAX), INSERTED.idPermiso) + ', ' + 'New_id_rol: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_rol) + ', ' + 'New_descripcion: ' + CONVERT(NVARCHAR(MAX), INSERTED.descripcion) + ', ' + 'New_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaCreacion) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED;
END;

CREATE TRIGGER trg_permiso_Update
ON permiso
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, NewValues, Timestamp, [User])
    SELECT 'permiso', 'UPDATE', INSERTED.idPermiso, 
           'Old_idPermiso: ' + CONVERT(NVARCHAR(MAX), DELETED.idPermiso) + ', ' + 'Old_id_rol: ' + CONVERT(NVARCHAR(MAX), DELETED.id_rol) + ', ' + 'Old_descripcion: ' + CONVERT(NVARCHAR(MAX), DELETED.descripcion) + ', ' + 'Old_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaCreacion) + ', ', 
           'New_idPermiso: ' + CONVERT(NVARCHAR(MAX), INSERTED.idPermiso) + ', ' + 'New_id_rol: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_rol) + ', ' + 'New_descripcion: ' + CONVERT(NVARCHAR(MAX), INSERTED.descripcion) + ', ' + 'New_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaCreacion) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED
    JOIN DELETED ON INSERTED.idPermiso = DELETED.idPermiso;
END;

CREATE TRIGGER trg_permiso_Delete
ON permiso
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, Timestamp, [User])
    SELECT 'permiso', 'DELETE', DELETED.idPermiso, 
           'Old_idPermiso: ' + CONVERT(NVARCHAR(MAX), DELETED.idPermiso) + ', ' + 'Old_id_rol: ' + CONVERT(NVARCHAR(MAX), DELETED.id_rol) + ', ' + 'Old_descripcion: ' + CONVERT(NVARCHAR(MAX), DELETED.descripcion) + ', ' + 'Old_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaCreacion) + ', ', GETDATE(), SYSTEM_USER
    FROM DELETED;
END;

-- Triggers for Producto

CREATE TRIGGER trg_Producto_Insert
ON Producto
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, NewValues, Timestamp, [User])
    SELECT 'Producto', 'INSERT', INSERTED.IdProducto, 
           'New_IdProducto: ' + CONVERT(NVARCHAR(MAX), INSERTED.IdProducto) + ', ' + 'New_Id_descuento: ' + CONVERT(NVARCHAR(MAX), INSERTED.Id_descuento) + ', ' + 'New_id_inventario: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_inventario) + ', ' + 'New_codigo: ' + CONVERT(NVARCHAR(MAX), INSERTED.codigo) + ', ' + 'New_nombre: ' + CONVERT(NVARCHAR(MAX), INSERTED.nombre) + ', ' + 'New_descripcion: ' + CONVERT(NVARCHAR(MAX), INSERTED.descripcion) + ', ' + 'New_id_categoria: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_categoria) + ', ' + 'New_stock: ' + CONVERT(NVARCHAR(MAX), INSERTED.stock) + ', ' + 'New_precioCompra: ' + CONVERT(NVARCHAR(MAX), INSERTED.precioCompra) + ', ' + 'New_precioVenta: ' + CONVERT(NVARCHAR(MAX), INSERTED.precioVenta) + ', ' + 'New_estado: ' + CONVERT(NVARCHAR(MAX), INSERTED.estado) + ', ' + 'New_fechaRegistro: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaRegistro) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED;
END;

CREATE TRIGGER trg_Producto_Update
ON Producto
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, NewValues, Timestamp, [User])
    SELECT 'Producto', 'UPDATE', INSERTED.IdProducto, 
           'Old_IdProducto: ' + CONVERT(NVARCHAR(MAX), DELETED.IdProducto) + ', ' + 'Old_Id_descuento: ' + CONVERT(NVARCHAR(MAX), DELETED.Id_descuento) + ', ' + 'Old_id_inventario: ' + CONVERT(NVARCHAR(MAX), DELETED.id_inventario) + ', ' + 'Old_codigo: ' + CONVERT(NVARCHAR(MAX), DELETED.codigo) + ', ' + 'Old_nombre: ' + CONVERT(NVARCHAR(MAX), DELETED.nombre) + ', ' + 'Old_descripcion: ' + CONVERT(NVARCHAR(MAX), DELETED.descripcion) + ', ' + 'Old_id_categoria: ' + CONVERT(NVARCHAR(MAX), DELETED.id_categoria) + ', ' + 'Old_stock: ' + CONVERT(NVARCHAR(MAX), DELETED.stock) + ', ' + 'Old_precioCompra: ' + CONVERT(NVARCHAR(MAX), DELETED.precioCompra) + ', ' + 'Old_precioVenta: ' + CONVERT(NVARCHAR(MAX), DELETED.precioVenta) + ', ' + 'Old_estado: ' + CONVERT(NVARCHAR(MAX), DELETED.estado) + ', ' + 'Old_fechaRegistro: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaRegistro) + ', ', 
           'New_IdProducto: ' + CONVERT(NVARCHAR(MAX), INSERTED.IdProducto) + ', ' + 'New_Id_descuento: ' + CONVERT(NVARCHAR(MAX), INSERTED.Id_descuento) + ', ' + 'New_id_inventario: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_inventario) + ', ' + 'New_codigo: ' + CONVERT(NVARCHAR(MAX), INSERTED.codigo) + ', ' + 'New_nombre: ' + CONVERT(NVARCHAR(MAX), INSERTED.nombre) + ', ' + 'New_descripcion: ' + CONVERT(NVARCHAR(MAX), INSERTED.descripcion) + ', ' + 'New_id_categoria: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_categoria) + ', ' + 'New_stock: ' + CONVERT(NVARCHAR(MAX), INSERTED.stock) + ', ' + 'New_precioCompra: ' + CONVERT(NVARCHAR(MAX), INSERTED.precioCompra) + ', ' + 'New_precioVenta: ' + CONVERT(NVARCHAR(MAX), INSERTED.precioVenta) + ', ' + 'New_estado: ' + CONVERT(NVARCHAR(MAX), INSERTED.estado) + ', ' + 'New_fechaRegistro: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaRegistro) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED
    JOIN DELETED ON INSERTED.IdProducto = DELETED.IdProducto;
END;

CREATE TRIGGER trg_Producto_Delete
ON Producto
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, Timestamp, [User])
    SELECT 'Producto', 'DELETE', DELETED.IdProducto, 
           'Old_IdProducto: ' + CONVERT(NVARCHAR(MAX), DELETED.IdProducto) + ', ' + 'Old_Id_descuento: ' + CONVERT(NVARCHAR(MAX), DELETED.Id_descuento) + ', ' + 'Old_id_inventario: ' + CONVERT(NVARCHAR(MAX), DELETED.id_inventario) + ', ' + 'Old_codigo: ' + CONVERT(NVARCHAR(MAX), DELETED.codigo) + ', ' + 'Old_nombre: ' + CONVERT(NVARCHAR(MAX), DELETED.nombre) + ', ' + 'Old_descripcion: ' + CONVERT(NVARCHAR(MAX), DELETED.descripcion) + ', ' + 'Old_id_categoria: ' + CONVERT(NVARCHAR(MAX), DELETED.id_categoria) + ', ' + 'Old_stock: ' + CONVERT(NVARCHAR(MAX), DELETED.stock) + ', ' + 'Old_precioCompra: ' + CONVERT(NVARCHAR(MAX), DELETED.precioCompra) + ', ' + 'Old_precioVenta: ' + CONVERT(NVARCHAR(MAX), DELETED.precioVenta) + ', ' + 'Old_estado: ' + CONVERT(NVARCHAR(MAX), DELETED.estado) + ', ' + 'Old_fechaRegistro: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaRegistro) + ', ', GETDATE(), SYSTEM_USER
    FROM DELETED;
END;

-- Triggers for proveedor

CREATE TRIGGER trg_proveedor_Insert
ON proveedor
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, NewValues, Timestamp, [User])
    SELECT 'proveedor', 'INSERT', INSERTED.idProveedor, 
           'New_idProveedor: ' + CONVERT(NVARCHAR(MAX), INSERTED.idProveedor) + ', ' + 'New_cedula: ' + CONVERT(NVARCHAR(MAX), INSERTED.cedula) + ', ' + 'New_razonSocial: ' + CONVERT(NVARCHAR(MAX), INSERTED.razonSocial) + ', ' + 'New_correo: ' + CONVERT(NVARCHAR(MAX), INSERTED.correo) + ', ' + 'New_telefono: ' + CONVERT(NVARCHAR(MAX), INSERTED.telefono) + ', ' + 'New_estado: ' + CONVERT(NVARCHAR(MAX), INSERTED.estado) + ', ' + 'New_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaCreacion) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED;
END;

CREATE TRIGGER trg_proveedor_Update
ON proveedor
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, NewValues, Timestamp, [User])
    SELECT 'proveedor', 'UPDATE', INSERTED.idProveedor, 
           'Old_idProveedor: ' + CONVERT(NVARCHAR(MAX), DELETED.idProveedor) + ', ' + 'Old_cedula: ' + CONVERT(NVARCHAR(MAX), DELETED.cedula) + ', ' + 'Old_razonSocial: ' + CONVERT(NVARCHAR(MAX), DELETED.razonSocial) + ', ' + 'Old_correo: ' + CONVERT(NVARCHAR(MAX), DELETED.correo) + ', ' + 'Old_telefono: ' + CONVERT(NVARCHAR(MAX), DELETED.telefono) + ', ' + 'Old_estado: ' + CONVERT(NVARCHAR(MAX), DELETED.estado) + ', ' + 'Old_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaCreacion) + ', ', 
           'New_idProveedor: ' + CONVERT(NVARCHAR(MAX), INSERTED.idProveedor) + ', ' + 'New_cedula: ' + CONVERT(NVARCHAR(MAX), INSERTED.cedula) + ', ' + 'New_razonSocial: ' + CONVERT(NVARCHAR(MAX), INSERTED.razonSocial) + ', ' + 'New_correo: ' + CONVERT(NVARCHAR(MAX), INSERTED.correo) + ', ' + 'New_telefono: ' + CONVERT(NVARCHAR(MAX), INSERTED.telefono) + ', ' + 'New_estado: ' + CONVERT(NVARCHAR(MAX), INSERTED.estado) + ', ' + 'New_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaCreacion) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED
    JOIN DELETED ON INSERTED.idProveedor = DELETED.idProveedor;
END;

CREATE TRIGGER trg_proveedor_Delete
ON proveedor
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, Timestamp, [User])
    SELECT 'proveedor', 'DELETE', DELETED.idProveedor, 
           'Old_idProveedor: ' + CONVERT(NVARCHAR(MAX), DELETED.idProveedor) + ', ' + 'Old_cedula: ' + CONVERT(NVARCHAR(MAX), DELETED.cedula) + ', ' + 'Old_razonSocial: ' + CONVERT(NVARCHAR(MAX), DELETED.razonSocial) + ', ' + 'Old_correo: ' + CONVERT(NVARCHAR(MAX), DELETED.correo) + ', ' + 'Old_telefono: ' + CONVERT(NVARCHAR(MAX), DELETED.telefono) + ', ' + 'Old_estado: ' + CONVERT(NVARCHAR(MAX), DELETED.estado) + ', ' + 'Old_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaCreacion) + ', ', GETDATE(), SYSTEM_USER
    FROM DELETED;
END;

-- Triggers for rol

CREATE TRIGGER trg_rol_Insert
ON rol
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, NewValues, Timestamp, [User])
    SELECT 'rol', 'INSERT', INSERTED.idRol, 
           'New_idRol: ' + CONVERT(NVARCHAR(MAX), INSERTED.idRol) + ', ' + 'New_nombre: ' + CONVERT(NVARCHAR(MAX), INSERTED.nombre) + ', ' + 'New_fechaRegistro: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaRegistro) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED;
END;

CREATE TRIGGER trg_rol_Update
ON rol
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, NewValues, Timestamp, [User])
    SELECT 'rol', 'UPDATE', INSERTED.idRol, 
           'Old_idRol: ' + CONVERT(NVARCHAR(MAX), DELETED.idRol) + ', ' + 'Old_nombre: ' + CONVERT(NVARCHAR(MAX), DELETED.nombre) + ', ' + 'Old_fechaRegistro: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaRegistro) + ', ', 
           'New_idRol: ' + CONVERT(NVARCHAR(MAX), INSERTED.idRol) + ', ' + 'New_nombre: ' + CONVERT(NVARCHAR(MAX), INSERTED.nombre) + ', ' + 'New_fechaRegistro: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaRegistro) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED
    JOIN DELETED ON INSERTED.idRol = DELETED.idRol;
END;

CREATE TRIGGER trg_rol_Delete
ON rol
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, Timestamp, [User])
    SELECT 'rol', 'DELETE', DELETED.idRol, 
           'Old_idRol: ' + CONVERT(NVARCHAR(MAX), DELETED.idRol) + ', ' + 'Old_nombre: ' + CONVERT(NVARCHAR(MAX), DELETED.nombre) + ', ' + 'Old_fechaRegistro: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaRegistro) + ', ', GETDATE(), SYSTEM_USER
    FROM DELETED;
END;

-- Triggers for usuario

CREATE TRIGGER trg_usuario_Insert
ON usuario
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, NewValues, Timestamp, [User])
    SELECT 'usuario', 'INSERT', INSERTED.idUsuario, 
           'New_idUsuario: ' + CONVERT(NVARCHAR(MAX), INSERTED.idUsuario) + ', ' + 'New_id_rol: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_rol) + ', ' + 'New_cedula: ' + CONVERT(NVARCHAR(MAX), INSERTED.cedula) + ', ' + 'New_nombreCompleto: ' + CONVERT(NVARCHAR(MAX), INSERTED.nombreCompleto) + ', ' + 'New_correo: ' + CONVERT(NVARCHAR(MAX), INSERTED.correo) + ', ' + 'New_clave: ' + CONVERT(NVARCHAR(MAX), INSERTED.clave) + ', ' + 'New_telefono: ' + CONVERT(NVARCHAR(MAX), INSERTED.telefono) + ', ' + 'New_estado: ' + CONVERT(NVARCHAR(MAX), INSERTED.estado) + ', ' + 'New_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaCreacion) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED;
END;

CREATE TRIGGER trg_usuario_Update
ON usuario
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, NewValues, Timestamp, [User])
    SELECT 'usuario', 'UPDATE', INSERTED.idUsuario, 
           'Old_idUsuario: ' + CONVERT(NVARCHAR(MAX), DELETED.idUsuario) + ', ' + 'Old_id_rol: ' + CONVERT(NVARCHAR(MAX), DELETED.id_rol) + ', ' + 'Old_cedula: ' + CONVERT(NVARCHAR(MAX), DELETED.cedula) + ', ' + 'Old_nombreCompleto: ' + CONVERT(NVARCHAR(MAX), DELETED.nombreCompleto) + ', ' + 'Old_correo: ' + CONVERT(NVARCHAR(MAX), DELETED.correo) + ', ' + 'Old_clave: ' + CONVERT(NVARCHAR(MAX), DELETED.clave) + ', ' + 'Old_telefono: ' + CONVERT(NVARCHAR(MAX), DELETED.telefono) + ', ' + 'Old_estado: ' + CONVERT(NVARCHAR(MAX), DELETED.estado) + ', ' + 'Old_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaCreacion) + ', ', 
           'New_idUsuario: ' + CONVERT(NVARCHAR(MAX), INSERTED.idUsuario) + ', ' + 'New_id_rol: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_rol) + ', ' + 'New_cedula: ' + CONVERT(NVARCHAR(MAX), INSERTED.cedula) + ', ' + 'New_nombreCompleto: ' + CONVERT(NVARCHAR(MAX), INSERTED.nombreCompleto) + ', ' + 'New_correo: ' + CONVERT(NVARCHAR(MAX), INSERTED.correo) + ', ' + 'New_clave: ' + CONVERT(NVARCHAR(MAX), INSERTED.clave) + ', ' + 'New_telefono: ' + CONVERT(NVARCHAR(MAX), INSERTED.telefono) + ', ' + 'New_estado: ' + CONVERT(NVARCHAR(MAX), INSERTED.estado) + ', ' + 'New_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaCreacion) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED
    JOIN DELETED ON INSERTED.idUsuario = DELETED.idUsuario;
END;

CREATE TRIGGER trg_usuario_Delete
ON usuario
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, Timestamp, [User])
    SELECT 'usuario', 'DELETE', DELETED.idUsuario, 
           'Old_idUsuario: ' + CONVERT(NVARCHAR(MAX), DELETED.idUsuario) + ', ' + 'Old_id_rol: ' + CONVERT(NVARCHAR(MAX), DELETED.id_rol) + ', ' + 'Old_cedula: ' + CONVERT(NVARCHAR(MAX), DELETED.cedula) + ', ' + 'Old_nombreCompleto: ' + CONVERT(NVARCHAR(MAX), DELETED.nombreCompleto) + ', ' + 'Old_correo: ' + CONVERT(NVARCHAR(MAX), DELETED.correo) + ', ' + 'Old_clave: ' + CONVERT(NVARCHAR(MAX), DELETED.clave) + ', ' + 'Old_telefono: ' + CONVERT(NVARCHAR(MAX), DELETED.telefono) + ', ' + 'Old_estado: ' + CONVERT(NVARCHAR(MAX), DELETED.estado) + ', ' + 'Old_fechaCreacion: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaCreacion) + ', ', GETDATE(), SYSTEM_USER
    FROM DELETED;
END;

-- Triggers for venta

CREATE TRIGGER trg_venta_Insert
ON venta
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, NewValues, Timestamp, [User])
    SELECT 'venta', 'INSERT', INSERTED.idVenta, 
           'New_idVenta: ' + CONVERT(NVARCHAR(MAX), INSERTED.idVenta) + ', ' + 'New_id_usuario: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_usuario) + ', ' + 'New_id_cliente: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_cliente) + ', ' + 'New_tipoDocumento: ' + CONVERT(NVARCHAR(MAX), INSERTED.tipoDocumento) + ', ' + 'New_numeroDocumento: ' + CONVERT(NVARCHAR(MAX), INSERTED.numeroDocumento) + ', ' + 'New_documentoCliente: ' + CONVERT(NVARCHAR(MAX), INSERTED.documentoCliente) + ', ' + 'New_nombreCliente: ' + CONVERT(NVARCHAR(MAX), INSERTED.nombreCliente) + ', ' + 'New_montoPago: ' + CONVERT(NVARCHAR(MAX), INSERTED.montoPago) + ', ' + 'New_montoCambio: ' + CONVERT(NVARCHAR(MAX), INSERTED.montoCambio) + ', ' + 'New_montoTotal: ' + CONVERT(NVARCHAR(MAX), INSERTED.montoTotal) + ', ' + 'New_fechaRegistro: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaRegistro) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED;
END;

CREATE TRIGGER trg_venta_Update
ON venta
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, NewValues, Timestamp, [User])
    SELECT 'venta', 'UPDATE', INSERTED.idVenta, 
           'Old_idVenta: ' + CONVERT(NVARCHAR(MAX), DELETED.idVenta) + ', ' + 'Old_id_usuario: ' + CONVERT(NVARCHAR(MAX), DELETED.id_usuario) + ', ' + 'Old_id_cliente: ' + CONVERT(NVARCHAR(MAX), DELETED.id_cliente) + ', ' + 'Old_tipoDocumento: ' + CONVERT(NVARCHAR(MAX), DELETED.tipoDocumento) + ', ' + 'Old_numeroDocumento: ' + CONVERT(NVARCHAR(MAX), DELETED.numeroDocumento) + ', ' + 'Old_documentoCliente: ' + CONVERT(NVARCHAR(MAX), DELETED.documentoCliente) + ', ' + 'Old_nombreCliente: ' + CONVERT(NVARCHAR(MAX), DELETED.nombreCliente) + ', ' + 'Old_montoPago: ' + CONVERT(NVARCHAR(MAX), DELETED.montoPago) + ', ' + 'Old_montoCambio: ' + CONVERT(NVARCHAR(MAX), DELETED.montoCambio) + ', ' + 'Old_montoTotal: ' + CONVERT(NVARCHAR(MAX), DELETED.montoTotal) + ', ' + 'Old_fechaRegistro: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaRegistro) + ', ', 
           'New_idVenta: ' + CONVERT(NVARCHAR(MAX), INSERTED.idVenta) + ', ' + 'New_id_usuario: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_usuario) + ', ' + 'New_id_cliente: ' + CONVERT(NVARCHAR(MAX), INSERTED.id_cliente) + ', ' + 'New_tipoDocumento: ' + CONVERT(NVARCHAR(MAX), INSERTED.tipoDocumento) + ', ' + 'New_numeroDocumento: ' + CONVERT(NVARCHAR(MAX), INSERTED.numeroDocumento) + ', ' + 'New_documentoCliente: ' + CONVERT(NVARCHAR(MAX), INSERTED.documentoCliente) + ', ' + 'New_nombreCliente: ' + CONVERT(NVARCHAR(MAX), INSERTED.nombreCliente) + ', ' + 'New_montoPago: ' + CONVERT(NVARCHAR(MAX), INSERTED.montoPago) + ', ' + 'New_montoCambio: ' + CONVERT(NVARCHAR(MAX), INSERTED.montoCambio) + ', ' + 'New_montoTotal: ' + CONVERT(NVARCHAR(MAX), INSERTED.montoTotal) + ', ' + 'New_fechaRegistro: ' + CONVERT(NVARCHAR(MAX), INSERTED.fechaRegistro) + ', ', GETDATE(), SYSTEM_USER
    FROM INSERTED
    JOIN DELETED ON INSERTED.idVenta = DELETED.idVenta;
END;

CREATE TRIGGER trg_venta_Delete
ON venta
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria (TableName, Action, RecordId, OldValues, Timestamp, [User])
    SELECT 'venta', 'DELETE', DELETED.idVenta, 
           'Old_idVenta: ' + CONVERT(NVARCHAR(MAX), DELETED.idVenta) + ', ' + 'Old_id_usuario: ' + CONVERT(NVARCHAR(MAX), DELETED.id_usuario) + ', ' + 'Old_id_cliente: ' + CONVERT(NVARCHAR(MAX), DELETED.id_cliente) + ', ' + 'Old_tipoDocumento: ' + CONVERT(NVARCHAR(MAX), DELETED.tipoDocumento) + ', ' + 'Old_numeroDocumento: ' + CONVERT(NVARCHAR(MAX), DELETED.numeroDocumento) + ', ' + 'Old_documentoCliente: ' + CONVERT(NVARCHAR(MAX), DELETED.documentoCliente) + ', ' + 'Old_nombreCliente: ' + CONVERT(NVARCHAR(MAX), DELETED.nombreCliente) + ', ' + 'Old_montoPago: ' + CONVERT(NVARCHAR(MAX), DELETED.montoPago) + ', ' + 'Old_montoCambio: ' + CONVERT(NVARCHAR(MAX), DELETED.montoCambio) + ', ' + 'Old_montoTotal: ' + CONVERT(NVARCHAR(MAX), DELETED.montoTotal) + ', ' + 'Old_fechaRegistro: ' + CONVERT(NVARCHAR(MAX), DELETED.fechaRegistro) + ', ', GETDATE(), SYSTEM_USER
    FROM DELETED;
END;

