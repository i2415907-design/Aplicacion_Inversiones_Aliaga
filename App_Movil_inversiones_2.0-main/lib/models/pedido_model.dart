class PedidoModel {
  final int idPedido;
  final String estado;
  final String total;
  final String fecha;
  final List<DetalleProducto> detalles;

  // --- NUEVOS CAMPOS PARA EL FORMULARIO ---
  // Los declaramos como opcionales (?) para que no den error al cargar
  int? tempIdDistrito;
  String? tempCodigoPostal;
  String? tempReferencia;
  String? tempDireccion;

  PedidoModel({
    
    required this.idPedido,
    required this.estado,
    required this.total,
    required this.fecha,
    required this.detalles,
    
    // Inicializamos estos campos como nulos o con valores por defecto
    this.tempIdDistrito,
    this.tempCodigoPostal,
    this.tempReferencia,
    this.tempDireccion,
  });

  factory PedidoModel.fromJson(Map<String, dynamic> json) {
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
      // Al cargar de la base de datos, podemos llenar los valores actuales
      tempIdDistrito: json['id_distrito'],
      tempCodigoPostal: json['codigo_postal'],
      tempReferencia: json['referencia_ped'],
      tempDireccion: json['direccion_cliente'] ?? "",
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
      nombre: json['producto']['nombre_producto'] ?? 'Producto sin nombre',
      imagen: json['producto']['url_imagen'] ?? '',
      cantidad: json['cantidad'] ?? 0,
      precio: json['precio_unitario']?.toString() ?? '0.00',
    );
  }
}