import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

/// Pantalla de Inicio de Sesión.
/// Muestra la imagen assets/descarga.jfif como fondo y un formulario centrado
/// con estilo glassmorphism. Simula una carga de 2 segundos y redirige al Dashboard.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _ocultarContrasena = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _iniciarSesion() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // Simula tiempo de autenticación por 2 segundos según especificación
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Bienvenido, ${_emailController.text.trim()}'),
        backgroundColor: AppColors.success,
        duration: const Duration(seconds: 2),
      ),
    );

    // Redirige al Dashboard eliminando el Login del stack
    Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Imagen de fondo
          Image.asset(
            'assets/images.jfif',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Image.asset(
              'assets/images.jpg',
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => Container(
                color: AppColors.primary,
              ),
            ),
          ),

          // 2. Capa oscura para contraste
          Container(
            color: Colors.black.withOpacity(0.45),
          ),

          // 3. Formulario centrado
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 440),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.94),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.12),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.lock_person_outlined,
                            size: 54,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Iniciar Sesión',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Ingresa a tu cuenta de UserMaster',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 26),

                        // Campo Correo electrónico
                        CustomTextField(
                          controller: _emailController,
                          labelText: 'Correo electrónico',
                          hintText: 'ejemplo@correo.com',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            final correo = value?.trim() ?? '';
                            if (correo.isEmpty) return 'Ingresa tu correo';
                            if (!correo.contains('@') || !correo.contains('.')) {
                              return 'Ingresa un correo válido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Campo Contraseña
                        CustomTextField(
                          controller: _passwordController,
                          labelText: 'Contraseña',
                          prefixIcon: Icons.lock_outline,
                          obscureText: _ocultarContrasena,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _ocultarContrasena
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: AppColors.textSecondary,
                            ),
                            onPressed: () {
                              setState(() {
                                _ocultarContrasena = !_ocultarContrasena;
                              });
                            },
                          ),
                          validator: (value) {
                            if ((value ?? '').isEmpty) return 'Ingresa tu contraseña';
                            if (value!.length < 6) return 'Mínimo 6 caracteres';
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),

                        // Enlace ¿Olvidaste tu contraseña?
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.forgotPassword);
                            },
                            child: const Text(
                              '¿Olvidaste tu contraseña?',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Botón "Ingresar"
                        CustomButton(
                          text: 'Ingresar',
                          isLoading: _isLoading,
                          onPressed: _iniciarSesion,
                        ),
                        const SizedBox(height: 20),

                        // Enlace a Registro
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '¿No tienes cuenta?',
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, AppRoutes.register);
                              },
                              child: const Text(
                                'Registrarse',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
