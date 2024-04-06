import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project/auth_module/sign_up_module/sign_up_controller.dart';
import 'package:project/utilities/constants/custom_dialogs.dart';
import 'package:project/utilities/constants/custom_text_field.dart';
import 'package:project/utilities/navigation/go_paths.dart';
import 'package:project/utilities/navigation/my_navigator.dart';
import 'package:project/utilities/theme/app_box_decoration.dart';
import 'package:project/utilities/theme/app_colors.dart';
import 'package:project/utilities/theme/asset_path.dart';
import 'package:project/utilities/theme/button_decoration.dart';
import 'package:project/utilities/validators/generic_validator.dart';

import '../../utilities/constants/custom_flutter_toast.dart';

final _signUpController = Get.put(SignUpController());

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
  bool showNameEnabled = false;
  bool showNumberEnabled = false;
  bool acceptTermsCondition = false;

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
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  child: Column(
                    children: [
                      SvgPicture.asset(AssetPath.authLogo),
                      const SizedBox(height: 20),
                      Text(
                        "Let’s Get You Started With brownpulp",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.midGrey),
                      ),
                    ],
                  ),
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
                                      showNameEnabled = false;
                                    });
                                  } else {
                                    setState(() {
                                      showNameEnabled = true;
                                    });
                                  }
                                },
                                prefix: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: SvgPicture.asset(
                                    showNameEnabled ? AssetPath.activeUserName : AssetPath.inActiveUserName,
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
                                fillColor: AppColors.transparent,
                                onChanged: (value) {
                                  if (value!.isEmpty) {
                                    showEmailEnabled = false;
                                    setState(() {});
                                  } else {
                                    showEmailEnabled = true;
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
                                    showEmailEnabled ? AssetPath.mailEnabled : AssetPath.mail,
                                  ),
                                ),
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
                                hintText: "Enter your phone number",
                                controller: phoneController,
                                fillColor: AppColors.transparent,
                                onChanged: (value) {
                                  if (value!.isEmpty) {
                                    setState(() {
                                      showNumberEnabled = false;
                                      GenericValidator.numberValidator(
                                        value: value,
                                        message: "Please enter valid number",
                                      );
                                    });
                                  } else {
                                    setState(() {
                                      showNumberEnabled = true;
                                    });
                                  }
                                },
                                prefix: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: SvgPicture.asset(
                                    showNumberEnabled ? AssetPath.activeCall : AssetPath.inActiveCall,
                                  ),
                                ),
                                validator: (value) {
                                  return GenericValidator.required(
                                        value: value,
                                        message: "Please enter name",
                                      ) ??
                                      GenericValidator.numberValidator(
                                        value: value,
                                        message: "Please enter valid number",
                                      );
                                },
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
                                    value: acceptTermsCondition,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        acceptTermsCondition = value ?? false;
                                        // Add your logic here if needed
                                      });
                                    },
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Accept the',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                color: AppColors.midGrey,
                                              ),
                                        ),
                                        TextSpan(
                                          text: ' Terms & Condition',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                color: AppColors.doggerBlule,
                                              ),
                                        ),
                                      ],
                                    ),
                                    maxLines: 2,
                                  ),
                                ],
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
                                if (acceptTermsCondition == false) {
                                  debugPrint("please accept terms and condition");
                                  CustomFlutterToast.showToast(
                                    message: "Please accept terms and condition",
                                  );
                                  return;
                                }

                                debugPrint("all validate success for sign up");

                                await _signUpController
                                    .signUp(
                                  "",
                                  email: emailController.text,
                                  password: passwordController.text,
                                  userName: nameController.text,
                                  phone: phoneController.text,
                                )
                                    .then((value) {
                                  if (value == 1) {
                                    Dialogs.showSuccessDialog(
                                      context,
                                    );
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
                                });
                              }
                              debugPrint("outside");
                            },
                            // Button label
                            style: getElevatedButtonStyle(
                              borderRadius: 40,
                              foregroundColor: AppColors.roseEbony,
                              backgroundColor: AppColors.roseEbony,
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
      ),
    );
  }
}
