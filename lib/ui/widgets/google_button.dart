import 'package:flutter/material.dart';
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
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.blueGrey, width: 3),
        ),
        color: Colors.white,
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.blueGrey.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Colors.blueGrey, width: 3),
          ),
          elevation: 0,
        ),
        onPressed: () async {
          setState(() {
            _isProcessing = true;
          });
          await AppUtils().signInWithGoogle().then((result) {
            print(result);
            if (result != null) {
              appRoute.pushNamed(AppRoutes.watchlistRoute);
            }
          }).catchError((error) {
            print('Registration Error: $error');
          });
          setState(() {
            _isProcessing = false;
          });
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: _isProcessing
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.blueGrey,
                  ),
                )
              : const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.login),
                    /*   Image(
                      image: AssetImage("assets/images/google_logo.png"),
                      height: 30.0,
                    ), */
                  ],
                ),
        ),
      ),
    );
  }
}
