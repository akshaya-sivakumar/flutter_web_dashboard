import 'package:flutter/material.dart';

var showPassword = true;
TextField searchBox(controller, label, hint, function) {
  return TextField(
    textAlign: TextAlign.start,
    onChanged: (v) {
      function();
    },
    controller: controller,
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
      isDense: true,
      suffixIcon: InkWell(
          onTap: () {
            if (controller.text.toString().isNotEmpty) {
              controller.text = "";
            }
            function();
          },
          child: controller.text == ""
              ? const Icon(
                  Icons.search,
                  color: Colors.grey,
                )
              : const Icon(
                  Icons.cancel,
                  // color: AppColors.themeColor,
                )),
      label: Text(label),
      hintText: hint == "" ? 'Enter here' : hint,
      hintStyle: const TextStyle(fontSize: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.solid,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
    ),
  );
}
