import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Sửa lỗi: Bỏ dấu ngoặc đơn thừa ngoài cùng
final appTheme = (BuildContext context) {
  final textTheme = GoogleFonts.interTextTheme(Theme.of(context).textTheme);
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF1A1C2E),
    primaryColor: const Color(0xFF6E5FFF),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF6E5FFF),
      secondary: Color(0xFF03DAC6),
      background: Color(0xFF1A1C2E),
      surface: Color(0xFF2C2F48),
    ),
    textTheme: textTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF1A1C2E),
      elevation: 0,
      titleTextStyle: textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      // Thêm iconTheme để icon AppBar có màu trắng
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF2C2F48),
      selectedItemColor: const Color(0xFF6E5FFF),
      unselectedItemColor: Colors.white54,
      type: BottomNavigationBarType.fixed,
      // Thêm label style
      selectedLabelStyle: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
      unselectedLabelStyle: textTheme.labelSmall,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6E5FFF),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        // Thêm style cho nút bị vô hiệu hóa
        disabledBackgroundColor: const Color(0xFF6E5FFF).withOpacity(0.5),
        disabledForegroundColor: Colors.white.withOpacity(0.7),
      ),
    ),
    // Thêm style cho Card
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.white70,
    ),
    // Thêm style cho SnackBar
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      contentTextStyle: textTheme.bodyMedium?.copyWith(color: Colors.white),
    ),
    // Thêm style cho Dialog
    dialogTheme: DialogTheme(
      backgroundColor: const Color(0xFF2C2F48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titleTextStyle: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      contentTextStyle: textTheme.bodyMedium,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2C2F48),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: textTheme.bodyMedium?.copyWith(color: Colors.white38),
      // Thêm màu cho prefixIcon
      prefixIconColor: Colors.white54,
    ),
  );
};

// Sửa lỗi: Xóa dấu } thừa
// } // <-- Xóa dòng này
