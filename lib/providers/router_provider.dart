import 'package:final_dreams/core/errors/not_found_screen.dart';
import 'package:final_dreams/features/about/about_screen.dart';

import 'package:final_dreams/features/travel/presentation/travel_screen.dart';
import 'package:final_dreams/features/home/presentation/home_screen.dart';

import 'package:final_dreams/features/music/presentation/music_screen.dart';
import 'package:final_dreams/features/projects/presentation/projects_screen.dart';
import 'package:final_dreams/features/shared/widgets/top_menu.dart';
import 'package:final_dreams/features/study/study_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

final logger = Logger();

final routerProvider = Provider<GoRouter>
(
  (ref) 
  {
    return GoRouter
    (
      // REMOVE or comment out initialLocation: '/',
      // This allows the router to respect the browser's URL on a fresh load
      debugLogDiagnostics: true,
      routes: 
      [
        ShellRoute
        (
          builder: (context, state, child) 
          {
            return Scaffold
            (
              appBar: TopMenu
              (
                currentLocation: state.matchedLocation,
              ),
              drawer: _buildDrawer(context, state.matchedLocation),
              body: child,
            );
          },
          routes: 
          [
            GoRoute
            (
              path: '/',
              name: 'home',
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute
            (
              path: '/about',
              name: 'about',
              builder: (context, state) => const AboutScreen(),
            ),
            GoRoute
            (
              path: '/music',
              name: 'music',
              builder: (context, state) => const MusicScreen(),
            ),
            // In router_provider.dart
            
            GoRoute(
              path: '/study',
              name: 'study',
              // 4. Clicking 'Study' menu directly displays the Library Overview (topic is null)
              pageBuilder: (context, state) => NoTransitionPage(
                child: Title(
                  title: 'Study Library | YounG',
                  color: Colors.lightBlue,
                  child: const StudyScreen(), // topic and fileName will be null
                ),
              ),
            ),
            GoRoute(
              path: '/study/:topicAndFile', 
              // 3 & 5. Clicking a Note displays the Markdown reader
              builder: (context, state) {
                final param = state.pathParameters['topicAndFile'] ?? '';
                final parts = param.split(':');
                
                final topic = parts[0]; 
                final fileName = parts.length > 1 ? parts[1] : 'intro';
                
                return StudyScreen(topic: topic, fileName: fileName);
              },
            ),
            GoRoute
            (
              path: '/projects',
              name: 'projects',
              //builder: (context, state) => const ProjectsScreen(),
              pageBuilder: (context, state) => NoTransitionPage
              (
                child: Title
                (
                  title: 'Projects | YounG',
                  color: Colors.lightBlue,
                  child: ProjectsScreen(),
                ),
              ),
            ),
            GoRoute
            (
              path: '/travel',
              name: 'travel',
              //builder: (context, state) => const AppsScreen(),
              pageBuilder: (context, state) => NoTransitionPage
              (
                child: Title
                (
                  title: 'Travel | YounG',
                  color: Colors.lightBlue,
                  child: TravelScreen(),
                ),
              ),
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => const NotFoundScreen(),
    );
  }
);

Widget _buildDrawer(BuildContext context, String currentLocation) 
{
  final menuItems = [
    ('Home', '/'),
    ('About', '/about'),
    ('Study', '/study'),
    ('Projects', '/projects'),
    ('Travel', '/travel'),
    ('Music', '/music'),
  ];

  return Drawer
  (
    child: ListView
    (
      padding: EdgeInsets.zero,
      children: 
      [
        const DrawerHeader
        (
          decoration: BoxDecoration(color: Colors.blueGrey),
          child: Text
          (
            'YounG',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        for (final item in menuItems)
          ListTile
          (
            title: Text(item.$1),
            selected: currentLocation == item.$2,
            onTap: () 
            {
              context.go(item.$2);
              Navigator.pop(context);
            },
          ),
      ],
    ),
  );
}