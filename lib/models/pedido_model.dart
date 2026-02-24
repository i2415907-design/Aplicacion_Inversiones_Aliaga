import 'package:rutasinversionesaliaga/models/detalle_producto_model.dart';

class PedidoModel {
  final int idPedido;
  final String estado;
  final String total;
  final String fecha;
  final List<DetalleProducto> detalles;

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
      tempIdDistrito: json['id_distrito'],
      tempCodigoPostal: json['codigo_postal'],
      tempReferencia: json['referencia_ped'],
      tempDireccion: json['direccion_cliente'] ?? "",
    );
  }

  toJson() {}
}

