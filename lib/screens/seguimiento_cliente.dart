import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rutasinversionesaliaga/models/pedido_model.dart';

class SeguimientoPedidoPage extends StatefulWidget {
final int pedido_id;
  const SeguimientoPedidoPage({super.key,required this.pedido_id});

  @override
  State<SeguimientoPedidoPage> createState() => _SeguimientoPedidoPageState();
}
class _SeguimientoPedidoPageState extends State<SeguimientoPedidoPage> {
  Pedido pedidoCurso = Pedido(id: "7777",status: "",statusColor: "", fecha: "", productos: List.empty(), direccion: "");

  
  //final int pedido_id;
  //const _SeguimientoPedidoPageState({super.key});
@override
void initState() {
  super.initState();
  // Esta es tu función "on started" real
  setState(() {
       this.pedidoCurso.id  ="88";
  });

}
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E), // Fondo profundo
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              "SEGUIMIENTO",
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w300, letterSpacing: 4),
            ),
            const SizedBox(height: 30),
            
            // Tarjeta de Pedido en Camino
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
                    Text("MI PEDIDO N°: ${pedidoCurso.id}", 
                      style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    
                    // Imágenes de productos
                    _buildProductPreview(),

                    const SizedBox(height: 20),
                    
                    // Badge de Estado
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.yellow.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text("EN CAMINO", 
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),

                    const SizedBox(height: 15),

                    // BOTÓN SEGUIR (Acción principal)
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
            const Text("NO HAY MÁS\nPEDIDOS EN\nCAMINO", 
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white24, fontSize: 16, fontWeight: FontWeight.bold)),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductPreview() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(3, (index) => 
          const CircleAvatar(radius: 25, backgroundColor: Colors.white24, child: Icon(Icons.shopping_bag, color: Colors.white54))
        ),
      ),
    );
  }
}