import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/controllers/change_password_provider.dart';
import 'package:job_app/views/common/app_bar.dart';
import 'package:job_app/views/common/custom_btn.dart';
import 'package:job_app/views/common/custom_textfield.dart';
import 'package:job_app/views/common/drawer/drawer_widget.dart';
import 'package:job_app/views/common/height_spacer.dart';
import 'package:job_app/views/common/pages_loader.dart';
import 'package:job_app/views/common/styled_container.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key, required this.drawer});

  final bool drawer;

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController password = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  @override
  void dispose() {
    password.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChangePasswordNotifier>(
      builder: (context, notifier, child) {
        return Scaffold(
          backgroundColor: Color(kNewBlue.value),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.h),
            child: CustomAppBar(
                color: Color(kNewBlue.value),
                text: 'Change Password',
                child: Padding(
                  padding: EdgeInsets.all(12.0.h),
                  child: widget.drawer == false
                      ? GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            AntDesign.leftcircleo,
                            color: Color(0xFFFFFFFF),
                            size: 30,
                          ),
                        )
                      : DrawerWidget(color: Color(kLight.value)),
                )),
          ),
          body: notifier.loader
              ? const PageLoader()
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: Color(kLight.value),
                    borderRadius: BorderRadius.all(Radius.circular(12.w)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Form(
                      key: notifier.changePasswordFormKey,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          const HeightSpacer(size: 50),
                          CustomTextField(
                            controller: password,
                            obscureText: notifier.obscureText,
                            hintText: 'Enter your Password',
                            keyboardType: TextInputType.text,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                notifier.obscureText = !notifier.obscureText;
                              },
                              child: Icon(
                                notifier.obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            validator: (val) {
                              if (val == null ||
                                  val.isEmpty ||
                                  val.length < 8) {
                                return 'Please enter valid password';
                              }
                              return null;
                            },
                          ),
                          const HeightSpacer(size: 20),
                          CustomTextField(
                            controller: newPassword,
                            obscureText: notifier.obscureTextNewPassword,
                            hintText: 'Enter your new password',
                            keyboardType: TextInputType.text,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                notifier.obscureTextNewPassword =
                                    !notifier.obscureTextNewPassword;
                              },
                              child: Icon(
                                notifier.obscureTextNewPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            validator: (val) {
                              if (val == null ||
                                  val.isEmpty ||
                                  val.length < 8) {
                                return 'Please enter valid new password';
                              }
                              return null;
                            },
                          ),
                          const HeightSpacer(size: 20),
                          CustomTextField(
                            controller: confirmPassword,
                            obscureText: notifier.obscureTextConfirmNewPassword,
                            hintText: 'Confirm your new password',
                            keyboardType: TextInputType.text,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                notifier.obscureTextConfirmNewPassword =
                                    !notifier.obscureTextConfirmNewPassword;
                              },
                              child: Icon(
                                notifier.obscureTextConfirmNewPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            validator: (val) {
                              if (val == null ||
                                  val.isEmpty ||
                                  val.length < 8) {
                                return 'Please enter valid confirm password';
                              }
                              if (val != newPassword.text) {
                                return 'Confirm password does not match new password';
                              }
                              return null;
                            },
                          ),
                          const HeightSpacer(size: 50),
                          CustomButton(
                            text: 'Change Password',
                            onTap: () async {
                              if (notifier.changePasswordFormKey.currentState!
                                  .validate()) {
                                notifier.oldPassword = password.text.trim();
                                notifier.newPassword = newPassword.text.trim();

                                await notifier.changePassword();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
