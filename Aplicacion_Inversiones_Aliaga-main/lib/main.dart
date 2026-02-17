import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rutasinversionesaliaga/screens/Inicio_sesion.dart';
import 'package:rutasinversionesaliaga/screens/mis_pedidos_cliente.dart';
import 'package:rutasinversionesaliaga/screens/my_homepage.dart';
import 'package:rutasinversionesaliaga/screens/notificaciones_cliente.dart';
import 'package:rutasinversionesaliaga/screens/perfil_cliente.dart';
import 'package:rutasinversionesaliaga/screens/recibidos_cliente.dart';
import 'package:rutasinversionesaliaga/screens/registro_sesion.dart';
import 'package:rutasinversionesaliaga/screens/seguimiento_cliente.dart';
import 'package:rutasinversionesaliaga/screens/seguimiento_cliente_map.dart';

void main() {
  runApp(const MyApp());
}

class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usamos el color de fondo de la app (1A1A2E) para que se fusione
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        centerTitle: true,
        // Un borde inferior apenas perceptible
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.white.withOpacity(0.05), height: 1.0),
        ),

        // ICONO MENÚ (Izquierda)
        leading: PopupMenuButton<String>(
          icon: Icon(Icons.menu_rounded, color: Colors.white.withOpacity(0.8), size: 28),
          offset: const Offset(0, 55),
          // Estilo del menú flotante más relajado
          color: const Color(0xFF252545), // Azul grisáceo profundo, no blanco
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.white.withOpacity(0.1)),
          ),
          onSelected: (route) => context.go(route),
          itemBuilder: (context) => [
            _buildPopupItem('/Pedidos', Icons.inventory_2_outlined, 'Mis Pedidos'),
            _buildPopupItem('/Pedido_cliente', Icons.near_me_outlined, 'Seguimiento'),
            _buildPopupItem('/Recibidos', Icons.archive_outlined, 'Recibidos'),
          ],
        ),

        // LOGO CENTRAL
        title: GestureDetector(
          onTap: () => context.go('/Pedidos'),
          child: Image.asset(
            'assets/images/solologo.png',
            height: 35, // Un poco más pequeño para ser elegante
            fit: BoxFit.contain,
          ),
        ),

        // ICONO USUARIO (Derecha)
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.account_circle_outlined, color: Colors.white.withOpacity(0.8), size: 28),
            offset: const Offset(0, 55),
            color: const Color(0xFF252545),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
            onSelected: (route) {
              if (route == '/salir') {
                context.go('/Homepage');
              } else {
                context.go(route);
              }
            },
            itemBuilder: (context) => [
              _buildPopupItem('/Perfil', Icons.person_outline, 'Mi Perfil'),
              _buildPopupItem('/Notificaciones', Icons.notifications_none_outlined, 'Notificaciones'),
              const PopupMenuDivider(height: 1),
              _buildPopupItem('/salir', Icons.logout_rounded, 'Cerrar Sesión', isDestructive: true),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: child,
    );
  }

  // Helper mejorado para los items del menú
  PopupMenuItem<String> _buildPopupItem(String value, IconData icon, String text, {bool isDestructive = false}) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: isDestructive ? Colors.redAccent.withOpacity(0.7) : Colors.white70
          ),
          const SizedBox(width: 15),
          Text(
            text,
            style: TextStyle(
              color: isDestructive ? Colors.redAccent.withOpacity(0.8) : Colors.white.withOpacity(0.9),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
final GoRouter _router = GoRouter(
  initialLocation: '/Homepage', // Empezamos en el login
  routes: [
    // --- RUTAS SIN HEADER (Fuera del Shell) ---
    GoRoute(
          path: '/Homepage',
          builder: (context, state) => const MyHomePage(title: "Inversiones Aliaga"),
        ),
    GoRoute(
      path: '/Inicio_sesion',
      builder: (context, state) => const InicioSesionPage(),
    ),
    GoRoute(
      path: '/Registrarse',
      builder: (context, state) => const RegistroSesionPage(),
    ),

    // --- RUTAS CON HEADER (Dentro del Shell) ---
    ShellRoute(
      builder: (context, state, child) {
        return MainLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const MyHomePage(title: "Inversiones Aliaga"),
        ),
        GoRoute(
          path: '/Pedidos',
          builder: (context, state) => const Pedidos_clientePage(),
        ),
        GoRoute(
          path: '/Pedido_cliente',
          builder: (context, state) => const SeguimientoPedidoPage(pedido_id: 7,),
        ),
        GoRoute(
          path: '/Recibidos',
          builder: (context, state) => const RecibidosPedidoPage(),
        ),

        // Agregamos Perfil y Notificaciones aquí
       GoRoute(
          path: '/Perfil',
          builder: (context, state) => const PerfilClientePage(), // Asegúrate de que el nombre coincida
        ),
        GoRoute(
          path: '/Notificaciones',
          builder: (context, state) => const NotificacionesClientePage(),
        ),
          GoRoute(
          path: '/Seguimiento_mapa',
          builder: (context, state) => const SeguimientoPedidoMapaPage(),
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.orange),
    );
  }
}