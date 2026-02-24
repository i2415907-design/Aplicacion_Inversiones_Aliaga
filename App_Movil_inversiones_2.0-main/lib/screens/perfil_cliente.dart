import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilClientePage extends StatefulWidget {
  const PerfilClientePage({super.key});

  @override
  State<PerfilClientePage> createState() => _PerfilClientePageState();
}

class _PerfilClientePageState extends State<PerfilClientePage> {
  // Controladores y variables de estado
  final TextEditingController _actualController = TextEditingController();
  final TextEditingController _nuevaController = TextEditingController();
  String _emailUser = "Cargando...";
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _cargarDatosPerfil();
  }

  // Cargar el correo del usuario desde el servidor
  Future<void> _cargarDatosPerfil() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';

      final response = await Dio().get(
        'https://inversionesaliaga.com/v1/perfil',
        queryParameters: {'token': token},
      );

      if (response.statusCode == 200) {
        setState(() {
          _emailUser = response.data['email'] ?? 'Sin correo';
        });
      }
    } catch (e) {
      setState(() => _emailUser = "Error al cargar");
    }
  }

  // Lógica para actualizar contraseña
  Future<void> _actualizarPassword() async {
    if (_actualController.text.isEmpty || _nuevaController.text.isEmpty) {
      _showMsg("Por favor, completa ambos campos", Colors.orange);
      return;
    }

    setState(() => _isUpdating = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';

      final response = await Dio().post(
        'https://inversionesaliaga.com/v1/actualizar-password',
        queryParameters: {'token': token},
        data: {
          'password_actual': _actualController.text,
          'nueva_password': _nuevaController.text,
        },
      );

      _showMsg(response.data['mensaje'], Colors.green);
      _actualController.clear();
      _nuevaController.clear();
    } on DioException catch (e) {
      String error = e.response?.data['mensaje'] ?? "Error de conexión";
      _showMsg(error, Colors.redAccent);
    } finally {
      setState(() => _isUpdating = false);
    }
  }

  void _showMsg(String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text), backgroundColor: color),
    );
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    if (mounted) context.go("/");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text(
                "MI PERFIL",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 8),
              Container(height: 2, width: 40, color: const Color(0xFF8B943E)),
              const SizedBox(height: 40),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: Column(
                  children: [
                    _profileLabel("CORREO ELECTRÓNICO"),
                    _modernProfileInput(_emailUser, isReadOnly: true),

                    const SizedBox(height: 25),

                    _profileLabel("CONTRASEÑA ACTUAL"),
                    _modernProfileInput("Contraseña actual", isPassword: true, controller: _actualController),

                    const SizedBox(height: 25),

                    _profileLabel("NUEVA CONTRASEÑA"),
                    _modernProfileInput("Nueva contraseña", isPassword: true, controller: _nuevaController),

                    const SizedBox(height: 40),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isUpdating ? null : _actualizarPassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2ECC71),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        child: _isUpdating 
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Text("APLICAR CAMBIOS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),

                    const SizedBox(height: 15),

                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: _logout,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(color: Colors.redAccent.withOpacity(0.3))
                          ),
                        ),
                        child: const Text("CERRAR SESIÓN", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileLabel(String text) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 10, bottom: 8),
      child: Text(text, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
    );
  }

  Widget _modernProfileInput(String hint, {bool isPassword = false, bool isReadOnly = false, TextEditingController? controller}) {
    return TextField(
      controller: controller,
      readOnly: isReadOnly,
      obscureText: isPassword,
      style: TextStyle(color: isReadOnly ? Colors.white54 : Colors.white, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white12),
        filled: true,
        fillColor: Colors.black26,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: const BorderSide(color: Colors.white12)),
      ),
    );
  }
}