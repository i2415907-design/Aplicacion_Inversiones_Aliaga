import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rutasinversionesaliaga/service/auth_service.dart';
import 'package:rutasinversionesaliaga/widgets/buttons.dart';
import 'package:rutasinversionesaliaga/widgets/inputs.dart';

class RegistroSesionPage extends StatefulWidget {
  const RegistroSesionPage({super.key});

  @override
  State<RegistroSesionPage> createState() => _RegistroSesionPageState();
}

class _RegistroSesionPageState extends State<RegistroSesionPage> {
  // CONTROLADORES
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  // FUNCIÓN DE REGISTRO
  void _handleRegister() async {
    // Validación básica de contraseñas iguales
    if (_passController.text != _confirmPassController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Las contraseñas no coinciden")),
      );
      return;
    }

    // Validación de campos vacíos
    if (_nameController.text.isEmpty || _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor complete todos los campos")),
      );
      return;
    }

    setState(() => _isLoading = true);

    bool success = await _authService.register(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passController.text,
      passwordConfirmation: _confirmPassController.text,
    );

    if (mounted) setState(() => _isLoading = false);

    if (success) {
      if (mounted) context.go("/Pedidos");
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error: Revisa que la clave tenga Mayúscula, Número y Carácter especial."),
            duration: Duration(seconds: 5),
          ),
        );
      }
    }
  }

  // --- COMPONENTES DE UI EXTRAÍDOS ---

  Widget _buildBackground() {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/tienda_fondo.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
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
      ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(), // Ahora sí existe
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  _buildHeader(context), // Ahora sí existe
                  const SizedBox(height: 40),
                  const Text(
                    "REGISTRO",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 35),

                  GlassTextField(
                    controller: _nameController,
                    label: "Ingrese su nombre completo",
                    icon: Icons.person_outline,
                  ),
                  GlassTextField(
                    controller: _emailController,
                    label: "Ingrese su correo electrónico",
                    icon: Icons.email_outlined,
                  ),
                  GlassTextField(
                    controller: _passController,
                    label: "Ingrese su contraseña",
                    icon: Icons.lock_outline,
                    isPassword: true,
                  ),
                  GlassTextField(
                    controller: _confirmPassController,
                    label: "Confirme su contraseña",
                    icon: Icons.lock_reset_outlined,
                    isPassword: true,
                  ),

                  const SizedBox(height: 30),

                  _isLoading
                      ? const CircularProgressIndicator(color: Color(0xFF2ECC71))
                      : ButtonPrimary(
                          text: "REGISTRARSE",
                          color: const Color(0xFF8B943E),
                          onPressed: _handleRegister,
                        ),

                  const SizedBox(height: 25),
                  const Text("o bien", style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 20),
                  
                  ButtonSocial(
                    text: "Continuar con Google",
                    imageUrl: 'https://gdm-catalog-fmapi-prod.imgix.net/ProductLogo/5179d6b3-aa3f-403b-8cb4-718850815472.png?w=80&h=80&fit=max&dpr=3&auto=format&q=50',
                    onPressed: () {},
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}