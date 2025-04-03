import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TutorialsPage extends StatelessWidget {
  const TutorialsPage({super.key});

  // A new button builder that does not force an Expanded size.
  Widget buildTutorialButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFEC221F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.all(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.ondemand_video, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // This builds a tutorial item with an image (bigger) above the button (smaller).
  Widget buildTutorialItem(
    String imageUrl,
    String text,
    VoidCallback onPressed,
  ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // The image takes a larger portion of the space.
          Expanded(flex: 4, child: Image.network(imageUrl, fit: BoxFit.cover)),
          const SizedBox(height: 8),
          // The button takes a smaller portion.
          Flexible(flex: 1, child: buildTutorialButton(text, onPressed)),
        ],
      ),
    );
  }

  // Helper method to launch a URL in the external browser.
  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $urlString';
    }
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
              // Back button
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
                "TUTORIALES",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // The tutorial items are arranged in an Expanded column.
              Expanded(
                child: Column(
                  children: [
                    buildTutorialItem(
                      "https://hips.hearstapps.com/hmg-prod/images/screen-shot-2020-03-12-at-1-41-30-pm-1584034895.png?crop=0.8373408769448374xw:1xh;center,top", // Replace with your pull-ups image URL
                      "PULL UPS",
                      () {
                        _launchURL(
                          "https://www.youtube.com/watch?v=K-g9y7lyQ-o&t=496s",
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    buildTutorialItem(
                      "https://www.dmoose.com/cdn/shop/articles/weighted-dip-main.jpg?v=1625843615", // Replace with your dips image URL
                      "DIPS",
                      () {
                        _launchURL(
                          "https://www.youtube.com/watch?v=1Vm1ATIi0AE",
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    buildTutorialItem(
                      "https://www.newbodyplan.co.uk/wp-content/uploads/2021/12/Squat-like-a-pro-burn-fat-leg-strength-muscle.jpg", // Replace with your squats image URL
                      "SQUATS",
                      () {
                        _launchURL(
                          "https://www.youtube.com/watch?v=UoNUa07sb6Q&t=239s",
                        );
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
}
