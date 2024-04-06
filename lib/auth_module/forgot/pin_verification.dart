import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';
import 'package:project/utilities/theme/app_box_decoration.dart';
import 'package:project/utilities/theme/app_colors.dart';
import 'package:project/utilities/theme/asset_path.dart';

class EnterPinView extends StatefulWidget {
  const EnterPinView({super.key});

  @override
  State<EnterPinView> createState() => _EnterPinViewState();
}

class _EnterPinViewState extends State<EnterPinView> {
  final TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              // Lottie.asset(AssetPath.lockLottie, height: 135),
              SvgPicture.asset(AssetPath.authLogo),
              Text(
                "OTP Verification",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                "Please enter the 6 digits OTP sent to your mobile number",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),

              Text(
                "Enter Your 4 digit Login Pin",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkJungleGreen,
                    ),
              ),
              const SizedBox(height: 30),
              Pinput(
                androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                controller: pinController,
                keyboardType: TextInputType.number,
                length: 4,
                pinAnimationType: PinAnimationType.fade,
                defaultPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  textStyle: Theme.of(context).textTheme.bodyLarge,
                  decoration: AppBoxDecoration.getBorderBoxDecoration(
                    borderRadius: 10,
                    borderColor: AppColors.blueHaze,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Didn’t receive code?  ',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.midGrey,
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = (() {
                          debugPrint("here is the tap for resend the code ");
                        }),
                      text: 'Resend Now',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.doggerBlule,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                maxLines: 2,
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "By continuing , you agree to our Terms of service and Privacy policy",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.midGrey ,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              // Container(
              //   decoration: AppBoxDecoration.getBoxDecoration(
              //     color: Colors.red,
              //     shadowColor: AppColors.scienceBlue.withOpacity(0.25),
              //     offsetX: 4,
              //     offsetY: 8,
              //     blurRadius: 24,
              //   ),
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       minimumSize: Size(MediaQuery.of(context).size.width, 60),
              //     ),
              //     onPressed: () {
              //       _pinVerificationController
              //           .pinVerification(
              //         pin: pinController.text,
              //         token: _mobileVerificationController.state?.result?.token ?? "",
              //       )
              //           .then((value) {
              //         if (value['status'] == 1) {
              //           MyNavigator.popUntilAndPushNamed(value['result']['path']);
              //           return;
              //         }
              //         Dialogs.errorDialog(context, title: value['message']);
              //       });
              //     },
              //     child: ButtonLoader(
              //       isLoading: _pinVerificationController.isLoggingIn,
              //       loaderString: "Checking...",
              //       buttonString: "Continue",
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
