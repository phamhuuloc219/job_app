import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_app/controllers/login_provider.dart';
import 'package:job_app/controllers/zoom_provider.dart';
import 'package:job_app/models/request/auth/login_model.dart';
import 'package:job_app/views/common/app_bar.dart';
import 'package:job_app/views/common/custom_btn.dart';
import 'package:job_app/views/common/custom_textfield.dart';
import 'package:job_app/views/common/exports.dart';
import 'package:job_app/views/common/height_spacer.dart';
import 'package:job_app/views/common/pages_loader.dart';
import 'package:job_app/views/common/styled_container.dart';
import 'package:job_app/views/screens/auth/register_screen.dart';
import 'package:job_app/views/screens/main_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(
      builder: (context, loginNotifier, child) {
        loginNotifier.getPref();
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: CustomAppBar(
              text: 'Login',
              child: GestureDetector(
                onTap: () {
                  Get.offAll(()=> Mainscreen());
                },
                child: const Icon(AntDesign.leftcircleo,),
              ),
            ),
          ),
          body: loginNotifier.loader
          ? const PageLoader()
          : buildStyleContainer(
            context,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const HeightSpacer(size: 50),
                    ReusableText(
                        text: "Welcome",
                        style: appStyle(
                            30,
                            Color(kDark.value),
                            FontWeight.w600)
                    ),
                    ReusableText(
                        text: "Fill in the Details to login to your account",
                        style: appStyle(
                            12,
                            Color(kDarkGrey.value),
                            FontWeight.w400)
                    ),
                    const HeightSpacer(size: 40),
                    CustomTextField(
                      controller: email,
                      hintText: 'Enter your Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (email) {
                        if(email!.isEmpty || !email.contains('@')){
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const HeightSpacer(size: 40),
                    CustomTextField(
                      controller: password,
                      obscureText: loginNotifier.obscureText,
                      hintText: 'Enter your Password',
                      keyboardType: TextInputType.text,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          loginNotifier.obscureText = !loginNotifier.obscureText;
                        },
                        child: Icon(
                          loginNotifier.obscureText
                              ? Icons.visibility
                              : Icons.visibility_off
                        ),
                      ),
                      validator: (password) {
                        if(password!.isEmpty || password.length < 8){
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
                          text: 'Do not have an account? ',
                          style: appStyle(
                              12,
                              Color(kDarkGrey.value),
                              FontWeight.w400
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Get.offAll(()=> RegisterScreen());
                            },
                            child: ReusableText(
                                text: 'Register',
                                style: appStyle(
                                    12,
                                    Color(kLightBlue.value),
                                    FontWeight.w400
                                ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const HeightSpacer(size: 50),
                    Consumer<ZoomNotifier>(
                        builder: (context, zoomNotifier, child) {
                          return CustomButton(
                              text: 'Login',
                            onTap: () async{
                              loginNotifier.loader = true;

                                LoginModel model = LoginModel(
                                    email: email.text,
                                    password: password.text
                                );

                                String newModel = loginModelToJson(model);

                                loginNotifier.login(newModel, zoomNotifier);
                              await Future.delayed(Duration(seconds: 1));
                              loginNotifier.loader = false;
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
