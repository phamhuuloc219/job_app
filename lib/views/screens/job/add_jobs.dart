import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/controllers/skills_provider.dart';
import 'package:job_app/views/common/BackBtn.dart';
import 'package:job_app/views/common/app_bar.dart';
import 'package:job_app/views/common/custom_outline_btn.dart';
import 'package:job_app/views/common/custom_textfield.dart';
import 'package:job_app/views/common/exports.dart';
import 'package:job_app/views/common/height_spacer.dart';
import 'package:job_app/views/common/styled_container.dart';
import 'package:provider/provider.dart';

class AddJobs extends StatefulWidget {
  const AddJobs({super.key});

  @override
  State<AddJobs> createState() => _AddJobsState();
}

class _AddJobsState extends State<AddJobs> {
  TextEditingController title = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController contract = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController period = TextEditingController();
  TextEditingController imageUrl = TextEditingController();
  TextEditingController rq1 = TextEditingController();
  TextEditingController rq2 = TextEditingController();
  TextEditingController rq3 = TextEditingController();
  TextEditingController rq4 = TextEditingController();
  TextEditingController rq5 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kNewBlue.value),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.w),
          child: CustomAppBar(
            color: Color(kNewBlue.value),
              text: 'Upload Jobs',
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(AntDesign.leftcircleo, color: Color(0xFFFFFFFF),),
              ),
          ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Color(kLight.value),
              ),
              child: buildStyleContainer(
                  context,
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 20,
                    ),
                    child: ListView(
                      children: [
                        const HeightSpacer(size: 20),

                        // Title
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SizedBox(
                              height: 60,
                              child: TextFormField(
                                controller: title,
                                decoration: InputDecoration(
                                  label: Text('Job Title',style: TextStyle(fontSize: 12 ),),
                                  hintText: "Job Title",
                                  hintStyle: TextStyle(color: Color(kDarkGrey.value), fontSize: 13),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue, width: 2),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please fill the field";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),

                        // Company
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SizedBox(
                              height: 60,
                              child: TextFormField(
                                controller: company,
                                decoration: InputDecoration(
                                  label: Text('Company',style: TextStyle(fontSize: 12 ),),
                                  hintText: "Company",
                                  hintStyle: TextStyle(color: Color(kDarkGrey.value), fontSize: 13),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue, width: 2),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please fill the field";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),

                        // Location
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SizedBox(
                              height: 60,
                              child: TextFormField(
                                controller: location,
                                decoration: InputDecoration(
                                  label: Text('Location',style: TextStyle(fontSize: 12 ),),
                                  hintText: "Location",
                                  hintStyle: TextStyle(color: Color(kDarkGrey.value), fontSize: 13),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue, width: 2),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please fill the field";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),

                        // Contract
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SizedBox(
                              height: 60,
                              child: TextFormField(
                                controller: contract,
                                decoration: InputDecoration(
                                  label: Text('Contract',style: TextStyle(fontSize: 12 ),),
                                  hintText: "Contract",
                                  hintStyle: TextStyle(color: Color(kDarkGrey.value), fontSize: 13),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue, width: 2),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please fill the field";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),

                        // ImageUrl
                        Consumer<SkillsNotifier>(
                            builder: (context, skillsNotifier, child) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: SizedBox(
                                  width: width,
                                  height: 60,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: width * 0.8,
                                        height: 60,
                                        child: TextFormField(
                                          controller: imageUrl,
                                          decoration: InputDecoration(
                                            label: Text('Image Url',style: TextStyle(fontSize: 12 ),),
                                            hintText: "Image Url",
                                            hintStyle: TextStyle(color: Color(kDarkGrey.value), fontSize: 13),
                                            border: OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.blue, width: 2),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            skillsNotifier.setLogoUrl(imageUrl.text);
                                          },
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "Please fill the field";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),

                                      GestureDetector(
                                        onTap: () {
                                          skillsNotifier.setLogoUrl(imageUrl.text);
                                        },
                                        child: Icon(Entypo.upload_to_cloud, size: 35, color: Color(kNewBlue.value),),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                        ),

                        // Description
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SizedBox(
                              height: 100,
                              child: TextFormField(
                                maxLines: 3,
                                controller: description,
                                decoration: InputDecoration(
                                  label: Text('Description',style: TextStyle(fontSize: 12 ),),
                                  hintText: "Description",
                                  hintStyle: TextStyle(color: Color(kDarkGrey.value), fontSize: 13),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue, width: 2),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please fill the field";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),

                        // Period
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SizedBox(
                              height: 60,
                              child: TextFormField(
                                controller: period,
                                decoration: InputDecoration(
                                  label: Text('Salary period',style: TextStyle(fontSize: 12 ),),
                                  hintText: "Monthly | Annual | Weekly",
                                  hintStyle: TextStyle(color: Color(kDarkGrey.value), fontSize: 13),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue, width: 2),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please fill the field";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                        
                        ReusableText(text: "Requirements", style: appStyle(15, Color(kDark.value), FontWeight.w600)),
                        const HeightSpacer(size: 10),

                        // Requirement 1
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SizedBox(
                              height: 80,
                              child: TextFormField(
                                maxLines: 2,
                                controller: rq1,
                                decoration: InputDecoration(
                                  label: Text('Requirements',style: TextStyle(fontSize: 12 ),),
                                  hintText: "Requirements",
                                  hintStyle: TextStyle(color: Color(kDarkGrey.value), fontSize: 13),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue, width: 2),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please fill the field";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),

                        // Requirement 2
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SizedBox(
                              height: 80,
                              child: TextFormField(
                                maxLines: 2,
                                controller: rq2,
                                decoration: InputDecoration(
                                  label: Text('Requirements',style: TextStyle(fontSize: 12 ),),
                                  hintText: "Requirements",
                                  hintStyle: TextStyle(color: Color(kDarkGrey.value), fontSize: 13),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue, width: 2),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please fill the field";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),

                        // Requirement 3
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SizedBox(
                              height: 80,
                              child: TextFormField(
                                maxLines: 2,
                                controller: rq3,
                                decoration: InputDecoration(
                                  label: Text('Requirements',style: TextStyle(fontSize: 12 ),),
                                  hintText: "Requirements",
                                  hintStyle: TextStyle(color: Color(kDarkGrey.value), fontSize: 13),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue, width: 2),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please fill the field";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),

                        // Requirement 4
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SizedBox(
                              height: 80,
                              child: TextFormField(
                                maxLines: 2,
                                controller: rq4,
                                decoration: InputDecoration(
                                  label: Text('Requirements',style: TextStyle(fontSize: 12 ),),
                                  hintText: "Requirements",
                                  hintStyle: TextStyle(color: Color(kDarkGrey.value), fontSize: 13),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue, width: 2),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please fill the field";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),

                        // Requirement 5
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SizedBox(
                              height: 80,
                              child: TextFormField(
                                maxLines: 2,
                                controller: rq5,
                                decoration: InputDecoration(
                                  label: Text('Requirements',style: TextStyle(fontSize: 12 ),),
                                  hintText: "Requirements",
                                  hintStyle: TextStyle(color: Color(kDarkGrey.value), fontSize: 13),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue, width: 2),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please fill the field";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                        HeightSpacer(size: 20),

                        CustomOutlineBtn(
                          height: 40.h,
                          width: width,
                          text: "Submit",
                          color: Color(kNewBlue.value),
                          onTap: () {
                          },
                        ),
                      ],
                    ),
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
