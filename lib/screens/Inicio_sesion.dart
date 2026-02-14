import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rutasinversionesaliaga/service/auth_service.dart'; // Asegúrate de crear este servicio
import 'package:rutasinversionesaliaga/widgets/buttons.dart';
import 'package:rutasinversionesaliaga/widgets/inputs.dart';

class InicioSesionPage extends StatefulWidget {
  const InicioSesionPage({super.key});

  @override
  State<InicioSesionPage> createState() => _InicioSesionPageState();
}

class _InicioSesionPageState extends State<InicioSesionPage> {
  // 1. Definimos los controladores y el estado de carga
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  // 2. Función lógica para el Login
  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, completa todos los campos")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final success = await _authService.login(email, password);

      if (success) {
        if (mounted) context.go("/Pedidos");
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Credenciales incorrectas")),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error de conexión: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    // Limpiamos controladores para liberar memoria
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // FONDO
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/tienda_fondo.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF3F3D89).withOpacity(0.7),
                    const Color(0xFF1A1A2E).withOpacity(0.9),
                  ],
                ),
              ),
            ),
          ),

          // CONTENIDO
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  _buildHeader(context),
                  const SizedBox(height: 50),
                  const Text(
                    "INICIO DE SESIÓN",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // INPUTS CON CONTROLADORES ASIGNADOS
                  GlassTextField(
                    controller: _emailController,
                    label: "Ingrese su correo electrónico",
                    icon: Icons.email_outlined,
                  ),
                  GlassTextField(
                    controller: _passwordController,
                    label: "Ingrese su contraseña",
                    icon: Icons.lock_outline,
                    isPassword: true,
                  ),

                  const SizedBox(height: 30),

                  // BOTÓN CON VALIDACIÓN DE CARGA
                  _isLoading
                      ? const CircularProgressIndicator(color: Color(0xFF2ECC71))
                      : ButtonPrimary(
                          text: "INICIAR SESIÓN",
                          color: const Color(0xFF2ECC71),
                          onPressed: _handleLogin, // Llamada a la función lógica
                        ),

                  const SizedBox(height: 25),

                  ButtonSocial(
                    text: "Continuar con Google",
                    imageUrl: 'https://gdm-catalog-fmapi-prod.imgix.net/ProductLogo/5179d6b3-aa3f-403b-8cb4-718850815472.png?w=80&h=80&fit=max&dpr=3&auto=format&q=50',
                    onPressed: () {},
                  ),

                  const SizedBox(height: 30),

                  ButtonPrimary(
                    text: "REGÍSTRATE",
                    color: const Color(0xFF8B943E),
                    onPressed: () => context.go("/Registrarse"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.reply, color: Colors.white, size: 30),
          onPressed: () => context.go('/Homepage'),
        ),
        Image.asset('assets/images/logo1.png', height: 40),
      ],
    );
  }
}