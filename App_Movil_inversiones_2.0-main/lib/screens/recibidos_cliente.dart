import 'package:flutter/material.dart';

class RecibidosPedidoPage extends StatefulWidget {
  const RecibidosPedidoPage({super.key});

  @override
  State<RecibidosPedidoPage> createState() => _RecibidosPedidoPageState();
}

class _RecibidosPedidoPageState extends State<RecibidosPedidoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E), // Fondo azul oscuro consistente
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            // CABECERA
            const Text(
              "RECIBIDOS",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w300,
                letterSpacing: 4,
              ),
            ),
            const Text(
              "HISTORIAL DE PEDIDOS RECIBIDOS",
              style: TextStyle(color: Colors.white24, fontSize: 10, letterSpacing: 1.2),
            ),
            const SizedBox(height: 30),

            // LISTA DE PEDIDOS RECIBIDOS
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildReceivedCard(
                    orderId: "1",
                    dateOrdered: "20/11/2025",
                    dateDelivered: "23/11/2025",
                    address: "El Tambo - Huancayo\nPsje Los lirios 234\ncod postal: 12004\nRef: Al lado del parque juvenil",
                  ),
                  const SizedBox(height: 40),
                  // MENSAJE FINAL (Como en tu layout)
                  const Center(
                    child: Text(
                      "NO HAY MÁS\nPEDIDOS EN\nCAMINO", // Mantengo el texto de tu imagen
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white10,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceivedCard({
    required String orderId,
    required String dateOrdered,
    required String dateDelivered,
    required String address,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("N°$orderId   Productos:",
            style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 15),

          // Preview del producto (Airpods en tu ejemplo)
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.headphones, color: Colors.white38, size: 40),
          ),

          const SizedBox(height: 15),

          // Cuadro de dirección (Sutil)
          Container(
            padding: const EdgeInsets.all(15),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Se entregó en:", style: TextStyle(color: Colors.white38, fontSize: 11)),
                const SizedBox(height: 5),
                Text(address, style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.4)),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Footer con estado y fechas
          Row(
            children: [
              // Badge Entregado
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF2ECC71).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFF2ECC71).withOpacity(0.5)),
                ),
                child: const Text("ENTREGADO",
                  style: TextStyle(color: Color(0xFF2ECC71), fontSize: 9, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 10),
              // Fechas
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Pedido realizado el: $dateOrdered", style: const TextStyle(color: Colors.white38, fontSize: 10)),
                    Text("Pedido entregado el: $dateDelivered", style: const TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}