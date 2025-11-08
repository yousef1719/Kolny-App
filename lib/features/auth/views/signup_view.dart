// ignore_for_file: avoid_print, deprecated_member_use, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/constants/size_config.dart';
import 'package:hungry_app/core/network/api_error.dart';
import 'package:hungry_app/features/auth/data/auth_repo.dart';
import 'package:hungry_app/features/auth/views/login_view.dart';
import 'package:hungry_app/features/auth/widgets/custom_auth_button.dart';
import 'package:hungry_app/root.dart';
import 'package:hungry_app/shared/custom_snack_bar.dart';
import 'package:hungry_app/shared/custom_text.dart';
import 'package:hungry_app/shared/custom_text_form_field.dart';
import 'package:hungry_app/shared/liquid_container.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  AuthRepo authRepo = AuthRepo();

  Future<void> signup() async {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        final user = await authRepo.signup(
          nameController.text.trim(),
          emailController.text.trim(),
          passController.text.trim(),
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
        String errorMsg = 'Error in Register';
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
                      SvgPicture.asset(
                        'assets/logo/logo.svg',
                        color: AppColors.primary,
                      ),
                      Gap(screenHeight(context) * 0.01),
                      CustomText(
                        text: 'Welcome to our Food App',
                        color: AppColors.primary,
                        fontSize: 13,
                        weight: FontWeight.w400,
                      ),
                      Gap(screenHeight(context) * 0.09),
                      glassContainer(
                        child: Column(
                          children: [
                            Gap(screenHeight(context) * 0.03),
                            CustomTextFormField(
                              controller: nameController,
                              hintText: 'Name',
                              isPassword: false,
                            ),
                            Gap(screenHeight(context) * 0.015),
                            CustomTextFormField(
                              controller: emailController,
                              hintText: 'Email Address',
                              isPassword: false,
                            ),
                            Gap(screenHeight(context) * 0.015),
                            CustomTextFormField(
                              controller: passController,
                              hintText: 'Password',
                              isPassword: true,
                            ),

                            Gap(screenHeight(context) * 0.03),
                            isLoading
                                ? const CupertinoActivityIndicator(
                                    color: Colors.white,
                                  )
                                : CustomAuthButton(
                                    color: AppColors.primary,
                                    textColor: Colors.white,
                                    onTap: signup,
                                    text: 'Sign up',
                                  ),
                            Gap(screenHeight(context) * 0.02),

                            Row(
                              children: [
                                Expanded(
                                  child: CustomAuthButton(
                                    text: 'Login',
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginView(),
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
