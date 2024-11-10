import 'package:cine_buddy/src/common_widgets/alerts.dart';
import 'package:cine_buddy/src/common_widgets/loading_incicator.dart';
import 'package:cine_buddy/src/common_widgets/theme_button.dart';
import 'package:cine_buddy/src/common_widgets/theme_textfield.dart';
import 'package:cine_buddy/src/features/authentication/bloc/authentication_bloc.dart';
import 'package:cine_buddy/src/features/authentication/preferences.dart';
import 'package:cine_buddy/src/features/home_outline/home_outline.dart';
import 'package:cine_buddy/src/utils/colors_sys.dart';
import 'package:cine_buddy/src/utils/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: ColorSys.kwhite,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                Strings.registerText,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 28.0),
              ),
              const SizedBox(
                height: 60.0,
              ),
              ThemeTextField(
                fieldName: Strings.usernamePlaceholder,
                controllerName: _usernameController,
              ),
              const SizedBox(
                height: 30.0,
              ),
              ThemeTextField(
                fieldName: Strings.emailPlaceholder,
                controllerName: _emailController,
              ),
              const SizedBox(
                height: 30.0,
              ),
              ThemeTextField(
                fieldName: Strings.passwordPlaceholder,
                controllerName: _passwordController,
                passwordField: true,
              ),
              const SizedBox(
                height: 30.0,
              ),
              ThemeButton(
                name: Strings.registerButtonText,
                onPressed: () async => await signUpWithEmailAndPassword(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signUpWithEmailAndPassword() async {
    if (_usernameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Preferences(
                    username: _usernameController.text.trim(),
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                  )));
      return;
    }
    showAlert(
        context, "Username, Email and Password can't be empty!", "", "info");
  }
}
