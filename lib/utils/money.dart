import 'dart:math';

String formatCents(int cents) {
  final sign = cents < 0 ? '-' : '';
  final v = cents.abs();
  final dollars = v ~/ 100;
  final rem = v % 100;
  return '$sign\$$dollars.${rem.toString().padLeft(2, '0')}';
}

String formatCentsCompact(int cents) {
  final sign = cents < 0 ? '-' : '';
  final v = cents.abs();
  if (v >= 100000) {
    final k = v / 100000;
    return '$sign\$${k.toStringAsFixed(1)}k';
  }
  final dollars = v ~/ 100;
  final rem = v % 100;
  return '$sign\$$dollars.${rem.toString().padLeft(2, '0')}';
}

int parseDollarsToCents(String s) {
  final cleaned = s.replaceAll('\$', '').replaceAll(',', '').trim();
  if (cleaned.isEmpty) return 0;
  
  // Handle negative values
  final isNegative = cleaned.startsWith('-');
  final absValue = cleaned.replaceAll('-', '');
  
  final parts = absValue.split('.');
  final dollars = int.tryParse(parts[0]) ?? 0;
  int cents = 0;
  
  if (parts.length > 1) {
    String centsPart = parts[1];
    if (centsPart.length == 1) {
      cents = (int.tryParse(centsPart) ?? 0) * 10;
    } else {
      cents = int.tryParse(centsPart.substring(0, min(2, centsPart.length))) ?? 0;
    }
  }
  
  final result = max(0, dollars * 100 + cents);
  return isNegative ? -result : result;
}

String centsToInputString(int cents) {
  final dollars = cents ~/ 100;
  final rem = cents % 100;
  if (rem == 0) {
    return dollars.toString();
  }
  return '$dollars.${rem.toString().padLeft(2, '0')}';
}
