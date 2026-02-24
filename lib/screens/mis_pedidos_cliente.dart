import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rutasinversionesaliaga/service/pedido_service.dart';
import 'package:rutasinversionesaliaga/models/pedido_model.dart';
import 'package:rutasinversionesaliaga/models/distrito_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pedidos_clientePage extends StatefulWidget {
  const Pedidos_clientePage({super.key});

  @override
  State<Pedidos_clientePage> createState() => _Pedidos_clientePageState();
}

class _Pedidos_clientePageState extends State<Pedidos_clientePage> {
  final PedidoService _pedidoService = PedidoService();
  Future<List<PedidoModel>>? _pedidosList;
  List<DistritoModel> _listaDistritos = [];

  @override
  void initState() {
    super.initState();
    _initData();
    _loadDistritos();
  }

  Future<void> _initData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');
    if (token != null) {
      setState(() {
        _pedidosList = _pedidoService.getMisPedidos(token);
      });
    } else {
      context.go('/Inicio_sesion');
    }
  }

  Future<void> _loadDistritos() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
    if (token.isNotEmpty) {
      final dists = await _pedidoService.getDistritos(token);
      setState(() { _listaDistritos = dists; });
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
        title: Text("PEDIDO N° ${pedido.idPedido}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text("Estado: ${pedido.estado.toUpperCase()} • S/ ${pedido.total}", 
                  style: const TextStyle(color: Colors.greenAccent, fontSize: 12)),
        children: [
          const Divider(color: Colors.white10),
          ...pedido.detalles.map((prod) => ListTile(
            title: Text(prod.nombre, style: const TextStyle(color: Colors.white, fontSize: 13)),
            subtitle: Text("Cant: ${prod.cantidad} • S/ ${prod.precio}", style: const TextStyle(color: Colors.white38)),
          )).toList(),
          
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                DropdownButtonFormField<int>(
                  dropdownColor: const Color(0xFF1A1A2E),
                  value: _listaDistritos.any((d) => d.id == pedido.tempIdDistrito) ? pedido.tempIdDistrito : null,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputStyle("Distrito", Icons.location_city),
                  items: _listaDistritos.map((dist) => DropdownMenuItem(value: dist.id, child: Text(dist.nombre))).toList(),
                  onChanged: (val) => setState(() => pedido.tempIdDistrito = val),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: TextEditingController(text: pedido.tempDireccion)..selection = TextSelection.collapsed(offset: (pedido.tempDireccion ?? "").length),
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputStyle("Dirección", Icons.home),
                  onChanged: (val) => pedido.tempDireccion = val,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: TextEditingController(text: pedido.tempCodigoPostal)..selection = TextSelection.collapsed(offset: (pedido.tempCodigoPostal ?? "").length),
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputStyle("Código Postal", Icons.mark_as_unread),
                  onChanged: (val) => pedido.tempCodigoPostal = val,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: TextEditingController(text: pedido.tempReferencia)..selection = TextSelection.collapsed(offset: (pedido.tempReferencia ?? "").length),
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputStyle("Referencia", Icons.explore),
                  onChanged: (val) => pedido.tempReferencia = val,
                ),
                const SizedBox(height: 15),
                _buildBotonGuardar(pedido),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBotonGuardar(PedidoModel pedido) {
    return ElevatedButton(
      onPressed: () => _updatePedido(pedido),
      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2ECC71), minimumSize: const Size(double.infinity, 40)),
      child: const Text("ACTUALIZAR DATOS", style: TextStyle(color: Colors.white)),
    );
  }

  InputDecoration _inputStyle(String label, IconData icon) {
    return InputDecoration(
      labelText: label, labelStyle: const TextStyle(color: Colors.white38),
      prefixIcon: Icon(icon, color: const Color(0xFF2ECC71)),
      filled: true, fillColor: Colors.white.withOpacity(0.05),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    );
  }

  Future<void> _updatePedido(PedidoModel pedido) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';

    bool success = await _pedidoService.updateUbicacion(
      token: token,
      idPedido: pedido.idPedido,
      idDistrito: pedido.tempIdDistrito ?? 1,
      direccionCliente: pedido.tempDireccion ?? "",
      referencia: pedido.tempReferencia ?? "",
      codigoPostal: pedido.tempCodigoPostal ?? "",
    );

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(success ? "Actualizado" : "Error"),
      backgroundColor: success ? Colors.green : Colors.red,
    ));
  }

  Widget _buildTitle() {
    return const Text("MIS PEDIDOS", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold));
  }
}