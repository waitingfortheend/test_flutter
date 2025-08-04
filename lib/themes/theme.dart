// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.orange, // สีส้มหลักสำหรับสร้าง ColorScheme
      brightness: Brightness.light,
      primary: Colors.deepOrange, // สีหลักที่ใช้บ่อย (ปุ่ม, แถบ)
      onPrimary: Colors.white,
      secondary: Colors.orangeAccent, // สีรอง
      onSecondary: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black87,
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.white, // AppBar สีขาว
      foregroundColor: Colors.black87,
      elevation: 2.0,
      iconTheme: IconThemeData(color: Colors.black87),
      titleTextStyle: TextStyle(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    scaffoldBackgroundColor:
        Colors.orange[50], // พื้นหลัง Scafold สีขาวอมส้มอ่อนๆ
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.deepOrange,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        elevation: 2,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.deepOrange,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.orange[100], // พื้นหลัง TextField สีส้มอ่อนมาก
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.deepOrange, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.orange[300]!, width: 1.0),
      ),
      labelStyle: TextStyle(color: Colors.grey[700]),
      hintStyle: TextStyle(color: Colors.grey[500]),
      errorStyle: const TextStyle(color: Colors.redAccent),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.deepOrange),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black87),
      bodyMedium: TextStyle(fontSize: 14.0, color: Colors.black54),
      titleLarge: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      titleMedium: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(8),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titleTextStyle: TextStyle(
        color: Colors.grey[800],
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: TextStyle(color: Colors.grey[700], fontSize: 16),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.deepOrange,
      contentTextStyle: const TextStyle(color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      behavior: SnackBarBehavior.floating,
      elevation: 4,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.orange,
      brightness: Brightness.dark,
      primary: Colors.orangeAccent[400], // สีหลักใน Dark Mode (ส้มสด)
      onPrimary: Colors.black,
      secondary: Colors.deepOrangeAccent,
      onSecondary: Colors.black,
      surface: const Color(0xFF1E1E1E), // พื้นผิว (Card, Dialog)
      onSurface: Colors.white70,
      background: const Color(0xFF121212), // พื้นหลัง Scaffold (ดำสนิท)
      onBackground: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.black, // AppBar สีดำ
      foregroundColor: Colors.white,
      elevation: 2.0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    scaffoldBackgroundColor: const Color(
      0xFF121212,
    ), // พื้นหลัง Scaffold สีดำสนิท
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.orangeAccent[400],
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orangeAccent[400],
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        elevation: 2,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.orangeAccent[400],
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[900], // พื้นหลัง TextField สีเทาเข้ม
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.orangeAccent[400]!, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[700]!, width: 1.0),
      ),
      labelStyle: TextStyle(color: Colors.grey[200]),
      hintStyle: TextStyle(color: Colors.grey[400]),
      errorStyle: const TextStyle(color: Colors.redAccent),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
    ),
    iconTheme: IconThemeData(color: Colors.orangeAccent[400]),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16.0, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 14.0, color: Colors.white70),
      titleLarge: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      labelLarge: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    cardTheme: CardTheme(
      color: const Color(0xFF1E1E1E), // Card สีเทาเข้ม
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(8),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titleTextStyle: TextStyle(
        color: Colors.orange[100],
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: TextStyle(color: Colors.orange[200], fontSize: 16),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.orangeAccent[400],
      contentTextStyle: const TextStyle(color: Colors.black87),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      behavior: SnackBarBehavior.floating,
      elevation: 4,
    ),
  );
}
