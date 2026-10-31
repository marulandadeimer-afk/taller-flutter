import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'profile_page.dart';

/// Pantalla Principal (Dashboard).
/// Incluye un BottomNavigationBar con 2 pestañas: Inicio y Perfil.
/// Utiliza assets/descarga.jfif como fondo visual con una capa traslúcida
/// para mantener la legibilidad de las tarjetas y el contenido.
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  // Lista simulada de al menos 5 elementos recientes (notificaciones / tareas)
  final List<Map<String, dynamic>> _elementosRecientes = [
    {
      'titulo': 'Configuración de Clean Architecture',
      'descripcion': 'Se estructuraron las capas core, data, domain y presentation.',
      'categoria': 'Sistema',
      'icono': Icons.architecture,
      'color': Colors.blue,
      'tiempo': 'Hace 5 min',
    },
    {
      'titulo': 'Inicio de sesión completado',
      'descripcion': 'Autenticación exitosa en UserMaster mediante estado local.',
      'categoria': 'Seguridad',
      'icono': Icons.verified_user,
      'color': Colors.green,
      'tiempo': 'Hace 20 min',
    },
    {
      'titulo': 'Revisar entregable de Taller 2',
      'descripcion': 'Verificar la rúbrica y los commits solicitados por el profesor.',
      'categoria': 'Tarea',
      'icono': Icons.assignment,
      'color': Colors.orange,
      'tiempo': 'Hace 1 hora',
    },
    {
      'titulo': 'Actualización de Perfil de Usuario',
      'descripcion': 'Los datos del usuario activo fueron sincronizados correctamente.',
      'categoria': 'Usuario',
      'icono': Icons.person,
      'color': Colors.purple,
      'tiempo': 'Hace 2 horas',
    },
    {
      'titulo': 'Verificación de GitHub Pages',
      'descripcion': 'Pipeline de CI/CD listo para el despliegue automático.',
      'categoria': 'Despliegue',
      'icono': Icons.cloud_done,
      'color': Colors.teal,
      'tiempo': 'Hace 3 horas',
    },
    {
      'titulo': 'Pruebas de widgets aprobadas',
      'descripcion': 'Se validaron los flujos de login, navegación y creación de cuenta.',
      'categoria': 'Calidad',
      'icono': Icons.check_circle_outline,
      'color': Colors.indigo,
      'tiempo': 'Hace 4 horas',
    },
  ];

  Widget _buildInicioTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Encabezado de bienvenida
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Hola, Usuario',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textLight,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.notifications_outlined,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Bienvenido a tu panel de control UserMaster',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textLight.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Título de la sección de elementos recientes
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Actividad Reciente',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '6 elementos',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // ListView con al menos 5 tarjetas (Card)
        ..._elementosRecientes.map((item) {
          final icono = item['icono'] as IconData;
          final color = item['color'] as Color;

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppColors.border),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icono, color: color, size: 26),
              ),
              title: Text(
                item['titulo'] as String,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: AppColors.textPrimary,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    item['descripcion'] as String,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          item['categoria'] as String,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item['tiempo'] as String,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: AppColors.textMuted,
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Seleccionaste: ${item['titulo']}'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0 ? 'UserMaster - Dashboard' : 'Perfil de Usuario'),
        automaticallyImplyLeading: false, // Sin flecha de retroceso en el dashboard
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Imagen de fondo del dashboard
          Image.asset(
            'assets/images.jfif',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Image.asset(
              'assets/images.jpg',
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => Container(
                color: AppColors.background,
              ),
            ),
          ),

          // 2. Capa translúcida suave para que las Cards resalten
          Container(
            color: Colors.white.withOpacity(0.88),
          ),

          // 3. Contenido de las pestañas
          SafeArea(
            child: _currentIndex == 0
                ? _buildInicioTab()
                : const ProfilePage(showAppBar: false),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        backgroundColor: AppColors.surface,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
