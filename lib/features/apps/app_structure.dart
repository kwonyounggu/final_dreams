import 'package:flutter/material.dart';

class AppModel {
  final String title;
  final String description;
  final IconData icon;
  final String? appStoreUrl;
  final String? playStoreUrl;
  final String? githubUrl;

  AppModel({
    required this.title,
    required this.description,
    required this.icon,
    this.appStoreUrl,
    this.playStoreUrl,
    this.githubUrl,
  });
}

final List<AppModel> myApps = [
  AppModel(
    title: 'Mindful Moments',
    description: 'Meditation timer with Buddhist inspiration.',
    icon: Icons.self_improvement,
    appStoreUrl: 'https://apps.apple.com/app/id123',
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.yourapp',
  ),
  // add more
];