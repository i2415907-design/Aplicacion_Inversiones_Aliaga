import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PerfilClientePage extends StatefulWidget {
  const PerfilClientePage({super.key});

  @override
  State<PerfilClientePage> createState() => _PerfilClientePageState();
}

class _PerfilClientePageState extends State<PerfilClientePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E), // Fondo azul profundo consistente
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
              Container(
                height: 2,
                width: 40,
                color: const Color(0xFF8B943E), // Detalle verde oliva consistente
              ),
              const SizedBox(height: 40),

              // CONTENEDOR PRINCIPAL (Glassmorphism sutil como OrderCardComponent)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
                ),
                child: Column(
                  children: [
                    _profileLabel("CORREO ELECTRÓNICO"),
                    _modernProfileInput("joseletessac45@gmail.com", isReadOnly: true),

                    const SizedBox(height: 25),

                    _profileLabel("CONTRASEÑA ACTUAL"),
                    _modernProfileInput("••••••••••••••••••••", isPassword: true),

                    const SizedBox(height: 25),

                    _profileLabel("NUEVA CONTRASEÑA"),
                    _modernProfileInput("Escriba aquí..."),

                    const SizedBox(height: 40),

                    // BOTÓN APLICAR CAMBIOS (Basado en el botón GUARDAR de pedidos)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2ECC71), // Verde sólido
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          elevation: 0,
                        ),
                        child: const Text(
                          "APLICAR CAMBIOS",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 1)
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // BOTÓN CERRAR SESIÓN (Color destructivo pero suave)
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () => context.go("/"),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(color: Colors.redAccent.withOpacity(0.3))
                          ),
                        ),
                        child: const Text(
                          "CERRAR SESIÓN",
                          style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 13)
                        ),
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

  // Etiquetas de campo alineadas a la izquierda con estilo minimalista
  Widget _profileLabel(String text) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 10, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white38, // Color tenue para jerarquía visual
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5
        ),
      ),
    );
  }

  // Input moderno basado en _modernInput de la pantalla de pedidos
  Widget _modernProfileInput(String hint, {bool isPassword = false, bool isReadOnly = false}) {
    return TextField(
      readOnly: isReadOnly,
      obscureText: isPassword,
      style: TextStyle(
        color: isReadOnly ? Colors.white54 : Colors.white,
        fontSize: 14
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white12),
        filled: true,
        fillColor: Colors.black26, // Fondo oscuro para resaltar dentro del Glass
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.white12)
        ),
      ),
    );
  }
}