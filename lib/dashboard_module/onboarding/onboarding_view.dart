import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/utilities/constants/key_value_pair.dart';
import 'package:project/utilities/navigation/go_paths.dart';
import 'package:project/utilities/navigation/my_navigator.dart';
import 'package:project/utilities/theme/app_box_decoration.dart';
import 'package:project/utilities/theme/app_colors.dart';
import 'package:project/utilities/theme/asset_path.dart';

class OnboardingQuestions extends StatefulWidget {
  const OnboardingQuestions({super.key});

  @override
  State<OnboardingQuestions> createState() => _OnboardingQuestionsState();
}

class _OnboardingQuestionsState extends State<OnboardingQuestions> {
  final PageController _pageController = PageController(initialPage: 0);

  final questions = [
    [
      [
        KeyValuePair(
          key: "Sverom chair",
          value: "\$400",
          path: AssetPath.image1,
        ),
        KeyValuePair(
          key: "Norrviken chair and table",
          value: "\$999",
          path: AssetPath.image2,
        ),
      ],
      [
        KeyValuePair(
          key: 'Ektorp sofa',
          value: "\$599",
          path: AssetPath.image3,
        ),
        KeyValuePair(
          key: 'Jan Sflanaganvik sofa',
          value: "\$599",
          path: AssetPath.image4,
        ),
      ],
      [
        KeyValuePair(
          key: 'Ektorp sofa',
          value: "\$599",
          path: AssetPath.image5,
        ),
        KeyValuePair(
          key: 'Jan Sflanaganvik sofa',
          value: "\$599",
          path: AssetPath.image6,
        ),
      ]
    ],
    [
      [
        KeyValuePair(
          key: "Sverom chair",
          value: "\$400",
          path: AssetPath.image1,
        ),
        KeyValuePair(
          key: "Norrviken chair and table",
          value: "\$999",
          path: AssetPath.image2,
        ),
      ],
      [
        KeyValuePair(
          key: 'Ektorp sofa',
          value: "\$599",
          path: AssetPath.image3,
        ),
        KeyValuePair(
          key: 'Jan Sflanaganvik sofa',
          value: "\$599",
          path: AssetPath.image4,
        ),
      ],
      [
        KeyValuePair(
          key: 'Ektorp sofa',
          value: "\$599",
          path: AssetPath.image5,
        ),
        KeyValuePair(
          key: 'Jan Sflanaganvik sofa',
          value: "\$599",
          path: AssetPath.image6,
        ),
      ]
    ]
  ];

  Map<String, String> selectedAnswers = {};
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(AssetPath.appLogo),
                  Text(
                    "Skip",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.stardust,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),
            Container(
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              decoration: AppBoxDecoration.getBoxDecoration(
                showShadow: false,
                borderRadius: 8,
              ),
              child: LinearProgressIndicator(
                value: 0.2,
                backgroundColor: AppColors.porcelain,
                valueColor: AlwaysStoppedAnimation(AppColors.roseEbony.withOpacity(0.8)),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
            ),
            const SizedBox(height: 20),
            Flexible(
              child: PageView(
                onPageChanged: (int index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Living room",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      color: AppColors.darkJungleGreen,
                                    ),
                              ),
                              Text(
                                "Choose your style preference",
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      color: AppColors.charcoalGrey,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        ...List.generate(
                          questions.length,
                          (index) {
                            final question = questions[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: List.generate(
                                    question.length,
                                    (index) {
                                      final rowData = question[index];
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: List.generate(
                                          rowData.length,
                                          (index) {
                                            final data = rowData[index];

                                            return GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                                                decoration: AppBoxDecoration.getBoxDecoration(
                                                  showShadow: false,
                                                  color: AppColors.transparent,
                                                ),
                                                child: Image.asset(
                                                  data.path ?? "",
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Bedroom",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      color: AppColors.darkJungleGreen,
                                    ),
                              ),
                              Text(
                                "Choose your style preference",
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      color: AppColors.charcoalGrey,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        ...List.generate(
                          questions.length,
                          (index) {
                            final question = questions[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: List.generate(
                                    question.length,
                                    (index) {
                                      final rowData = question[index];
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: List.generate(
                                          rowData.length,
                                          (index) {
                                            final data = rowData[index];

                                            return GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                                                decoration: AppBoxDecoration.getBoxDecoration(
                                                  showShadow: false,
                                                  color: AppColors.transparent,
                                                ),
                                                child: Image.asset(
                                                  data.path ?? "",
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.all(28),
        decoration: AppBoxDecoration.getBoxDecoration(
          color: Colors.red,
          shadowColor: AppColors.scienceBlue.withOpacity(0.25),
          offsetX: 4,
          offsetY: 8,
          blurRadius: 24,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(MediaQuery.of(context).size.width, 60),
          ),
          onPressed: () {
            if (currentPageIndex < questions.length - 1) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 1200),
                curve: Curves.ease,
              );
            } else {
              MyNavigator.pushReplacementNamed(GoPaths.dashboard);
            }
          },
          child: const Text("Save & Next"),
        ),
      ),
    );
  }
}
