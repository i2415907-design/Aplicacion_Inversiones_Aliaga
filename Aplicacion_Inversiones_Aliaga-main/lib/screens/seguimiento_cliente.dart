import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rutasinversionesaliaga/models/pedido_model.dart';

class SeguimientoPedidoPage extends StatefulWidget {
  final int pedido_id;
  const SeguimientoPedidoPage({super.key, required this.pedido_id});

  @override
  State<SeguimientoPedidoPage> createState() => _SeguimientoPedidoPageState();
}

class _SeguimientoPedidoPageState extends State<SeguimientoPedidoPage> {
  PedidoModel? pedidoCurso;

  @override
  void initState() {
    super.initState();
    
    // Simulación: Creamos un objeto que coincida con la nueva estructura
    pedidoCurso = PedidoModel(
      idPedido: widget.pedido_id,
      estado: "EN CAMINO",
      total: "0.00",
      fecha: "2024-05-20",
      detalles: [
        DetalleProducto(
          nombre: "Cargando...",
          imagen: "https://via.placeholder.com/150",
          cantidad: 1,
          precio: "0.00"
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (pedidoCurso == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Extraemos el primer producto para la vista previa
    final primerProducto = pedidoCurso!.detalles.first;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              "SEGUIMIENTO",
              style: TextStyle(
                color: Colors.white, 
                fontSize: 22, 
                fontWeight: FontWeight.w300, 
                letterSpacing: 4
              ),
            ),
            const SizedBox(height: 30),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: Column(
                  children: [
                    Text(
                      "MI PEDIDO N°: ${pedidoCurso!.idPedido}", 
                      style: const TextStyle(
                        color: Colors.white70, 
                        fontSize: 12, 
                        fontWeight: FontWeight.bold
                      )
                    ),
                    const SizedBox(height: 15),
                    
                    // Usamos la imagen del primer producto
                    _buildProductPreview(primerProducto.imagen),

                    const SizedBox(height: 20),
                    
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.yellow.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        pedidoCurso!.estado.toUpperCase(), 
                        style: const TextStyle(
                          color: Colors.black, 
                          fontWeight: FontWeight.bold, 
                          fontSize: 12
                        )
                      ),
                    ),

                    const SizedBox(height: 15),

                    ElevatedButton(
                      onPressed: () => context.go("/Seguimiento_mapa"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2ECC71),
                        minimumSize: const Size(double.infinity, 45),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: const Text("SEGUIR PEDIDO", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
            
            const Spacer(),
            const Text(
              "DETALLES ADICIONALES\nDISPONIBLES EN EL\nMAPA", 
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white24, fontSize: 16, fontWeight: FontWeight.bold)
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductPreview(String imageUrl) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white24,
            backgroundImage: NetworkImage(imageUrl),
          ),
        ],
      ),
    );
  }
}