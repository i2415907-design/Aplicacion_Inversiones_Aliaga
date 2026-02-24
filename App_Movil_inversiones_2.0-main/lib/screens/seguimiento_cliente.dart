import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rutasinversionesaliaga/models/pedido_model.dart';

class SeguimientoPedidoPage extends StatefulWidget {
  final int pedido_id;
  const SeguimientoPedidoPage({super.key, required this.pedido_id});

  @override
  State<SeguimientoPedidoPage> createState() => _SeguimientoPedidoPageState();
}

class _SeguimientoPedidoPageState extends State<SeguimientoPedidoPage> {
  PedidoModel? pedidoCurso;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _cargarPedidoEnCamino();
  }

  Future<void> _cargarPedidoEnCamino() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';

      final response = await Dio().get(
        'https://inversionesaliaga.com/v1/pedido-activo',
        queryParameters: {'token': token},
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        setState(() {
          pedidoCurso = PedidoModel.fromJson(response.data);
          _isLoading = false;
        });
      }
    } on DioException catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = e.response?.data['mensaje'] ?? "No hay pedidos en ruta actualmente.";
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = "Error de conexión";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: Color(0xFF2ECC71)));
    }

    if (_errorMessage != null || pedidoCurso == null) {
      return _buildErrorState();
    }

    final primerProducto = pedidoCurso!.detalles.isNotEmpty 
        ? pedidoCurso!.detalles.first 
        : DetalleProducto(nombre: "Pedido General", imagen: "", cantidad: 1, precio: "0");

    return Column(
      children: [
        const SizedBox(height: 40),
        _buildHeader(),
        const SizedBox(height: 30),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(35),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            child: Column(
              children: [
                // Número de Pedido
                Text(
                  "ORDEN #00${pedidoCurso!.idPedido}",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 25),
                
                // Imagen del Producto Principal
                _buildProductPreview(primerProducto.imagen),

                const SizedBox(height: 20),

                // NOMBRE DEL PRODUCTO (Lo que pediste)
                Text(
                  primerProducto.nombre.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                
                // Si hay más productos, mostramos un indicador
                if (pedidoCurso!.detalles.length > 1)
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      "y ${pedidoCurso!.detalles.length - 1} producto(s) más",
                      style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
                    ),
                  ),

                const SizedBox(height: 25),
                
                // Badge de Estado
                _buildStatusBadge(pedidoCurso!.estado),

                const SizedBox(height: 30),

                // Botón de Acción Principal
                _buildMapButton(),
              ],
            ),
          ),
        ),
        
        const Spacer(),
        _buildFooterInfo(),
        const SizedBox(height: 20),
      ],
    );
  }

  // --- WIDGETS DE SOPORTE PARA ESTRUCTURA LIMPIA ---

  Widget _buildHeader() {
    return const Text(
      "SEGUIMIENTO",
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w200,
        letterSpacing: 8,
      ),
    );
  }

  Widget _buildStatusBadge(String estado) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF1C40F),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF1C40F).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Text(
        estado.toUpperCase(),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w900,
          fontSize: 13,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildMapButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2ECC71).withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: ElevatedButton(
        onPressed: () => context.push("/Seguimiento_mapa", extra: pedidoCurso!.idPedido),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2ECC71),
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 0,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map_rounded, color: Colors.white),
            SizedBox(width: 10),
            Text(
              "RASTREAR EN MAPA",
              style: TextStyle(
                color: Colors.white, 
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductPreview(String imageUrl) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 2),
      ),
      child: CircleAvatar(
        radius: 60,
        backgroundColor: Colors.white.withOpacity(0.05),
        backgroundImage: imageUrl.isNotEmpty 
            ? NetworkImage(imageUrl) 
            : const AssetImage('assets/no_image.png') as ImageProvider,
      ),
    );
  }

  Widget _buildFooterInfo() {
    return Column(
      children: [
        Icon(Icons.sensors, color: Colors.white.withOpacity(0.2), size: 30),
        const SizedBox(height: 10),
        Text(
          "ACTUALIZANDO POSICIÓN\nEN TIEMPO REAL",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.2),
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.white.withOpacity(0.1)),
          const SizedBox(height: 20),
          Text(
            _errorMessage ?? "NO HAY PEDIDOS ACTIVOS",
            style: const TextStyle(color: Colors.white54, fontSize: 16),
          ),
          const SizedBox(height: 20),
          TextButton.icon(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back, color: Color(0xFF2ECC71)),
            label: const Text("VOLVER", style: TextStyle(color: Color(0xFF2ECC71))),
          )
        ],
      ),
    );
  }
}