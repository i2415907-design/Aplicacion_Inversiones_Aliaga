import 'package:flutter/material.dart';
import 'package:rutasinversionesaliaga/models/pedido_model.dart';
import 'package:rutasinversionesaliaga/widgets/order_card_component.dart'; 

class Pedidos_clientePage extends StatefulWidget {
  const Pedidos_clientePage({super.key});

  @override
  State<Pedidos_clientePage> createState() => _Pedidos_clientePageState();
}

class _Pedidos_clientePageState extends State<Pedidos_clientePage> {
  // Simulación de datos (Esto luego vendría de una base de datos)
  final List<Pedido> misPedidos = [
    Pedido(
      id: "#001",
      status: "ENTREGADO",
      statusColor: "green",
      fecha: "20 de Noviembre, 2025",
      productos: ["Mouse Rayo Mcqueen", "Carcasa iPhone 13"],
      direccion: "El Tambo - Huancayo\nPsje. Los Lirios 234",
    ),
    Pedido(
      id: "#002",
      status: "PENDIENTE",
      statusColor: "red",
      fecha: "25 de Noviembre, 2025",
      productos: ["Teclado Mecánico", "Monitor 24'"],
      direccion: "Pilcomayo - Huancayo\nAv. Las Palmas 123",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            _buildTitle(),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: misPedidos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: OrderCardComponent(pedido: misPedidos[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        const Text(
          "MIS PEDIDOS",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w300,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 8),
        Container(height: 2, width: 40, color: const Color(0xFF8B943E)),
      ],
    );
  }
}