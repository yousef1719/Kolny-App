// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/constants/size_config.dart';
import 'package:hungry_app/core/network/api_error.dart';
import 'package:hungry_app/features/auth/data/auth_repo.dart';
import 'package:hungry_app/features/auth/data/user_model.dart';
import 'package:hungry_app/features/auth/views/login_view.dart';
import 'package:hungry_app/features/auth/widgets/custom_user_text_field.dart';
import 'package:hungry_app/shared/custom_snack_bar.dart';
import 'package:hungry_app/shared/custom_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});
  static const double bottomSheetHeightFactor = 0.120;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _visa = TextEditingController();

  UserModel? userModel;
  AuthRepo authRepo = AuthRepo();
  String? selectedImage;
  bool isLoadingUpdate = false;
  bool isLoadingLogout = false;

  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfileData();
      if (!mounted) return;
      setState(() {
        userModel = user;
      });
    } catch (e) {
      String errorMsg = 'Error in Profile';
      if (e is ApiError) {
        errorMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(errorMsg));
    }
  }

  Future<void> updateProfileData() async {
    try {
      setState(() => isLoadingUpdate = true);
      final user = await authRepo.updateProfileData(
        name: _name.text.trim(),
        email: _email.text.trim(),
        address: _address.text.trim(),
        visa: _visa.text.trim(),
        imagePath: selectedImage,
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnackBar('Profile Updated'));
      setState(() => isLoadingUpdate = false);
      setState(() => userModel = user);
      await getProfileData();
    } catch (e) {
      setState(() => isLoadingUpdate = false);
      String errorMsg = 'failed to update profile';
      if (e is ApiError) {
        errorMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(errorMsg));
    }
  }

  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage.path;
      });
    }
  }

  Future<void> removeImage() async {
    setState(() {
      selectedImage = null;
    });
  }

  Future<void> logout() async {
    try {
      setState(() => isLoadingLogout = true);
      await authRepo.logout();
      if (!mounted) return;
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
      );
      setState(() => isLoadingLogout = false);
    } catch (e) {
      setState(() => isLoadingLogout = false);
      print(e.toString());
    }
  }

  @override
  void initState() {
    getProfileData().then((e) {
      _name.text = userModel?.name.toString() ?? 'Youssef';
      _email.text = userModel?.email.toString() ?? 'youssef@gmail.com';
      _address.text = userModel?.address == null
          ? 'Gharbia, Egypt'
          : userModel!.address!;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.white,
      backgroundColor: AppColors.primary,
      onRefresh: () async {
        await getProfileData();
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.secondary,
            elevation: 0,
            scrolledUnderElevation: 0,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: paddingRight(context, 14)),
                child: Icon(Icons.settings, color: Colors.black),
              ),
            ],
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal(context, 16),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Skeletonizer(
                enabled: userModel == null,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: screenWidth(context) * 0.25,
                          height: screenWidth(context) * 0.25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1.5,
                              color: Colors.black54,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundColor: AppColors.secondary,
                            child: ClipOval(
                              child: selectedImage != null
                                  ? Image.file(
                                      File(selectedImage!),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    )
                                  : (userModel?.image != null &&
                                        userModel!.image!.isNotEmpty)
                                  ? Image.network(
                                      userModel!.image!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                      errorBuilder:
                                          (context, error, stackTrace) => Icon(
                                            Icons.person,
                                            size: 40,
                                            color: Colors.black,
                                          ),
                                    )
                                  : Icon(
                                      Icons.person,
                                      size: 40,
                                      color: Colors.black,
                                    ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: pickImage,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Gap(screenHeight(context) * 0.02),
                    // GestureDetector(
                    //   onTap: removeImage,
                    //   child: Card(
                    //     color: AppColors.primary,

                    //     child: Padding(
                    //       padding: EdgeInsets.symmetric(
                    //         horizontal: paddingHorizontal(context, 15),
                    //         vertical: paddingVertical(context, 15),
                    //       ),
                    //       child: Row(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           CustomText(
                    //             text: 'remove image',
                    //             weight: FontWeight.w500,
                    //             color: AppColors.secondary,
                    //             fontSize: 13,
                    //           ),
                    //           Gap(10),
                    //           Icon(
                    //             CupertinoIcons.trash,
                    //             size: 18,
                    //             color: AppColors.secondary,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Gap(screenHeight(context) * 0.03),
                    CustomUserTextField(
                      controller: _name,
                      label: 'Name',
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: Colors.black45,
                      ),
                    ),
                    Gap(screenHeight(context) * 0.025),
                    CustomUserTextField(
                      controller: _email,
                      label: 'Email',
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.black45,
                      ),
                    ),
                    Gap(screenHeight(context) * 0.025),
                    CustomUserTextField(
                      controller: _address,
                      label: 'Address',
                      prefixIcon: Icon(
                        Icons.location_on_outlined,
                        color: Colors.black45,
                      ),
                    ),
                    Gap(screenHeight(context) * 0.02),
                    Divider(),
                    Gap(screenHeight(context) * 0.02),
                    userModel?.visa == null
                        ? CustomUserTextField(
                            textInputType: TextInputType.number,
                            controller: _visa,
                            label: 'Add Visa',
                            prefixIcon: Icon(
                              Icons.credit_card,
                              color: Colors.black45,
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.grey.shade900,
                                  Colors.grey.shade800,
                                  Colors.grey.shade900,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icon/visa_profile.png',
                                  width: 45,
                                  color: Colors.white,
                                ),
                                Gap(screenWidth(context) * 0.035),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: 'Debit card',
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                    CustomText(
                                      text:
                                          userModel?.visa ??
                                          "**** **** **** 9857",
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: CustomText(
                                    text: 'Default',
                                    color: Colors.grey.shade800,
                                    fontSize: 14,
                                    weight: FontWeight.w500,
                                  ),
                                ),
                                Gap(screenWidth(context) * 0.02),
                                Icon(
                                  CupertinoIcons.check_mark_circled_solid,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                    Gap(screenHeight(context) * 0.03),
                    SizedBox(
                      height: screenHeight(context) * 0.075,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: updateProfileData,
                              child: Container(
                                height: screenHeight(context) * 0.075,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: AppColors.primary),

                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: isLoadingUpdate
                                    ? CupertinoActivityIndicator(
                                        color: AppColors.primary,
                                      )
                                    : Center(
                                        child: CustomText(
                                          text: 'Edit Profile',
                                          weight: FontWeight.w600,
                                          color: AppColors.primary,
                                          fontSize: 15,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          Gap(screenWidth(context) * 0.025),
                          Expanded(
                            child: GestureDetector(
                              onTap: logout,
                              child: Container(
                                height: screenHeight(context) * 0.075,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: isLoadingLogout
                                    ? CupertinoActivityIndicator(
                                        color: Colors.white,
                                      )
                                    : Center(
                                        child: CustomText(
                                          text: 'Logout',
                                          weight: FontWeight.w600,
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(screenWidth(context) * 0.3),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
