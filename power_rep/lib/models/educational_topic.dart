import 'dart:convert';
import 'package:flutter/services.dart';

class EducationalTopic {
  final String title;
  final String information;
  final List<String> images;

  EducationalTopic({
    required this.title,
    required this.information,
    required this.images,
  });

  factory EducationalTopic.fromJson(Map<String, dynamic> json) {
    return EducationalTopic(
      title: json['title'],
      information: json['information'],
      images: List<String>.from(json['images']),
    );
  }

  // Function to load and parse JSON data from assets.
  Future<List<EducationalTopic>> loadTopics() async {
    final String jsonString = await rootBundle.loadString(
      'assets/educational_content.json',
    );
    final Map<String, dynamic> jsonResponse = json.decode(jsonString);
    final List topicsJson = jsonResponse['educationalContent'];
    return topicsJson
        .map((topicJson) => EducationalTopic.fromJson(topicJson['DetailPage']))
        .toList();
  }
}
