import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/controllers/image_provider.dart';
import 'package:job_app/controllers/jobs_provider.dart';
import 'package:job_app/controllers/login_provider.dart';
import 'package:job_app/controllers/onboarding_provider.dart';
import 'package:job_app/controllers/profile_provider.dart';
import 'package:job_app/controllers/signup_provider.dart';
import 'package:job_app/controllers/zoom_provider.dart';
import 'package:job_app/views/screens/mainscreen.dart';
import 'package:job_app/views/screens/onboarding/onboarding_screen.dart';
import 'package:provider/provider.dart';

// Widget defaultHome = const OnboardingScreen();
Widget defaultHome = const Mainscreen();
///TODO: Hook the app to firebase using firebase cli
void main() async {
 

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => OnBoardNotifier()),
    ChangeNotifierProvider(create: (context) => LoginNotifier()),
    ChangeNotifierProvider(create: (context) => ZoomNotifier()),
    ChangeNotifierProvider(create: (context) => SignUpNotifier()),
    ChangeNotifierProvider(create: (context) => JobsNotifier()),
    ChangeNotifierProvider(create: (context) => ImageUpoader()),
    ChangeNotifierProvider(create: (context) => ProfileNotifier()),
  ], child: const MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'NTU Student Job Market Application',
            theme: ThemeData(
              scaffoldBackgroundColor: Color(kLight.value),
              iconTheme: IconThemeData(color: Color(kDark.value)),
              primarySwatch: Colors.grey,
            ),
            home: defaultHome,
          );
        });
  }
}
