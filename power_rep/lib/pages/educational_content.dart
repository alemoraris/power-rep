import 'package:flutter/material.dart';

class EducationalContent extends StatelessWidget {
  const EducationalContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF302B2B),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back arrow
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Title
              const Text(
                "CONTENIDO EDUCATIVO",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              // Subtitle / Section Title
              const Text(
                "TEMAS",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 20),

              // Topics list
              Expanded(
                child: ListView(
                  children: [
                    _buildTopicCard(
                      context,
                      title: "Correcto calentamiento",
                      imageUrl:
                          "https://cdn.shopify.com/s/files/1/0752/5585/files/resistance_bands_12_1024x1024.jpg?v=1685799654", // Replace with your image URL
                      onPressed: () {
                        // Navigate or show more info for 'Correcto calentamiento'
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTopicCard(
                      context,
                      title: "Material recomendado y su uso adecuado",
                      imageUrl:
                          "https://ericflag.com/cdn/shop/files/corde-lest-2000.jpg", // Replace with your image URL
                      onPressed: () {
                        // Navigate or show more info for 'Material recomendado...'
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTopicCard(
                      context,
                      title:
                          "Ejercicios auxiliares para los ejercicios principales",
                      imageUrl:
                          "https://merrittclubs.com/wp-content/uploads/2023/11/weight-machine-blog-2.jpg", // Replace with your image URL
                      onPressed: () {
                        // Navigate or show more info for 'Ejercicios auxiliares...'
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to build each topic card with a real image from the internet.
  Widget _buildTopicCard(
    BuildContext context, {
    required String title,
    required String imageUrl,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF3B3636),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Real image from the internet
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),

          // Topic title
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // "Leer más" button
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEC221F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Leer más",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
