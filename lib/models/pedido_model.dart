import 'package:flutter/material.dart';

class Pedido {
   String id;
   String status;
   String statusColor;
   String fecha;
   List<String> productos;
   String direccion;

  Pedido({
    required this.id,
    required this.status,
    required this.statusColor,
    required this.fecha,
    required this.productos,
    required this.direccion,
  });
}