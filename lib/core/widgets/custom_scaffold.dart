import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;
  final Widget? bottomSheet;
  final Widget? bottomNavigationBar;

  CustomScaffold({
    super.key,
    required this.child,
    this.appBar,
    this.bottomSheet,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: child,
      bottomSheet: bottomSheet,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
