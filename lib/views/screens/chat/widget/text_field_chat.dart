import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/views/common/app_style.dart';

class TextFieldChat extends StatelessWidget {
  const TextFieldChat(
      {super.key,
      required this.messageController,
      required this.suffixIcon,
      this.onChanged,
      this.onEditingComplete,
      this.onTapOutside,
      this.onSubmitted});

  final TextEditingController messageController;
  final Widget suffixIcon;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onEditingComplete;
  final void Function(PointerDownEvent)? onTapOutside;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Color(kDarkGrey.value),
      controller: messageController,
      keyboardType: TextInputType.multiline,
      style: appStyle(16, Color(kDark.value), FontWeight.w500),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.all(6.h),
        filled: true,
        fillColor: Color(kLight.value),
        suffixIcon: suffixIcon,
        hintText: "Type your message here",
        hintStyle: appStyle(14, Color(kDarkGrey.value), FontWeight.normal),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.h)),
            borderSide: BorderSide(color: Color(kDarkGrey.value))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.h)),
            borderSide: BorderSide(color: Color(kDarkGrey.value))),
      ),
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onTapOutside: onTapOutside,
      onSubmitted: onSubmitted,
    );
  }
}
