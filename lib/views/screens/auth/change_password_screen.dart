// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:get/get.dart';
// import 'package:job_app/controllers/change_password_provider.dart';
// import 'package:job_app/views/common/app_bar.dart';
// import 'package:job_app/views/common/custom_textfield.dart';
// import 'package:job_app/views/common/height_spacer.dart';
// import 'package:job_app/views/common/pages_loader.dart';
// import 'package:job_app/views/common/styled_container.dart';
// import 'package:job_app/views/screens/auth/profile_screen.dart';
// import 'package:provider/provider.dart';
//
// class ChangePasswordScreen extends StatefulWidget {
//   const ChangePasswordScreen({super.key});
//
//   @override
//   State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
// }
//
// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   TextEditingController password = TextEditingController();
//   TextEditingController newPassword = TextEditingController();
//   TextEditingController confirmPassword = TextEditingController();
//
//
//   @override
//   void dispose() {
//     password.dispose();
//     newPassword.dispose();
//     confirmPassword.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ChangePasswordNotifier>(
//       builder: (context, signupNotifier, child) {
//         return Scaffold(
//           appBar: PreferredSize(
//             preferredSize: Size.fromHeight(50),
//             child: CustomAppBar(
//               text: 'Change Password',
//               child: GestureDetector(
//                 onTap: () {
//                   Get.back();
//                 },
//                 child: const Icon(AntDesign.leftcircleo,),
//               ),
//             ),
//           ),
//           body: signupNotifier.loader
//               ? const PageLoader()
//               : buildStyleContainer(
//             context,
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.w),
//               child: Form(
//                 child: ListView(
//                   padding: EdgeInsets.zero,
//                   children: [
//                     const HeightSpacer(size: 50),
//
//                     CustomTextField(
//                       controller: password,
//                       obscureText: signupNotifier.obscureText,
//                       hintText: 'Enter your Password',
//                       keyboardType: TextInputType.text,
//                       suffixIcon: GestureDetector(
//                         onTap: () {
//                           signupNotifier.obscureText = !signupNotifier.obscureText;
//                         },
//                         child: Icon(
//                             signupNotifier.obscureText
//                                 ? Icons.visibility
//                                 : Icons.visibility_off
//                         ),
//                       ),
//                       validator: (password) {
//                         if(password!.isEmpty || password.length < 8){
//                           return 'Please enter valid password';
//                         }
//                         return null;
//                       },
//                     ),
//                     const HeightSpacer(size: 20),
//                     CustomTextField(
//                       controller: newPassword,
//                       obscureText: signupNotifier.obscureText,
//                       hintText: 'Enter your new password',
//                       keyboardType: TextInputType.text,
//                       suffixIcon: GestureDetector(
//                         onTap: () {
//                           signupNotifier.obscureText = !signupNotifier.obscureText;
//                         },
//                         child: Icon(
//                             signupNotifier.obscureText
//                                 ? Icons.visibility
//                                 : Icons.visibility_off
//                         ),
//                       ),
//                       validator: (password) {
//                         if(password!.isEmpty || password.length < 8){
//                           return 'Please enter valid new password';
//                         }
//                         return null;
//                       },
//                     ),
//                     const HeightSpacer(size: 20),
//                     CustomTextField(
//                       controller: confirmPassword,
//                       obscureText: signupNotifier.obscureText,
//                       hintText: 'Enter your confirm password',
//                       keyboardType: TextInputType.text,
//                       suffixIcon: GestureDetector(
//                         onTap: () {
//                           signupNotifier.obscureText = !signupNotifier.obscureText;
//                         },
//                         child: Icon(
//                             signupNotifier.obscureText
//                                 ? Icons.visibility
//                                 : Icons.visibility_off
//                         ),
//                       ),
//                       validator: (password) {
//                         if(password!.isEmpty || password.length < 8){
//                           return 'Please enter valid confirm password';
//                         }
//                         return null;
//                       },
//                     ),
//                     const HeightSpacer(size: 10),
//                     const HeightSpacer(size: 50),
//                     // Consumer<ZoomNotifier>(
//                     //   builder: (context, zoomNotifier, child) {
//                     //     return CustomButton(
//                     //       text: 'Change Password',
//                     //       onTap: () {
//                     //         signupNotifier.loader = true;
//                     //
//                     //         SignupModel model = SignupModel(
//                     //             password: password.text,
//                     //             password: newPassword.text,
//                     //             password: confirmPassword.text
//                     //         );
//                     //
//                     //         String newModel = signupModelToJson(model);
//                     //
//                     //         signupNotifier.signUp(newModel);
//                     //       },
//                     //     );
//                     //   },
//                     // ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_app/controllers/change_password_provider.dart';
import 'package:job_app/views/common/app_bar.dart';
import 'package:job_app/views/common/custom_btn.dart';
import 'package:job_app/views/common/custom_textfield.dart';
import 'package:job_app/views/common/height_spacer.dart';
import 'package:job_app/views/common/pages_loader.dart';
import 'package:job_app/views/common/styled_container.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

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
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: CustomAppBar(
              text: 'Change Password',
              child: GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(AntDesign.leftcircleo),
              ),
            ),
          ),
          body: notifier.loader
              ? const PageLoader()
              : buildStyleContainer(
            context,
            Padding(
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
                        if (val == null || val.isEmpty || val.length < 8) {
                          return 'Please enter valid password';
                        }
                        return null;
                      },
                    ),
                    const HeightSpacer(size: 20),
                    CustomTextField(
                      controller: newPassword,
                      obscureText: notifier.obscureText,
                      hintText: 'Enter your new password',
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
                        if (val == null || val.isEmpty || val.length < 8) {
                          return 'Please enter valid new password';
                        }
                        return null;
                      },
                    ),
                    const HeightSpacer(size: 20),
                    CustomTextField(
                      controller: confirmPassword,
                      obscureText: notifier.obscureText,
                      hintText: 'Confirm your new password',
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
                        if (val == null || val.isEmpty || val.length < 8) {
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
