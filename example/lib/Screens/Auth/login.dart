import 'package:incento_demo/Const/colors.dart';
import 'package:incento_demo/Controller/authController.dart';
import 'package:incento_demo/Utils/helper.dart';
import 'package:incento_demo/Utils/utils.dart';
import 'package:incento_demo/Utils/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return themeWrapper(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/images/login-ill.svg',
                height: 350,
                width: double.infinity,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Login",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: email,
                decoration: UiUtils.inputDecoration(
                    context, "Email ID", FeatherIcons.atSign),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: password,
                obscureText: true,
                autocorrect: false,
                enableSuggestions: false,
                decoration: UiUtils.inputDecoration(
                    context, "Password", FeatherIcons.lock),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    primary: Colors.white,
                    backgroundColor: accentColor,
                    onSurface: Colors.grey,
                  ),
                  onPressed: () {
                    if (!validateEmail(email.text)) {
                      showSnackbar("Error!", "Please enter a valid email !");
                    } else if (password.text.isEmpty) {
                      showSnackbar("Error", " Password cannot be empty!");
                    } else {
                      controller.login(email.text, password.text);
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
