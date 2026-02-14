import 'package:flutter/material.dart';

class NotificacionesClientePage extends StatefulWidget {
  const NotificacionesClientePage({super.key});

  @override
  State<NotificacionesClientePage> createState() => _NotificacionesClientePageState();
}

class _NotificacionesClientePageState extends State<NotificacionesClientePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              "NOTIFICACIONES",
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w300, letterSpacing: 4),
            ),
            const SizedBox(height: 30),

            // Lista de Notificaciones
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                children: [
                  _buildNotificationItem(
                    "¡¡Tu pedido de Audifonos samsung acaba de salir, revisa tu pestaña de seguimiento y asegurate de recibir tus productos!!",
                  ),
                  const SizedBox(height: 100), // Espacio largo según tu imagen
                  const Center(
                    child: Text(
                      "NO TIENES MAS\nNOTIFICACIONES",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white24, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 2),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(String message) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.notifications_active, color: Colors.white, size: 28),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 12, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}