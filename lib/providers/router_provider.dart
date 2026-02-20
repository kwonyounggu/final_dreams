import 'package:final_dreams/core/errors/not_found_screen.dart';
import 'package:final_dreams/features/about/about_screen.dart';
import 'package:final_dreams/features/apps/apps_screen.dart';
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

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            appBar: TopMenu(
              currentLocation: state.matchedLocation,
            ),
            drawer: _buildDrawer(context, state.matchedLocation),
            body: child,
          );
        },
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/about',
            name: 'about',
            builder: (context, state) => const AboutScreen(),
          ),
          GoRoute(
            path: '/music',
            name: 'music',
            builder: (context, state) => const MusicScreen(),
          ),
          GoRoute(
            path: '/study',
            name: 'study',
            //builder: (context, state) => const StudyScreen(),
            pageBuilder: (context, state) => NoTransitionPage(
              child: Title(
                title: 'Study & Research | YounG',
                color: Colors.lightBlue,
                child: StudyScreen(),
              ),
            ),
          ),
          GoRoute(
            path: '/projects',
            name: 'projects',
            builder: (context, state) => const ProjectsScreen(),
          ),
          GoRoute(
            path: '/apps',
            name: 'apps',
            builder: (context, state) => const AppsScreen(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});

Widget _buildDrawer(BuildContext context, String currentLocation) {
  final menuItems = [
    ('Home', '/'),
    ('About', '/about'),
    ('Music', '/music'),
    ('Study', '/study'),
    ('Projects', '/projects'),
    ('Apps', '/apps'),
  ];

  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(color: Colors.blueGrey),
          child: Text(
            'YounG',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        for (final item in menuItems)
          ListTile(
            title: Text(item.$1),
            selected: currentLocation == item.$2,
            onTap: () {
              context.go(item.$2);
              Navigator.pop(context);
            },
          ),
      ],
    ),
  );
}