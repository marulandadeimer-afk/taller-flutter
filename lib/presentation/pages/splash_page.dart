import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../routes/app_routes.dart';

/// Pantalla inicial de bienvenida.
/// Muestra la imagen descargada en assets centrada con el color principal de fondo
/// durante 3 segundos antes de redirigir automáticamente a la pantalla de Inicio de Sesión.
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
      backgroundColor: AppColors.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Contenedor con la imagen descargada en assets
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                  border: Border.all(color: Colors.white, width: 3.5),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/descarga.jfif',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.white.withOpacity(0.2),
                      child: const Icon(
                        Icons.flutter_dash,
                        size: 80,
                        color: AppColors.textLight,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'UserMaster',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textLight,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'App Base con Clean Architecture',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textLight.withOpacity(0.85),
                ),
              ),
              const SizedBox(height: 40),
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
    );
  }
}
