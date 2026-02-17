import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rutasinversionesaliaga/service/pedido_service.dart';
import 'package:rutasinversionesaliaga/models/pedido_model.dart';
import 'package:shared_preferences/shared_preferences.dart'; // <--- IMPORTANTE

class Pedidos_clientePage extends StatefulWidget {
  const Pedidos_clientePage({super.key});

  @override
  State<Pedidos_clientePage> createState() => _Pedidos_clientePageState();
}

class _Pedidos_clientePageState extends State<Pedidos_clientePage> {
  final PedidoService _pedidoService = PedidoService();
  Future<List<PedidoModel>>? _pedidosList; // <--- Cambiar a nullable

  @override
  void initState() {
    super.initState();
    _initData();
  }

  // Nueva función para cargar el token dinámicamente
  Future<void> _initData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');

    if (token != null) {
      setState(() {
        _pedidosList = _pedidoService.getMisPedidos(token);
      });
    } else {
      // Si no hay token, lo mandamos al login
      context.go('/Inicio_sesion');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            _buildTitle(),
            const SizedBox(height: 20),
            Expanded(
              child: _pedidosList == null 
                ? const Center(child: CircularProgressIndicator(color: Color(0xFF2ECC71)))
                : FutureBuilder<List<PedidoModel>>(
                    future: _pedidosList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator(color: Color(0xFF2ECC71)));
                      }
                      if (snapshot.hasError || snapshot.data == null) {
                        return const Center(child: Text('Error al conectar', style: TextStyle(color: Colors.white54)));
                      }
                      final pedidos = snapshot.data!;
                      if (pedidos.isEmpty) {
                        return const Center(child: Text('No hay pedidos', style: TextStyle(color: Colors.white54)));
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemCount: pedidos.length,
                        itemBuilder: (context, index) => _buildPedidoExpandible(pedidos[index]),
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPedidoExpandible(PedidoModel pedido) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF24243E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        shape: const RoundedRectangleBorder(side: BorderSide.none),
        iconColor: const Color(0xFF2ECC71),
        collapsedIconColor: Colors.white,
        title: Text(
          "PEDIDO N° ${pedido.idPedido}",
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(
          "Estado: ${pedido.estado.toUpperCase()} • S/ ${pedido.total}",
          style: TextStyle(
            color: pedido.estado == 'pendiente' ? Colors.orangeAccent : Colors.greenAccent, 
            fontSize: 12
          ),
        ),
        children: [
          const Divider(color: Colors.white10, height: 1),
          
          // Generamos dinámicamente la lista de productos del pedido
          ...pedido.detalles.map((prod) => ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
  prod.imagen, 
  width: 45, 
  height: 45, 
  fit: BoxFit.cover,
  // Esto es vital para evitar el bloqueo total en Web
  errorBuilder: (context, error, stackTrace) {
    return Container(
      width: 45,
      height: 45,
      color: Colors.white10,
      child: const Icon(Icons.broken_image, color: Colors.white24, size: 20),
    );
  },
)
            ),
            title: Text(prod.nombre, 
                style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
            subtitle: Text("Cant: ${prod.cantidad} • Unit: S/ ${prod.precio}", 
                style: const TextStyle(color: Colors.white38, fontSize: 11)),
          )).toList(),
          
          const Divider(color: Colors.white10, height: 1),
          
          Padding(
            padding: const EdgeInsets.all(15),
            child: ElevatedButton(
              // Corregido: Navega a Seguimiento pasando el ID
              onPressed: () => context.push("/Pedido_cliente", extra: pedido.idPedido),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2ECC71),
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: const Text("RASTREAR ENVÍO", 
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return const Column(
      children: [
        Text("MIS PEDIDOS", 
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2)),
        SizedBox(height: 5),
      
      ],
    );
  }
}
