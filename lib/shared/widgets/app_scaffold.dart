import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final Widget? bottomNav;
  final bool showBack;
  final Color? backgroundColor;
  final PreferredSizeWidget? bottom;

  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.bottomNav,
    this.showBack = false,
    this.backgroundColor,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: title != null || showBack
          ? AppBar(
              title: title != null ? Text(title!) : null,
              actions: actions,
              bottom: bottom,
            )
          : null,
      body: SafeArea(child: body),
      bottomNavigationBar: bottomNav,
    );
  }
}
