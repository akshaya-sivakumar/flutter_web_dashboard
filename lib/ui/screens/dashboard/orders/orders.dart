import 'package:flutter/material.dart';
import 'package:flutter_dashboard_web/constants/app_constants.dart';
import 'package:flutter_dashboard_web/constants/app_images.dart';
import 'package:flutter_dashboard_web/constants/appwidget_size.dart';
import 'package:flutter_dashboard_web/ui/widgets/text_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/navigator_rail.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return NavigatorRailwidget(
        selectedindex: 1,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                AppConstants.orders,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: AppWidgetSize.dimen_17),
              ),
              AppImages.inProgress(),
              TextWidget(
                AppConstants.notDeveloped,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontFamily: GoogleFonts.architectsDaughter().fontFamily,
                    fontSize: AppWidgetSize.dimen_20),
              ),
            ],
          ),
        ));
  }
}
