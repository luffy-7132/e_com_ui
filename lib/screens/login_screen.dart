import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import '../custom/custom_widget.dart';
import 'package:http/http.dart' as http;

import 'home_screen.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "LogIN",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            custom_textfield(Icons.mail, emailController, 'E-mail Here !!'),
            custom_textfield(Icons.remove_red_eye_outlined, passwordController,
                'Password Here!!'),
            custom_textfield(Icons.remove_red_eye_outlined,
                confirmPassController, 'Confirm Password Here!!'),
            custom_button(() {
              LoginUser(context);
            }, 'LogIN')
          ],
        ),
      ),
    );
  }

  Future<void> LoginUser(BuildContext context) async {
    String url = "https://www.infusevalue.live/api/v1/auth/login";
    final response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": emailController.text.toString(),
          "password": passwordController.text.toString()
        }));

    if (response.statusCode == 200) {
      print('Data Send Success');
      print(response.body);
      custom_snakeBar(context, 'Success', 'User Successfully LoggedIn',
          ContentType.success);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } else {
      print('Data not send');
      print(response.statusCode);
      custom_snakeBar(context, response.statusCode.toString(), response.body,
          ContentType.failure);
    }
  }
}
