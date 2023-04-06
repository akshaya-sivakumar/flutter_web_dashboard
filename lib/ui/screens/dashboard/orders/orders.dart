import 'package:flutter/material.dart';

import '../widgets/navigator_rail.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return const NavigatorRailwidget(
        selectedindex: 1, child: Center(child: Text("orderscreen")));
  }
}
