import 'package:flutter/material.dart';

class NTVHomePage extends StatefulWidget {
  const NTVHomePage({super.key});

  static const String routePath = '/ntv_home';

  @override
  State<NTVHomePage> createState() => _NTVHomePageState();
}

class _NTVHomePageState extends State<NTVHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Placeholder(),
    );
  }
}
