import 'package:flutter/material.dart';

import 'calculator_page.dart';
import 'educational_content.dart';
import 'tutorials_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget buildButton(String text, VoidCallback onPressed) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFEC221F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          // Internal padding can be adjusted if needed.
          padding: const EdgeInsets.all(8),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF302B2B),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
          child: Column(
            children: [
              // Row for the BACK button
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
              const Text(
                "¿Qué hacemos hoy?",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Limit the total height of the buttons with SizedBox.
              SizedBox(
                height: 300, // Adjust this value as needed.
                child: Column(
                  children: [
                    buildButton("VER RUTINAS", () {
                      // TODO: Navigate to Routines Page
                    }),
                    const SizedBox(height: 16),
                    buildButton("CALCULADORA RM", () {
                      // TODO: Navigate to RM Calculator Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CalculadoraRMPage(),
                        ),
                      );
                    }),
                    const SizedBox(height: 16),
                    buildButton("TUTORIALES", () {
                      // TODO: Navigate to Tutorials Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TutorialsPage(),
                        ),
                      );
                    }),
                    const SizedBox(height: 16),
                    buildButton("CONTENIDO EDUCATIVO", () {
                      // TODO: Navigate to Educational Content Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EducationalContent(),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
