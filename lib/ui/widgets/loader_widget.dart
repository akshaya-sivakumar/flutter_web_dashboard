import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoaderWidget {
  void showLoader(BuildContext context,
      {String? text, bool stopLoader = false}) {
    stopLoader
        ? Navigator.pop(context)
        : showDialog(
            context: context,
            barrierDismissible: false,
            barrierColor: Colors.black.withOpacity(0.7),
            builder: (BuildContext context) {
              return WillPopScope(
                onWillPop: () async => false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitDoubleBounce(
                      color: Theme.of(context).primaryColor,
                      size: 50.0,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    /* Text(
                      text ?? "",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: const Size.fromHeight(19).height),
                    ) */
                  ],
                ),
              );
            },
          );
  }
}
