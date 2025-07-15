import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget child;
  PreferredSizeWidget? appBar;
  BottomSheet? bottomSheet;
  BottomNavigationBar? bottomNavigationBar;

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
