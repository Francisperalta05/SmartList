import 'package:flutter/material.dart';

class AppColors {
  // Background principal
  static const Color background = Color(0xFF0F1115);

  // Cards / superficies
  static const Color card = Color(0xFF1A1D24);

  // Primario (botones, highlights)
  static const Color primary = Color(0xFF6C5CE7);

  // Accent secundario
  static const Color accent = Color(0xFF00CEC9);

  // Estados
  static const Color success = Color(0xFF00B894);
  static const Color danger = Color(0xFFD63031);
  static const Color warning = Color(0xFFFDCB6E);

  // Textos
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFB2BEC3);

  // Gradiente principal (para headers o fondos)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6C5CE7), Color(0xFF00CEC9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Gradiente oscuro suave (background elegante)
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFF0F1115), Color(0xFF1C1F26)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
