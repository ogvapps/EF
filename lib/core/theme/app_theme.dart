import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // Core palette
  static const Color deepNavy = Color(0xFF0B0E1A);
  static const Color darkPurple = Color(0xFF1A1040);
  static const Color surfaceDark = Color(0xFF161C30);
  static const Color surfaceCard = Color(0xFF1E2540);

  // Gradientes principales
  static const List<Color> primaryGradient = [Color(0xFF7C4DFF), Color(0xFFFF6B9D)];
  static const List<Color> secondaryGradient = [Color(0xFF00D4FF), Color(0xFF0091EA)];
  static const List<Color> accentGradient = [Color(0xFF00E676), Color(0xFF00BFA5)];
  static const List<Color> goldGradient = [Color(0xFFFFD700), Color(0xFFFFAB00)];
  static const List<Color> bgGradient = [Color(0xFF0B0E1A), Color(0xFF1A1040)];
  static const List<Color> fireGradient = [Color(0xFFFF6B35), Color(0xFFFFD700)];
  static const List<Color> iceGradient = [Color(0xFF00D4FF), Color(0xFF7C4DFF)];
  static const List<Color> neonPink = [Color(0xFFFF2D95), Color(0xFF7C4DFF)];
  static const List<Color> emeraldGradient = [Color(0xFF00E676), Color(0xFF00BCD4)];

  // Sólidos
  static const Color primary = Color(0xFF7C4DFF);
  static const Color secondary = Color(0xFF00D4FF);
  static const Color accent = Color(0xFF00E676);
  static const Color gold = Color(0xFFFFD700);
  static const Color silver = Color(0xFFC0C0C0);
  static const Color bronze = Color(0xFFCD7F32);
  static const Color error = Color(0xFFFF5252);
  static const Color surface = surfaceDark;
  static const Color background = deepNavy;

  static Color withOpacity(Color c, double op) => c.withValues(alpha: op);

  // Sombras neon
  static List<BoxShadow> neonShadow(Color color, {double blur = 20, double spread = 2}) => [
    BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: blur, spreadRadius: spread),
    BoxShadow(color: color.withValues(alpha: 0.15), blurRadius: blur * 2, spreadRadius: spread * 0.5),
  ];

  static BoxDecoration glassmorphism({
    Color? color,
    double opacity = 0.06,
    double blur = 24,
    Color borderColor = Colors.white,
    double borderOpacity = 0.06,
    double radius = 24,
  }) {
    return BoxDecoration(
      color: (color ?? Colors.white).withValues(alpha: opacity),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: Colors.white.withValues(alpha: borderOpacity)),
      boxShadow: [
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.02),
          blurRadius: blur,
          spreadRadius: -4,
        ),
      ],
    );
  }

  // Animaciones
  static const Duration fastAnim = Duration(milliseconds: 200);
  static const Duration medAnim = Duration(milliseconds: 400);
  static const Duration slowAnim = Duration(milliseconds: 800);
  static const Curve springCurve = Curves.easeOutCubic;
  static const Curve bounceCurve = Curves.elasticOut;

  // Tipografía
  static TextStyle _font(double size, {FontWeight w = FontWeight.w400, double h = 1.3}) =>
      GoogleFonts.poppins(fontSize: size, fontWeight: w, height: h, color: Colors.white);

  static TextStyle get displayLarge => _font(36, w: FontWeight.w800);
  static TextStyle get displayMedium => _font(28, w: FontWeight.w800);
  static TextStyle get heading => _font(22, w: FontWeight.w700);
  static TextStyle get subheading => _font(18, w: FontWeight.w600);
  static TextStyle get body => _font(14, w: FontWeight.w400);
  static TextStyle get caption => _font(12, w: FontWeight.w400);
  static TextStyle get label => _font(14, w: FontWeight.w600);
  static TextStyle get button => _font(16, w: FontWeight.w700);

  // Espaciado
  static EdgeInsets get padding => const EdgeInsets.all(20);
  static EdgeInsets get cardPadding => const EdgeInsets.all(16);
  static double get cardRadius => 16;

  // Tema Material 3 completo
  static ThemeData get darkTheme {
    const colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: primary,
      onPrimary: Colors.white,
      secondary: secondary,
      onSecondary: Colors.white,
      tertiary: accent,
      onTertiary: Colors.white,
      error: error,
      onError: Colors.white,
      surface: surfaceDark,
      onSurface: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: deepNavy,
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: _font(20, w: FontWeight.w700),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.06),
        labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
        prefixIconColor: Colors.white54,
        suffixIconColor: Colors.white54,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: error),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
          textStyle: _font(16, w: FontWeight.w700),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: _font(15, w: FontWeight.w600),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: surfaceCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        titleTextStyle: _font(20, w: FontWeight.w700),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: surfaceCard,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      dividerTheme: DividerThemeData(
        color: Colors.white.withValues(alpha: 0.08),
        thickness: 1,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.white.withValues(alpha: 0.08),
        labelStyle: _font(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide.none,
      ),
      cardTheme: CardThemeData(
        color: surfaceCard,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primary,
        linearTrackColor: Colors.white12,
      ),
    );
  }
}
