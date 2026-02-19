import 'package:final_dreams/core/theme/app_theme.dart';
import 'package:final_dreams/providers/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';


void main() 
{
  usePathUrlStrategy(); // Removes the '#' from your URLs
  WidgetsFlutterBinding.ensureInitialized(); // Ensure this is here
  runApp
  (
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget 
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) 
  {
    final GoRouter router = ref.watch(routerProvider);

    return MaterialApp.router
    (
      routerConfig: router,
      title: 'YounG',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
    );
  }
}