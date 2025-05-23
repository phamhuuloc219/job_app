import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/views/common/app_style.dart';
import 'package:job_app/views/common/width_spacer.dart';

class CustomField extends StatefulWidget {
  const CustomField(
      {super.key, required this.controller, required this.onSearch});

  final TextEditingController controller;
  final VoidCallback onSearch;

  @override
  _CustomFieldState createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 45.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      color: Color(kLightGrey.value),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Ionicons.chevron_back_circle,
                size: 30.h,
                color: Color(kOrange.value),
              ),
            ),
          ),
          const WidthSpacer(width: 5),
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              cursorHeight: 25,
              style: appStyle(14, Color(kDark.value), FontWeight.w500),
              decoration: InputDecoration(
                hintText: 'Search a job',
                hintStyle:
                    appStyle(14, Color(kDarkGrey.value), FontWeight.w500),
                border: InputBorder.none,
                suffixIcon: widget.controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close, color: Color(0xfff55631)),
                        onPressed: () {
                          widget.controller.clear();
                          setState(() {});
                        },
                      )
                    : null,
              ),
              onFieldSubmitted: (value) {
                widget.onSearch();
              },
            ),
          ),
          const WidthSpacer(width: 5),
          GestureDetector(
            onTap: widget.onSearch,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                Ionicons.search_circle,
                size: 35.h,
                color: Color(kOrange.value),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
