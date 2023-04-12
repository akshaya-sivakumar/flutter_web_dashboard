import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard_web/constants/app_images.dart';
import 'package:flutter_dashboard_web/constants/app_routes.dart';
import 'package:flutter_dashboard_web/main.dart';
import 'package:flutter_dashboard_web/utils/app_utils.dart';

class GoogleButton extends StatefulWidget {
  const GoogleButton({super.key});

  @override
  _GoogleButtonState createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: Theme.of(context).canvasColor, width: 1),
        ),
        color: Colors.white,
      ),
      child: GestureDetector(
        onTap: () async {
          setState(() {
            _isProcessing = true;
          });
          await AppUtils().signInWithGoogle().then((result) {
            if (result != null) {
              appRoute.pushNamed(AppRoutes.watchlistRoute);
            }
          }).catchError((error) {
            log('Registration Error: $error');
          });
          setState(() {
            _isProcessing = false;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: _isProcessing
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.blueGrey,
                  ),
                )
              : AppImages.googleLogo(),
        ),
      ),
    );
  }
}
