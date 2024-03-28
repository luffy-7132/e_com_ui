import 'dart:convert';
import 'package:e_com_ui/custom/custom_widget.dart';
import 'package:e_com_ui/models/user_model.dart';
import 'package:e_com_ui/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "SignUp",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            custom_textfield(Icons.person, firstNameController, 'First name'),
            custom_textfield(Icons.person, lastNameController, 'last name'),
            custom_textfield(Icons.mail, emailController, 'E-mail Here !!'),
            custom_textfield(
                Icons.mobile_friendly_rounded, phoneController, 'Phone Here!!'),
            custom_textfield(Icons.remove_red_eye_outlined, passwordController,
                'Password Here!!'),
            custom_button(() {
              postData();
            }, 'Sign Up')
          ],
        ),
      ),
    );
  }

  Future<void> postData() async {
    String url = "https://www.infusevalue.live/api/v1/auth/register";
    UserModel userModel = UserModel(
        email: emailController.text.toString(),
        phone: phoneController.text.toString(),
        lastName: lastNameController.text.toString(),
        firstName: firstNameController.text.toString(),
        password: passwordController.text.toString());

    final response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userModel.toJson()));

    if (response.statusCode == 200) {
      print('Data Send Success');
      print(response.body);
      custom_snakeBar(
          context, 'Success', 'User Successfully Created', ContentType.success);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LogInScreen(),
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
