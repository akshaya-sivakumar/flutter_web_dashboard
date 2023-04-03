import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard_web/ui/widgets/text_widget.dart';

import '../widgets/material_switch.dart';

class PopupWindow extends StatelessWidget {
  const PopupWindow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 41),
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).dividerColor.withOpacity(0.3),
        child: Scaffold(
            backgroundColor: Theme.of(context).dividerColor,
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {}, child: const Icon(Icons.close)),
                    const TextWidget("STATE BANK OF INDIA"),
                  ],
                ),
                DottedLine(
                  dashColor: Theme.of(context).dividerColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const TextWidget("SBI"),
                        Row(
                          children: const [
                            TextWidget(
                              "189.00",
                            ),
                            TextWidget(
                              "+3.00(+1.80)",
                            ),
                          ],
                        )
                      ],
                    ),
                    MaterialSwitch(
                      inactiveTrackColor: Theme.of(context).primaryColorLight,
                      activeColor: Colors.white,
                      value: false,
                      onChanged: (value) {},
                    )
                  ],
                )
              ],
            )));
  }
}
