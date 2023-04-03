import 'package:flutter/material.dart';
import 'package:flutter_dashboard_web/ui/widgets/text_widget.dart';

class TextfieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  const TextfieldWidget({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          height: 40,
          width: 170,
          child: TextField(
            controller: controller,
            style: const TextStyle(fontSize: 16),
            obscureText: false,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                //labelText: "Mobile Number",
                hintText: "",
                filled: true,
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                hintStyle: TextStyle(
                    fontSize: 13, color: Theme.of(context).canvasColor),
                labelStyle: TextStyle(
                    fontSize: 14, color: Theme.of(context).canvasColor),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).canvasColor)),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).canvasColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).canvasColor))),
          ),
        ),
      ],
    );
  }
}
