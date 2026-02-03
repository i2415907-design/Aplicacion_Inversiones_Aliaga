import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rutasinversionesaliaga/widgets/buttons.dart';
import 'package:rutasinversionesaliaga/widgets/inputs.dart'; // Importa el nuevo input

class InicioSesionPage extends StatelessWidget {
  const InicioSesionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. FONDO (El mismo para consistencia)
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
                  const SizedBox(height: 25),
                  // CABECERA: Flecha de regreso y Logo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.reply, color: Colors.white, size: 30),
                        onPressed: () => context.go('/Homepage'), // Vuelve al Home
                      ),
                      Image.asset('assets/images/logo1.png', height: 40),
                    ],
                  ),

                  const SizedBox(height: 50),
                  const Text(
                    "INICIO DE SESIÓN",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // INPUTS GLASS
                  const GlassTextField(
                    label: "Ingrese su correo electrónico",
                    icon: Icons.email_outlined,
                  ),
                  const GlassTextField(
                    label: "Ingrese su contraseña",
                    icon: Icons.lock_outline,
                    isPassword: true,
                  ),

                  const SizedBox(height: 30),

                  // BOTÓN ENTRAR (Verde Glass)
                  ButtonPrimary(
                    text: "INICIAR SESIÓN",
                    color: const Color(0xFF2ECC71), // Un verde más vibrante
                    onPressed: () => context.go("/Pedidos"),
                  ),

                  const SizedBox(height: 25),

                  // BOTÓN GOOGLE
                  ButtonSocial(
                    text: "Continuar con Google",
                    imageUrl: 'https://gdm-catalog-fmapi-prod.imgix.net/ProductLogo/5179d6b3-aa3f-403b-8cb4-718850815472.png?w=80&h=80&fit=max&dpr=3&auto=format&q=50',
                    onPressed: () {},
                  ),

                  const SizedBox(height: 30),

                  // BOTÓN REGISTRO (Azul Glass sutil)
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
}