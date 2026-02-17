import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rutasinversionesaliaga/widgets/buttons.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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

          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),

                    Image.asset('assets/images/logo1.png', height: 50),
                    const SizedBox(height: 30),

                    Image.asset('assets/images/solologo.png', height: 180),

                    const Spacer(flex: 1),

                    ButtonPrimary(
                      text: "INICIAR SESIÓN",
                      color: const Color(0xFF2E2A7A),
                      onPressed: () => context.go("/Inicio_sesion"),
                    ),

                    const SizedBox(height: 15),

                    ButtonPrimary(
                      text: "REGÍSTRATE",
                      color: const Color(0xFF8B943E),
                      onPressed: () => context.go("/Registrarse"),
                    ),

                    const SizedBox(height: 40),

                    const Text(
                      "o bien",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),

                    const SizedBox(height: 20),

                    ButtonSocial(
                      text: "Continuar con Google",
                      imageUrl: 'https://gdm-catalog-fmapi-prod.imgix.net/ProductLogo/5179d6b3-aa3f-403b-8cb4-718850815472.png?w=80&h=80&fit=max&dpr=3&auto=format&q=50',
                      onPressed: () {
                        print("Login Google presionado");
                      },
                    ),

                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}