import 'package:final_dreams/features/home/presentation/logo_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class TopMenu extends StatelessWidget implements PreferredSizeWidget {
  final String currentLocation;

  const TopMenu({
    super.key,
    required this.currentLocation,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;

        return AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          // Subtle bottom border
          shape: const Border(
            bottom: BorderSide(
              color: Colors.black12,
              width: 1,
            ),
          ),
          title: LogoAndName(
            name: 'YounG',
            icon: Icons.person,
            onTap: () => context.go('/'),
          ),
          actions: isWide ? _buildDesktopActions(context) : null,
        );
      },
    );
  }

  List<Widget> _buildDesktopActions(BuildContext context) {
    final menuItems = [
      ('Home', '/'),
      ('About', '/about'),
      ('Music', '/music'),
      ('Study', '/study'),
      ('Projects', '/projects'),
      ('Apps', '/apps'),
    ];

    return [
      for (final item in menuItems)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: _buildNavButton(
            context,
            label: item.$1,
            route: item.$2,
            isActive: currentLocation == item.$2,
          ),
        ),
    ];
  }

  Widget _buildNavButton(
    BuildContext context, {
    required String label,
    required String route,
    required bool isActive,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          border: isActive
              ? const Border(
                  bottom: BorderSide(
                    color: Color(0xFF2C6E6E), // accent color
                    width: 3,
                  ),
                )
              : null,
        ),
        child: TextButton(
          onPressed: () => context.go(route),
          style: TextButton.styleFrom(
            foregroundColor: isActive
                ? const Color(0xFF2C6E6E)
                : Colors.black54,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          child: Text(label),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}