import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:job_app/controllers/skills_provider.dart';
import 'package:job_app/controllers/zoom_provider.dart';
import 'package:job_app/models/request/skills/add_skill.dart';
import 'package:job_app/models/response/auth/skills.dart';
import 'package:job_app/services/helpers/auth_helper.dart';
import 'package:job_app/views/common/exports.dart';
import 'package:job_app/views/common/height_spacer.dart';
import 'package:job_app/views/common/width_spacer.dart';
import 'package:job_app/views/screens/auth/widgets/add_skill.dart';
import 'package:provider/provider.dart';

class SkillWidget extends StatefulWidget {
  const SkillWidget({super.key});

  @override
  State<SkillWidget> createState() => _SkillWidgetState();
}

class _SkillWidgetState extends State<SkillWidget> {
  TextEditingController userskills = TextEditingController();
  late Future<List<Skills>> userSkills;

  @override
  void initState() {
    userSkills = getSkills();
    super.initState();
  }

  Future<List<Skills>> getSkills(){
    var skills = AuthHelper.getSkills();
    return skills;
  }

  @override
  Widget build(BuildContext context) {
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    var skillsNotifier = Provider.of<SkillsNotifier>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReusableText(
                  text: "Skills",
                  style: appStyle(15, Color(kDark.value), FontWeight.w600)
              ),

              Consumer<SkillsNotifier>(
                  builder: (context, skillsNotifier, child) {
                    return skillsNotifier.addSkills != true
                    ? GestureDetector(
                      onTap: () {
                        skillsNotifier.setSkills = !skillsNotifier.addSkills;
                      },
                      child: Icon(MaterialCommunityIcons.plus_circle_outline, size: 24,),
                    )
                    : GestureDetector(
                      onTap: () {
                        skillsNotifier.setSkills = !skillsNotifier.addSkills;
                      },
                      child: Icon(AntDesign.closecircleo, size: 20,),
                    );
                  },
              ),
            ],
          ),
        ),
        const HeightSpacer(size: 5),

        skillsNotifier.addSkills == true
        ? AddSkillsWidget(
            skill: userskills,
            onTap: (){
              AddSkill rawModel = AddSkill(skill: userskills.text);
              var model = addSkillToJson(rawModel);
              AuthHelper.addSkill(model);
              userSkills = getSkills();
              userskills.clear();
              skillsNotifier.setSkills = !skillsNotifier.addSkills;
              userSkills = getSkills();
            },
        ) : SizedBox(
          height: 40.w,
          child: FutureBuilder(
              future: userSkills,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if(snapshot.hasError){
                  return Text("Error: ${snapshot.error}");
                } else {
                  var skills = snapshot.data;
                  return ListView.builder(
                    itemCount: skills!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var skill = skills[index];
                      return GestureDetector(
                        onLongPress: () {
                          skillsNotifier.setSkillsId = skill.id;
                        },
                        onTap: () {
                          skillsNotifier.setSkillsId = '';
                        },
                        child: Container(
                          padding: EdgeInsets.all(5.w),
                          margin: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15.w)),
                            color: Color(kLightGrey.value)
                          ),
                          child: Row(
                            children: [
                              ReusableText(
                                  text: skill.skill,
                                  style: appStyle(12, Color(kDark.value), FontWeight.w500)
                              ),
                              const WidthSpacer(width: 5),

                              skillsNotifier.addSkillsId == skill.id ?
                              GestureDetector(
                                onTap: () {
                                  AuthHelper.deleteSkill(
                                      skillsNotifier.addSkillsId);
                                  skillsNotifier.setSkillsId = '';
                                  userSkills = getSkills();
                                },
                                child: Icon(AntDesign.delete, size: 14, color: Color(kDark.value),),
                              ): SizedBox.shrink()
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
          ),
        ),
      ],
    );
  }
}
