import 'package:flutter/material.dart';

class LogoAndName extends StatelessWidget {
  final String name;
  final IconData? icon;
  final String? imagePath;
  final VoidCallback? onTap;

  const LogoAndName({
    super.key,
    required this.name,
    this.icon,
    this.imagePath,
    this.onTap,
  }) : assert(icon != null || imagePath != null,
            'Either icon or imagePath must be provided');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.max, // ← changed from min to max
        children: [
          // Logo (icon or image)
          if (imagePath != null)
            CircleAvatar(
              radius: 18, // slightly smaller (was 20)
              backgroundImage: AssetImage(imagePath!),
            )
          else if (icon != null)
            Icon(
              icon,
              size: 24, // reduced from 32
              color: Theme.of(context).primaryColor,
            ),
          const SizedBox(width: 8), // reduced from 10
          // Name – now flexible and can truncate if needed
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 20, // reduced from 24
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}