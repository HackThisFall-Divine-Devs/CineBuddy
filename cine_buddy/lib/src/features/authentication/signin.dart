import 'package:cine_buddy/src/common_widgets/alerts.dart';
import 'package:cine_buddy/src/common_widgets/loading_incicator.dart';
import 'package:cine_buddy/src/common_widgets/social_button.dart';
import 'package:cine_buddy/src/common_widgets/theme_button.dart';
import 'package:cine_buddy/src/common_widgets/theme_textfield.dart';
import 'package:cine_buddy/src/features/authentication/bloc/authentication_bloc.dart';
import 'package:cine_buddy/src/features/authentication/signup.dart';
import 'package:cine_buddy/src/features/home_outline/home_outline.dart';
import 'package:cine_buddy/src/utils/colors_sys.dart';
import 'package:cine_buddy/src/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0.0,
      ),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showAlert(context, state.error, "", "error");
          }
          if (state is AuthSuccess) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeOutLine()));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const LoadingIndicator();
          }
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      Strings.signinText,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 28.0),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      Strings.signinTextDescription,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: ColorSys.kwhite.withOpacity(0.5)),
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
                    Text(
                      Strings.forgotPasswordText,
                      textAlign: TextAlign.right,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: ColorSys.ksecondary),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    ThemeButton(
                      name: Strings.signinButtonText,
                      onPressed: signInWithEmailAndPassword,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    SocialButton(
                      name: Strings.loginWithGoogle,
                      color: ColorSys.kprimary,
                      logo: "assets/icons/google.svg",
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    // Expanded(
                    //   child:
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Strings.dontHaveAccountText,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: ColorSys.kwhite.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUp(),
                                ),
                              );
                            },
                            child: Text(
                              Strings.createAccountText,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: ColorSys.ksecondary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void signInWithEmailAndPassword() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      context.read<AuthenticationBloc>().add(AuthLoginRequested(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          ));
      return;
    }
    showAlert(context, "Email and Password can't be empty!", "", "info");
  }
}
