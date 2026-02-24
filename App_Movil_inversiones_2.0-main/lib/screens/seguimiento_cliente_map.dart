import 'package:flutter/material.dart';

class SeguimientoPedidoMapaPage extends StatefulWidget {
  const SeguimientoPedidoMapaPage({super.key});

  @override
  State<SeguimientoPedidoMapaPage> createState() => _SeguimientoPedidoMapaPageState();
}

class _SeguimientoPedidoMapaPageState extends State<SeguimientoPedidoMapaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 25),
              // CABECERA (Similar a los layouts anteriores)
              const Text("SEGUIMIENTO",
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w300, letterSpacing: 4)),
              const SizedBox(height: 20),

              // MINI PREVIEW DEL PEDIDO
              _buildCompactOrderInfo(),

              const SizedBox(height: 15),

              // CONTENEDOR DEL MAPA
              Container(
                height: 280,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white.withOpacity(0.05),
                  border: Border.all(color: Colors.white10),
                  image: const DecorationImage(
                    image: NetworkImage('https://miro.medium.com/v2/resize:fit:1400/1*q3Z99C7p0l7W_6xInF4GqA.png'), // Placeholder de Mapa
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Center(
                  child: Icon(Icons.location_on, color: Colors.redAccent, size: 50),
                ),
              ),

              const SizedBox(height: 15),

              // INFO DEL REPARTIDOR
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1C40F).withOpacity(0.8), // Amarillo del layout
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.local_shipping, color: Colors.black),
                    SizedBox(width: 15),
                    Expanded(
                      child: Text("SERÁ ENTREGADO POR:\nJOSE CARLO MARIATEGUI",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // SECCIÓN DE CALIFICACIÓN (Glass)
              _buildRatingSection(),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompactOrderInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), borderRadius: BorderRadius.circular(20)),
      child: const Row(
        children: [
          Text("MI PEDIDO N°2", style: TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.bold)),
          Spacer(),
          Icon(Icons.inventory_2_outlined, color: Colors.white24, size: 18),
        ],
      ),
    );
  }

  Widget _buildRatingSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Solo podrás calificar cuando hayas recibido el pedido.",
            style: TextStyle(color: Colors.white38, fontSize: 11)),
          const SizedBox(height: 15),
          const Text("Califica la entrega:", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const Row(
            children: [
              Icon(Icons.star_border, color: Colors.white54, size: 30),
              Icon(Icons.star_border, color: Colors.white54, size: 30),
              Icon(Icons.star_border, color: Colors.white54, size: 30),
              Icon(Icons.star_border, color: Colors.white54, size: 30),
              Icon(Icons.star_border, color: Colors.white54, size: 30),
            ],
          ),
          const SizedBox(height: 15),
          const Text("Comenta:", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          TextField(
            maxLines: 3,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(0.05),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }
}