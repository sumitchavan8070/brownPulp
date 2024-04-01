import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
  final prefs = GetStorage();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // final isLoading = prefs.read("IS_LOGGED_IN");

    // debugPrint(
    //   "login view init state called $isLoading GlobalVars: ${GlobalVars.isLoggedIn}",
    // );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            // TODO :  add app logo here
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 10,
              ),
              child: SvgPicture.asset(
                AssetPath.appLogo,
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width,
              ),
            ),

            SizedBox(height: 10, width: MediaQuery.of(context).size.width),
            Text(
              "Your hassle-free journey starts here!",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w300,
                  ),
            ),
            Container(
              decoration: AppBoxDecoration.getBoxDecoration(
                color: AppColors.white,
                borderRadius: 18,
                showShadow: true,
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
      ),
    );
  }
}
