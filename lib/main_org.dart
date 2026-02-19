import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/home/presentation/home_page.dart';

// ignore: depend_on_referenced_packages because This is the built-in library
import 'package:flutter_web_plugins/url_strategy.dart';

void main() 
{
  usePathUrlStrategy(); // Removes the '#' from your URLs

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget 
{
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      title: 'YounG Garden',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}