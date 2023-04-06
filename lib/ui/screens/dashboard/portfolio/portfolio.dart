import 'package:flutter/material.dart';

import '../widgets/navigator_rail.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  @override
  Widget build(BuildContext context) {
    return const NavigatorRailwidget(
        selectedindex: 2, child: Center(child: Text("Portfolio")));
  }
}
