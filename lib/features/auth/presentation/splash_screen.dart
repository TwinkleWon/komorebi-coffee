import 'package:flutter/material.dart';

import 'brand_backdrop.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BrandBackdrop(child: Center(child: BrandLogo())),
    );
  }
}
