import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/app_images.dart';
import '../../../../constants/appwidget_size.dart';
import '../../../widgets/text_widget.dart';
import '../widgets/navigator_rail.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  @override
  Widget build(BuildContext context) {
    return NavigatorRailwidget(
        selectedindex: 2,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                AppConstants.portfolio,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize:AppWidgetSize.dimen_17),
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
