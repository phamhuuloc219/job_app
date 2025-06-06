import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/controllers/signup_provider.dart';
import 'package:job_app/controllers/zoom_provider.dart';
import 'package:job_app/models/request/auth/signup_model.dart';
import 'package:job_app/views/common/app_bar.dart';
import 'package:job_app/views/common/app_style.dart';
import 'package:job_app/views/common/custom_btn.dart';
import 'package:job_app/views/common/custom_textfield.dart';
import 'package:job_app/views/common/height_spacer.dart';
import 'package:job_app/views/common/pages_loader.dart';
import 'package:job_app/views/common/reusable_text.dart';
import 'package:job_app/views/common/styled_container.dart';
import 'package:job_app/views/screens/auth/login_screen.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    username.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpNotifier>(
      builder: (context, signupNotifier, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: CustomAppBar(
              text: 'Sign Up',
              child: GestureDetector(
                onTap: () {
                  Get.offAll(() => LoginScreen());
                },
                child: const Icon(
                  AntDesign.leftcircleo,
                  size: 30,
                ),
              ),
            ),
          ),
          body: signupNotifier.loader
              ? const PageLoader()
              : buildStyleContainer(
                  context,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Form(
                      key: signupNotifier.signupFormKey,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          const HeightSpacer(size: 50),
                          ReusableText(
                              text: "Welcome",
                              style: appStyle(
                                  30, Color(kDark.value), FontWeight.w600)),
                          ReusableText(
                              text:
                                  "Fill in the Details to sign up for an new account",
                              style: appStyle(
                                  12, Color(kDarkGrey.value), FontWeight.w400)),
                          const HeightSpacer(size: 30),
                          CustomTextField(
                            controller: username,
                            hintText: 'Enter your full name',
                            keyboardType: TextInputType.text,
                            validator: (username) {
                              if (username!.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          const HeightSpacer(size: 20),
                          CustomTextField(
                            controller: email,
                            hintText: 'Enter your Email',
                            keyboardType: TextInputType.emailAddress,
                            validator: (email) {
                              if (email!.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!email.contains('@')) {
                                return 'Email is not in correct format. \n eg: example@gmail.com';
                              }
                              return null;
                            },
                          ),
                          const HeightSpacer(size: 20),
                          CustomTextField(
                            controller: password,
                            obscureText: signupNotifier.obscureText,
                            hintText: 'Enter your Password',
                            keyboardType: TextInputType.text,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                signupNotifier.obscureText =
                                    !signupNotifier.obscureText;
                              },
                              child: Icon(signupNotifier.obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            validator: (password) {
                              if (password!.isEmpty || password.length < 8) {
                                return 'Please enter valid password';
                              }
                              return null;
                            },
                          ),
                          const HeightSpacer(size: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ReusableText(
                                text: 'Already have an account? ',
                                style: appStyle(12, Color(kDarkGrey.value),
                                    FontWeight.w400),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.offAll(() => LoginScreen());
                                  },
                                  child: ReusableText(
                                    text: 'Login',
                                    style: appStyle(12, Color(kLightBlue.value),
                                        FontWeight.w400),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const HeightSpacer(size: 50),
                          Consumer<ZoomNotifier>(
                            builder: (context, zoomNotifier, child) {
                              return CustomButton(
                                text: 'Sign Up',
                                onTap: () {
                                  if (signupNotifier.signupFormKey.currentState!
                                      .validate()) {
                                    signupNotifier.loader = true;

                                    SignupModel model = SignupModel(
                                        username: username.text,
                                        email: email.text,
                                        password: password.text);

                                    String newModel = signupModelToJson(model);

                                    signupNotifier.signUp(newModel);
                                  }
                                },
                              );
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
