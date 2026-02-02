import 'dart:ui';

String rgbToHex(Color color) {
  return '${(color.r * 255.0).round().clamp(0, 255).toRadixString(16).padLeft(2, '0')}${(color.g * 255.0).round().clamp(0, 255).toRadixString(16).padLeft(2, '0')}${(color.b * 255.0).round().clamp(0, 255).toRadixString(16).padLeft(2, '0')}';
}

Color hexToColor(String hex) {
  return Color(int.parse(hex, radix: 16) + 0xFF000000);
}
