import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

Padding custom_textfield(
    IconData iconData, TextEditingController controller, String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(11)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(11)),
        hintText: text,
        prefixIcon: Icon(iconData),
      ),
    ),
  );
}

Padding custom_button(void Function()? onpressed, String text) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: OutlinedButton(
        onPressed: onpressed,
        child: Text(text),
        style: OutlinedButton.styleFrom(
            backgroundColor: Colors.grey.shade200, minimumSize: Size(400, 50))),
  );
}

custom_snakeBar(
    BuildContext context, String title, message, ContentType contentType) {
  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: contentType,
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
