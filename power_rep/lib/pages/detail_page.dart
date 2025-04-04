import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String title;
  final String information;
  final String imageUrl; // This will be the second image

  const DetailPage({
    Key? key,
    required this.title,
    required this.information,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF302B2B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF302B2B),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the second image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
              const SizedBox(height: 24),
              // Title
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Detailed Information
              Text(
                information,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              // Extra information (if needed)
              const Text(
                "Información adicional:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "En esta sección se profundiza en cada uno de los aspectos fundamentales para un entrenamiento seguro y efectivo en Streetlifting. Se recomienda leer detenidamente y seguir las indicaciones para maximizar los beneficios del entrenamiento. Mantén siempre una técnica adecuada y escucha a tu cuerpo para evitar lesiones.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Recuerda que la constancia, el descanso y una buena alimentación son claves para lograr una mejora continua en tus rutinas. Utiliza este material educativo para reforzar tus conocimientos y complementar tu entrenamiento diario.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
