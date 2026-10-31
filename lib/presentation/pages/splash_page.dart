import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../routes/app_routes.dart';

/// Pantalla inicial de bienvenida.
/// Muestra la imagen de assets/descarga.jfif como fondo de pantalla completa
/// con una capa de contraste para destacar el título y la carga durante 3 segundos.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static const Duration _duracionSplash = Duration(seconds: 3);
  Timer? _temporizador;

  @override
  void initState() {
    super.initState();
    _temporizador = Timer(_duracionSplash, () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    });
  }

  @override
  void dispose() {
    _temporizador?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Imagen de fondo a pantalla completa
          Image.asset(
            'assets/descarga.jfif',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: AppColors.primary,
            ),
          ),

          // 2. Capa oscura con degradado para garantizar contraste y legibilidad
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.35),
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),

          // 3. Contenido centrado: Logo, Título y Loader
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.4),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.flutter_dash,
                      size: 80,
                      color: AppColors.textLight,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'UserMaster',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textLight,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          offset: Offset(0, 2),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'App Base con Clean Architecture',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.textLight.withOpacity(0.9),
                      letterSpacing: 0.5,
                      shadows: const [
                        Shadow(
                          color: Colors.black54,
                          offset: Offset(0, 1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  const SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.textLight),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
