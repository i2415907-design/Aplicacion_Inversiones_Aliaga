class PedidoModel {
  final int idPedido;
  final String estado;
  final String total;
  final String fecha;
  final List<DetalleProducto> detalles;

  PedidoModel({
    required this.idPedido,
    required this.estado,
    required this.total,
    required this.fecha,
    required this.detalles,
  });

  factory PedidoModel.fromJson(Map<String, dynamic> json) {
    // Accedemos a datos -> venta -> detalles
    var listaDetalles = json['venta']['detalles'] as List;
    List<DetalleProducto> productos = listaDetalles
        .map((d) => DetalleProducto.fromJson(d))
        .toList();

    return PedidoModel(
      idPedido: json['id_pedido'],
      estado: json['estado_pedido'],
      total: json['total_pedido'],
      fecha: json['fecha_pedido'],
      detalles: productos,
    );
  }
}

class DetalleProducto {
  final String nombre;
  final String imagen;
  final int cantidad;
  final String precio;

  DetalleProducto({
    required this.nombre,
    required this.imagen,
    required this.cantidad,
    required this.precio,
  });

  factory DetalleProducto.fromJson(Map<String, dynamic> json) {
    return DetalleProducto(
      nombre: json['producto']['nombre_producto'],
      imagen: json['producto']['url_imagen'],
      cantidad: json['cantidad'],
      precio: json['precio_unitario'],
    );
  }
}