import 'package:flutter/material.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/controllers/onboarding_provider.dart';
import 'package:job_app/views/common/exports.dart';
import 'package:job_app/views/screens/onboarding/widget/screen_one.dart';
import 'package:job_app/views/screens/onboarding/widget/screen_three.dart';
import 'package:job_app/views/screens/onboarding/widget/screen_two.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OnBoardNotifier>(
        builder: (context, onBoardNotifier, child) {
          return Stack(
            children: [
              PageView(
                controller: pageController,
                physics: onBoardNotifier.isLastPage
                    ? const NeverScrollableScrollPhysics()
                    : const AlwaysScrollableScrollPhysics(),
                onPageChanged: (page) {
                  // Cập nhật trạng thái isLastPage khi thay đổi trang
                  onBoardNotifier.setLastPage(page == 2);
                  setState(() {});
                },
                children: const [PageOne(), PageTwo(), PageThree()],
              ),
              if (!onBoardNotifier.isLastPage)
                Positioned(
                  bottom: height * 0.12,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: 3,
                      effect: WormEffect(
                        dotColor: Color(kLight.value),
                        activeDotColor: Color(kOrange.value),
                        dotHeight: 12,
                        dotWidth: 12,
                        spacing: 10,
                      ),
                    ),
                  ),
                ),
              if (!onBoardNotifier.isLastPage)
                Positioned(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 30,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              pageController.jumpToPage(2);
                            },
                            child: ReusableText(
                              text: 'Skip',
                              style: appStyle(
                                  16, Color(kLight.value), FontWeight.normal),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            },
                            child: ReusableText(
                              text: 'Next',
                              style: appStyle(
                                  16, Color(kLight.value), FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}