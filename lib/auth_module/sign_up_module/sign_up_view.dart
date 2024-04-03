import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project/auth_module/login_module/login_controller.dart';
import 'package:project/utilities/constants/custom_dialogs.dart';
import 'package:project/utilities/constants/custom_text_field.dart';
import 'package:project/utilities/navigation/go_paths.dart';
import 'package:project/utilities/navigation/my_navigator.dart';
import 'package:project/utilities/theme/app_box_decoration.dart';
import 'package:project/utilities/theme/app_colors.dart';
import 'package:project/utilities/theme/asset_path.dart';
import 'package:project/utilities/theme/button_decoration.dart';
import 'package:project/utilities/validators/generic_validator.dart';

final _loginController = Get.put(LoginController());

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool showPass = true;
  final prefs = GetStorage();
  final _formKey = GlobalKey<FormState>();
  bool showPassEnabled = false;
  bool showEmailEnabled = false;
  bool rememberMeEnabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // final isLoading = prefs.read("IS_LOGGED_IN");
    // if (prefs.read("REMEMBER_EMAIL") != null) {
    //   emailController.text = prefs.read("REMEMBER_EMAIL");
    //
    // }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        extendBody: true,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                children: [
                  SvgPicture.asset(
                    AssetPath.authBg,
                    fit: BoxFit.cover, // You might need to adjust the fit as per your requirement
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 40,
                      ),
                      child: IconButton(
                        onPressed: () {
                          // Handle back button press here
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 30,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                            child: Text(
                              "User Name",
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            decoration: AppBoxDecoration.getBorderBoxDecoration(
                              showShadow: false,
                              borderRadius: 18,
                              borderColor: AppColors.pastalGrey,
                              color: AppColors.pastalGrey.withOpacity(0.2),
                            ),
                            child: CustomTextField(
                              hintText: "Enter your name",
                              controller: nameController,
                              fillColor: AppColors.transparent,
                              onChanged: (value) {
                                if (value!.isEmpty) {
                                  setState(() {
                                    showEmailEnabled = false;
                                  });
                                } else {
                                  setState(() {
                                    showEmailEnabled = true;
                                  });
                                }
                              },
                              prefix: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: SvgPicture.asset(
                                  showEmailEnabled ? AssetPath.mailEnabled : AssetPath.mail,
                                ),
                              ),
                              validator: (value) {
                                return GenericValidator.required(
                                  value: value,
                                  message: "Please enter name",
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                            child: Text(
                              "Email",
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            decoration: AppBoxDecoration.getBorderBoxDecoration(
                              showShadow: false,
                              borderRadius: 18,
                              borderColor: AppColors.pastalGrey,
                              color: AppColors.pastalGrey.withOpacity(0.2),
                            ),
                            child: CustomTextField(
                              hintText: "Enter Email Address",
                              controller: emailController,
                              obscureText: showPass,
                              fillColor: AppColors.transparent,
                              onChanged: (value) {
                                if (value!.isEmpty) {
                                  showPassEnabled = false;
                                  setState(() {});
                                } else {
                                  showPassEnabled = true;
                                  setState(() {});
                                }
                              },
                              validator: (value) {
                                return GenericValidator.required(
                                  value: value,
                                  message: "Please enter email",
                                );
                              },
                              prefix: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  showPassEnabled ? AssetPath.lockEnabled : AssetPath.lock,
                                ),
                              ),
                              suffix: passwordController.text.isNotEmpty
                                  ? Padding(
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
                                    )
                                  : SizedBox(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                            child: Text(
                              "Phone Number",
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            decoration: AppBoxDecoration.getBorderBoxDecoration(
                              showShadow: false,
                              borderRadius: 18,
                              borderColor: AppColors.pastalGrey,
                              color: AppColors.pastalGrey.withOpacity(0.2),
                            ),
                            child: CustomTextField(
                              hintText: " Enter phone number",
                              controller: phoneController,
                              obscureText: showPass,
                              fillColor: AppColors.transparent,
                              onChanged: (value) {
                                if (value!.isEmpty) {
                                  showPassEnabled = false;
                                  setState(() {});
                                } else {
                                  showPassEnabled = true;
                                  setState(() {});
                                }
                              },
                              validator: (value) {
                                return GenericValidator.required(
                                      value: value,
                                      message: "Please enter phone number",
                                    ) ??
                                    GenericValidator.numberValidator(
                                      value: value,
                                      message: "Please enter valid phone number",
                                    );
                              },
                              prefix: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  showPassEnabled ? AssetPath.lockEnabled : AssetPath.lock,
                                ),
                              ),
                              suffix: phoneController.text.isNotEmpty
                                  ? Padding(
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
                                    )
                                  : SizedBox(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(height: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                            child: Text(
                              "Password",
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            decoration: AppBoxDecoration.getBorderBoxDecoration(
                              showShadow: false,
                              borderRadius: 18,
                              borderColor: AppColors.pastalGrey,
                              color: AppColors.pastalGrey.withOpacity(0.2),
                            ),
                            child: CustomTextField(
                              hintText: "Password",
                              controller: passwordController,
                              obscureText: showPass,
                              fillColor: AppColors.transparent,
                              onChanged: (value) {
                                if (value!.isEmpty) {
                                  showPassEnabled = false;
                                  setState(() {});
                                } else {
                                  showPassEnabled = true;
                                  setState(() {});
                                }
                              },
                              validator: (value) {
                                return GenericValidator.required(
                                  value: value,
                                  message: "Please enter password",
                                );
                              },
                              prefix: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  showPassEnabled ? AssetPath.lockEnabled : AssetPath.lock,
                                ),
                              ),
                              suffix: passwordController.text.isNotEmpty
                                  ? Padding(
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
                                    )
                                  : SizedBox(),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: rememberMeEnabled,
                                  onChanged: (value) {
                                    setState(() {
                                      rememberMeEnabled = value ?? false;
                                      // Add your logic here if needed
                                    });
                                  },
                                ),
                                Text(
                                  "Remember Password",
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: AppColors.ebonyClay,
                                      ),
                                ),
                              ],
                            ),
                            Text(
                              "Forgot Password?",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.doggerBlule,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Divider(
                        color: AppColors.pastalGrey,
                        thickness: 1,
                        height: 1,
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                        child: ElevatedButton(
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
                                  Dialogs.showSuccessDialog(context);
                                  Future.delayed(const Duration(milliseconds: 1500), () async {
                                    MyNavigator.pushReplacementNamed(GoPaths.onboardingQuestions);
                                  });
                                  // Implement your logic here
                                  // For example, if you want to save email and password when the checkbox is checked:
                                  // if (rememberMeEnabled == true) {
                                  //   prefs.write("REMEMBER_EMAIL", emailController.text);
                                  //   prefs.write("REMEMBER_PASSWORD", passwordController.text);
                                  // }
                                }

                                if (value == 0) {
                                  debugPrint("${_loginController.state?.response}");
                                }
                              });
                            }
                            debugPrint("outside");
                          },
                          // Button label
                          style: getElevatedButtonStyle(
                            borderRadius: 40,
                            foregroundColor: AppColors.plantation,
                            backgroundColor: AppColors.plantation,
                            elevation: 0,
                          ),
                          child: Text(
                            "Sign In ",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppColors.white,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Don’t have an account? ',
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          color: AppColors.midGrey,
                                        ),
                                  ),
                                  TextSpan(
                                    text: ' Register Now',
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          color: AppColors.doggerBlule,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
