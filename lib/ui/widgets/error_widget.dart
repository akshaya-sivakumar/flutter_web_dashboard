import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../constants/appwidget_size.dart';
import 'text_widget.dart';

class ErrorsWidget extends StatelessWidget {
  const ErrorsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.3 - AppWidgetSize.dimen_80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              size: AppWidgetSize.dimen_60,
              color: Theme.of(context).snackBarTheme.actionTextColor,
            ),
            const TextWidget(AppConstants.unknownError)
          ],
        ));
  }
}
