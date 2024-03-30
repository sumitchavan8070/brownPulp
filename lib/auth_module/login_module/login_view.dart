import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project/auth_module/login_module/login_controller.dart';
import 'package:project/utilities/constants/button_loader.dart';
import 'package:project/utilities/constants/custom_text_field.dart';
import 'package:project/utilities/navigation/go_paths.dart';
import 'package:project/utilities/navigation/my_navigator.dart';
import 'package:project/utilities/theme/app_box_decoration.dart';
import 'package:project/utilities/theme/app_colors.dart';
import 'package:project/utilities/theme/asset_path.dart';
import 'package:project/utilities/validators/generic_validator.dart';
import 'package:project/utilities/validators/my_regex.dart';

final _loginController = Get.put(LoginController());

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showPass = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              // Place as the child widget of a scaffold
              width: double.infinity,
              height: double.infinity,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
                    child: SvgPicture.asset(AssetPath.appLogo, height: 50, width: 100),
                  ),
                ],
              ),
              decoration: const BoxDecoration(
                color: AppColors.zircon,
                image: DecorationImage(
                  image: NetworkImage(
                    "https://mfiles.alphacoders.com/925/925003.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                // TODO :  add app logo here
                // SvgPicture.asset(
                //   AssetPath.testSvg,
                //   height: MediaQuery.of(context).size.height * 0.1,
                // ),
                SizedBox(height: 10, width: MediaQuery.of(context).size.width),
                Text(
                  "Your hassle-free journey starts here!",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                ),
                Container(
                  decoration: AppBoxDecoration.getBoxDecoration(
                    color: AppColors.white.withOpacity(0.2),
                    borderRadius: 14,
                    showShadow: false,
                  ),
                  margin: const EdgeInsets.all(26),
                  // constraints: getConstraints(context),
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextField(
                          hintText: "Email",
                          controller: emailController,
                          validator: (value) {
                            return GenericValidator.required(
                                  value: value,
                                  message: "Please enter email",
                                ) ??
                                GenericValidator.regexMatch(
                                  value: value,
                                  regex: MyRegex.emailPattern,
                                  message: "Invalid email",
                                );
                          },
                        ),
                        const SizedBox(height: 30),
                        CustomTextField(
                          hintText: "Password",
                          controller: passwordController,
                          obscureText: showPass,
                          validator: (value) {
                            return GenericValidator.required(
                              value: value,
                              message: "Please enter password",
                            );
                          },
                          suffix: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  showPass = !showPass;
                                });
                              },
                              child: SvgPicture.asset(
                                showPass ? AssetPath.hide : AssetPath.show,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
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
                            onPressed: () async {
                              if (_formKey.currentState?.validate() == true) {
                                debugPrint("check the values for login ");
                                await _loginController
                                    .login(
                                  email: emailController.text,
                                  password: passwordController.text,
                                )
                                    .then((value) {
                                  if (value == 1) {
                                    MyNavigator.pushReplacementNamed(GoPaths.onboardingQuestions);
                                  }

                                  if (value == 0) {
                                    debugPrint("${_loginController.state?.response}");
                                  }
                                });
                              }
                              debugPrint("outside");
                            },
                            child: ButtonLoader(
                              isLoading: false.obs,
                              loaderString: "Signing In...",
                              buttonString: "Sign In",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
