import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const ButtonPrimary({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 58,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        // Sutil resplandor del color del botón
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          // EFECTO TRANSPARENTE: Ajustamos la opacidad aquí (0.4 o 0.5 es ideal)
          backgroundColor: color.withOpacity(0.5), 
          foregroundColor: Colors.white,
          elevation: 0,
          // BORDE REFINADO: Ayuda a que el botón resalte sobre el fondo oscuro
          side: BorderSide(color: Colors.white.withOpacity(0.3), width: 1.2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.bold, 
            letterSpacing: 1.2
          ),
        ),
      ),
    );
  }
}

class ButtonSocial extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String imageUrl;

  const ButtonSocial({
    super.key,
    required this.text,
    required this.onPressed,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.5),
          borderRadius: BorderRadius.circular(15),
          color: Colors.white.withOpacity(0.1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(imageUrl, height: 22),
            const SizedBox(width: 12),
            Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}