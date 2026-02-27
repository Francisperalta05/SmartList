import 'package:intl/intl.dart';

class AppDateUtils {
  /// Devuelve fecha actual en formato ISO8601
  static String nowIso() {
    return DateTime.now().toIso8601String();
  }

  /// Convierte ISO string a DateTime
  static DateTime fromIso(String iso) {
    return DateTime.parse(iso);
  }

  /// Formatea fecha a formato legible (ej: 27 Feb 2026)
  static String formatReadable(String iso) {
    final date = DateTime.parse(iso);
    return DateFormat('dd MMM yyyy').format(date);
  }
}