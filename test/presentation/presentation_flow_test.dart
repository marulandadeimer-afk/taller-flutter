import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/app.dart';
import 'package:flutter_application_1/presentation/pages/dashboard_page.dart';
import 'package:flutter_application_1/presentation/pages/forgot_password_page.dart';
import 'package:flutter_application_1/presentation/pages/login_page.dart';
import 'package:flutter_application_1/presentation/pages/profile_page.dart';
import 'package:flutter_application_1/presentation/pages/register_page.dart';
import 'package:flutter_application_1/presentation/pages/splash_page.dart';
import 'package:flutter_application_1/presentation/routes/app_routes.dart';

void main() {
  testWidgets('SplashPage se muestra y redirige a LoginPage tras 3 segundos', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const UserMasterApp());

    // Se encuentra en Splash
    expect(find.byType(SplashPage), findsOneWidget);
    expect(find.text('UserMaster'), findsOneWidget);

    // Avanza exactamente los 3 segundos
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // Redirige al Login
    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.text('Iniciar Sesión'), findsOneWidget);
  });

  testWidgets('LoginPage valida campos vacíos', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    await tester.tap(find.text('Ingresar'));
    await tester.pump();

    expect(find.text('Ingresa tu correo'), findsOneWidget);
    expect(find.text('Ingresa tu contraseña'), findsOneWidget);
  });

  testWidgets('Navegación desde Login a Registro y Recuperación de Contraseña', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      MaterialApp(
        initialRoute: AppRoutes.login,
        routes: appRoutes,
      ),
    );

    // Navega a Recuperar Contraseña
    final enlaceOlvido = find.text('¿Olvidaste tu contraseña?');
    expect(enlaceOlvido, findsOneWidget);
    await tester.tap(enlaceOlvido);
    await tester.pumpAndSettle();

    expect(find.byType(ForgotPasswordPage), findsOneWidget);

    // Regresa al login
    await tester.tap(find.text('Volver al inicio de sesión'));
    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsOneWidget);

    // Navega a Registro
    final enlaceRegistro = find.text('Registrarse');
    expect(enlaceRegistro, findsOneWidget);
    await tester.tap(enlaceRegistro);
    await tester.pumpAndSettle();

    expect(find.byType(RegisterPage), findsOneWidget);
    expect(find.text('Crear cuenta'), findsWidgets);
  });

  testWidgets('RegisterPage valida que las contraseñas coincidan', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const MaterialApp(home: RegisterPage()));

    // Ingresa contraseñas diferentes
    final textFields = find.byType(TextFormField);
    await tester.enterText(textFields.at(0), 'Carlos Perez');
    await tester.enterText(textFields.at(1), 'carlos@test.com');
    await tester.enterText(textFields.at(2), '123456');
    await tester.enterText(textFields.at(3), '654321');

    final botonCrear = find.widgetWithText(ElevatedButton, 'Crear cuenta');
    await tester.ensureVisible(botonCrear);
    await tester.pumpAndSettle();
    await tester.tap(botonCrear);
    await tester.pumpAndSettle();

    expect(find.text('Las contraseñas no coinciden'), findsOneWidget);
  });

  testWidgets('DashboardPage contiene saludo Hola, Usuario y al menos 5 Cards', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const MaterialApp(home: DashboardPage()));

    expect(find.text('Hola, Usuario'), findsOneWidget);
    expect(find.byType(Card), findsAtLeastNWidgets(5));
    expect(find.byType(BottomNavigationBar), findsOneWidget);

    // Cambiar al tab de Perfil
    await tester.tap(find.text('Perfil'));
    await tester.pumpAndSettle();

    expect(find.byType(ProfilePage), findsOneWidget);
    expect(find.text('Cerrar sesión'), findsOneWidget);
  });
}
