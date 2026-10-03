// ============================================================
// Práctica 3: Universidad TI (Simulador de Celular con Navegación Interna)
// Archivo: lib/main.dart
// ============================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// MyApp configura la app globalmente.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Universidad TI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D47A1)),
        useMaterial3: true,
      ),
      // Mantiene el marco del celular en la laptop/escritorio
      home: const SimuladorCelular(),
    );
  }
}

// ---------------------------------------------------------------------
// WIDGET: Simulador de Celular para PC / Laptop con Navegación Propia
// ---------------------------------------------------------------------
class SimuladorCelular extends StatelessWidget {
  const SimuladorCelular({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C), // Fondo oscuro de escritorio
      body: Center(
        child: Container(
          width: 390,  // Ancho de smartphone moderno
          height: 800, // Alto de smartphone moderno
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40), // Esquinas del celular
            border: Border.all(
              color: const Color(0xFF333333), // Marco físico simulado
              width: 10,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 25,
                spreadRadius: 5,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30), // Recorte interno
            // Usamos un MaterialApp interno con un Navigator propio para que
            // las transiciones (push y pop) ocurran SOLAMENTE dentro del celular.
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D47A1)),
                useMaterial3: true,
              ),
              home: const PantallaPrincipal(),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// MODELO: describe la información que necesita CADA carrera.
// ---------------------------------------------------------------------
class Carrera {
  final String nombre;
  final IconData icono;    // el ícono hace de "imagen representativa"
  final Color color;
  final String descripcion;

  const Carrera({
    required this.nombre,
    required this.icono,
    required this.color,
    required this.descripcion,
  });
}

// ---------------------------------------------------------------------
// ARREGLO: una sola lista con las cinco carreras en español.
// ---------------------------------------------------------------------
const List<Carrera> carreras = [
  Carrera(
    nombre: 'Ingeniería en Desarrollo de Software',
    icono: Icons.code,
    color: Color(0xFF3F51B5),
    descripcion:
        'Forma profesionales capaces de diseñar, construir y mantener '
        'aplicaciones y sistemas de software de calidad, aplicando '
        'metodologías ágiles y buenas prácticas de programación para '
        'resolver problemas reales con tecnología.',
  ),
  Carrera(
    nombre: 'Ingeniería en Infraestructura de Redes',
    icono: Icons.hub,
    color: Color(0xFF00897B),
    descripcion:
        'Prepara especialistas en el diseño, instalación y administración '
        'de redes de datos, centros de cómputo y servicios en la nube, '
        'garantizando la conectividad, el rendimiento y la seguridad de '
        'la infraestructura tecnológica.',
  ),
  Carrera(
    nombre: 'Ingeniería en Inteligencia Artificial y Ciencia de Datos',
    icono: Icons.memory,
    color: Color(0xFF5E35B1),
    descripcion:
        'Combina matemáticas, programación y aprendizaje automático para '
        'desarrollar modelos y sistemas inteligentes capaces de analizar '
        'grandes volúmenes de información y apoyar la toma de decisiones.',
  ),
  Carrera(
    nombre: 'Licenciatura en Ciencia de Datos',
    icono: Icons.bar_chart,
    color: Color(0xFF1E88E5),
    descripcion:
        'Forma profesionales que recolectan, limpian, analizan y '
        'visualizan datos para convertirlos en información útil, '
        'combinando estadística, programación y conocimiento del negocio.',
  ),
  Carrera(
    nombre: 'Ingeniería en Ciberseguridad',
    icono: Icons.shield,
    color: Color(0xFF37474F),
    descripcion:
        'Prepara especialistas en proteger la información, las redes y '
        'los sistemas de una organización frente a amenazas digitales, '
        'mediante la identificación de vulnerabilidades y buenas '
        'prácticas de seguridad.',
  ),
];

// ---------------------------------------------------------------------
// PANTALLA 1: PRINCIPAL (rejilla de carreras)
// ---------------------------------------------------------------------
class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Universidad TI'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: carreras.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,     // dos columnas
          mainAxisSpacing: 14,   // espacio vertical entre tarjetas
          crossAxisSpacing: 14,  // espacio horizontal entre tarjetas
          childAspectRatio: 0.85,
        ),
        itemBuilder: (BuildContext context, int indice) {
          final Carrera carrera = carreras[indice];
          return _TarjetaCarrera(carrera: carrera);
        },
      ),
    );
  }
}

// Tarjeta reutilizable para cada carrera.
class _TarjetaCarrera extends StatelessWidget {
  final Carrera carrera;

  const _TarjetaCarrera({required this.carrera});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext contexto) =>
                  PantallaContenido(carrera: carrera),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: carrera.color,
                child: Icon(carrera.icono, color: Colors.white, size: 30),
              ),
              const SizedBox(height: 12),
              Text(
                carrera.nombre,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// PANTALLA 2: CONTENIDO (detalle de una carrera)
// ---------------------------------------------------------------------
class PantallaContenido extends StatelessWidget {
  final Carrera carrera;

  const PantallaContenido({super.key, required this.carrera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contenido')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            CircleAvatar(
              radius: 60,
              backgroundColor: carrera.color,
              child: Icon(carrera.icono, color: Colors.white, size: 60),
            ),
            const SizedBox(height: 20),
            Text(
              carrera.nombre,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              carrera.descripcion,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Regresar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}