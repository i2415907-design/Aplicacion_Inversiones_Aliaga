import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rutasinversionesaliaga/widgets/buttons.dart';
import 'package:rutasinversionesaliaga/widgets/inputs.dart'; 

class RegistroSesionPage extends StatelessWidget {
  const RegistroSesionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usamos el mismo Stack para mantener el fondo de la tienda
      body: Stack(
        children: [
          // 1. FONDO CON GRADIENTE (Igual que Inicio de Sesión)
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

          // 2. CONTENIDO
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  const SizedBox(height: 25), // El espacio que pediste para bajar el logo
                  
                  // CABECERA
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.reply, color: Colors.white, size: 30),
                        onPressed: () => context.go('/Homepage'),
                      ),
                      Image.asset('assets/images/logo1.png', height: 40),
                    ],
                  ),

                  const SizedBox(height: 40),
                  const Text(
                    "REGISTRO",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 35),

                  // FORMULARIO CON ESTILO GLASS
                  const GlassTextField(
                    label: "Ingrese su correo electrónico",
                    icon: Icons.email_outlined,
                  ),
                  const GlassTextField(
                    label: "Ingrese su contraseña",
                    icon: Icons.lock_outline,
                    isPassword: true,
                  ),
                  const GlassTextField(
                    label: "Confirme su contraseña",
                    icon: Icons.lock_reset_outlined,
                    isPassword: true,
                  ),

                  const SizedBox(height: 30),

                  // BOTÓN REGISTRARSE (Verde Oliva)
                  ButtonPrimary(
                    text: "REGISTRARSE",
                    color: const Color(0xFF8B943E), // Tu verde oliva característico
                    onPressed: () => context.go("/Pedidos"),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "o bien",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),

                  const SizedBox(height: 20),

                  // BOTÓN GOOGLE
                  ButtonSocial(
                    text: "Continuar con Google",
                    imageUrl: 'https://gdm-catalog-fmapi-prod.imgix.net/ProductLogo/5179d6b3-aa3f-403b-8cb4-718850815472.png?w=80&h=80&fit=max&dpr=3&auto=format&q=50',
                    onPressed: () {
                      print("Registro con Google");
                    },
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