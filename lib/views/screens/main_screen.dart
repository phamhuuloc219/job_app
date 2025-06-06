import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:job_app/controllers/zoom_provider.dart';
import 'package:job_app/views/common/drawer/drawerScreen.dart';
import 'package:job_app/views/common/exports.dart';
import 'package:job_app/views/common/reusable_text.dart';
import 'package:job_app/views/screens/application/applied_jobs.dart';
import 'package:job_app/views/screens/auth/profile_screen.dart';
import 'package:job_app/views/screens/bookmark/bookmarks_screen.dart';
import 'package:job_app/views/screens/chat/chat_list.dart';
import 'package:job_app/views/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Consumer<ZoomNotifier>(
            builder: (context, zoomNofitier, child) {
              return ZoomDrawer(
                  menuScreen: DrawerScreen(indexSetter: (index) {
                    zoomNofitier.currentIndex = index ;
                  },),
                  borderRadius: 30,
                  menuBackgroundColor: Color(kLightBlue.value),
                  angle: 0.0,
                  slideWidth: 230,
                  mainScreen: currentScreen()
              );
            },
          ),
        ),
    );
  }
  Widget currentScreen(){
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    switch (zoomNotifier.currentIndex){
      case 0:
        return HomeScreen();
      case 1:
        return ChatList();
      case 2:
        return BookmarksScreen();
      // case 3:
      //   return AppliedJobs();
      case 4:
        return ProfileScreen(drawer: true,);
      default:
        return HomeScreen();
    }
  }
}