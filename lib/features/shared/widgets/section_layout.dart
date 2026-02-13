import 'package:flutter/material.dart';

class SectionLayout extends StatelessWidget {
  final String title;
  final Widget child;
  final Color? backgroundColor;

  const SectionLayout({
    super.key, 
    required this.title, 
    required this.child, 
    this.backgroundColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: 10),
              const Divider(thickness: 2),
              const SizedBox(height: 40),
              child,
            ],
          ),
        ),
      ),
    );
  }
}