// ignore_for_file: avoid_print, deprecated_member_use, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/constants/size_config.dart';
import 'package:hungry_app/core/network/api_error.dart';
import 'package:hungry_app/features/auth/data/auth_repo.dart';
import 'package:hungry_app/features/auth/views/signup_view.dart';
import 'package:hungry_app/features/auth/widgets/custom_auth_button.dart';
import 'package:hungry_app/root.dart';
import 'package:hungry_app/shared/custom_snack_bar.dart';
import 'package:hungry_app/shared/custom_text.dart';
import 'package:hungry_app/shared/custom_text_form_field.dart';
import 'package:hungry_app/shared/liquid_container.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  AuthRepo authRepo = AuthRepo();

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        final user = await authRepo.login(
          emailController.text.trim(),
          passwordController.text.trim(),
        );
        if (user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Root()),
          );
        }
        setState(() => isLoading = false);
      } catch (e) {
        setState(() => isLoading = false);
        String errorMsg = 'unhandeled error';
        if (e is ApiError) {
          errorMsg = e.message;
        }
        ScaffoldMessenger.of(context).showSnackBar(customSnackBar(errorMsg));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Scaffold(
            body: Center(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Gap(screenHeight(context) * 0.08),
                      Center(
                        child: SvgPicture.asset(
                          'assets/logo/logo.svg',
                          color: AppColors.primary,
                        ),
                      ),
                      Gap(screenHeight(context) * 0.015),
                      Center(
                        child: CustomText(
                          text: 'Welcome Back Discover Great Food',
                          color: AppColors.primary,
                          fontSize: 13,
                          weight: FontWeight.w400,
                        ),
                      ),

                      Gap(screenHeight(context) * 0.09),
                      glassContainer(
                        child: Column(
                          children: [
                            Gap(screenHeight(context) * 0.03),
                            CustomTextFormField(
                              controller: emailController,
                              hintText: 'Email Address',
                              isPassword: false,
                            ),
                            Gap(screenHeight(context) * 0.015),
                            CustomTextFormField(
                              controller: passwordController,
                              hintText: 'Password',
                              isPassword: true,
                            ),
                            Gap(screenHeight(context) * 0.03),

                            isLoading
                                ? CupertinoActivityIndicator(
                                    color: Colors.white,
                                  )
                                : CustomAuthButton(
                                    text: 'Login',
                                    color: AppColors.primary,
                                    textColor: Colors.white,
                                    onTap: login,
                                  ),

                            Gap(screenHeight(context) * 0.02),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomAuthButton(
                                    text: 'Sign up',
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SignupView(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Gap(screenWidth(context) * 0.05),
                                Expanded(
                                  child: CustomAuthButton(
                                    text: 'Guest',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Root(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Gap(screenHeight(context) * 0.05),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
