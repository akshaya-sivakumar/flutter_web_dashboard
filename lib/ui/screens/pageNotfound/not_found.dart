import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard_web/constants/app_constants.dart';
import 'package:flutter_dashboard_web/ui/widgets/text_widget.dart';
import 'package:google_fonts/google_fonts.dart';

@RoutePage(name: "notfound")
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Container(
          decoration: const BoxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                AppConstants.notfounstatement,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.abrilFatface().fontFamily),
              ),
              const SizedBox(
                width: 15,
              ),
              Image.asset(
                "lib/assets/icons/404page.png",
                fit: BoxFit.fill,
              )
            ],
          ),
        ),
      ),
    );
  }
}
