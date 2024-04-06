import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class OTPResult {
  bool success;
  String message;

  OTPResult({required this.success, required this.message});
}

Future<OTPResult> getOTP() async {
  const phoneNumber = "+91 9773390860";

  FirebaseAuth auth = FirebaseAuth.instance;

  Completer<OTPResult> completer = Completer<OTPResult>();

  verificationCompleted(PhoneAuthCredential credential) async {
    completer.complete(OTPResult(success: true, message: "Verification completed successfully."));
  }

  verificationFailed(FirebaseAuthException authException) {
    print('Failed: ${authException.message}');
    completer.complete(OTPResult(success: false, message: authException.message ?? "Unknown error occurred."));
  }

  codeSent(String verificationId, [int? forceResendingToken]) async {
    print('OTP sent to the provided phone number');
    completer.complete(OTPResult(success: true, message: "OTP sent successfully."));
  }

  codeAutoRetrievalTimeout(String verificationId) {
    completer.complete(OTPResult(success: false, message: "Code retrieval timed out."));
  }

  await auth.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    timeout: const Duration(seconds: 60),
    verificationCompleted: verificationCompleted,
    verificationFailed: verificationFailed,
    codeSent: codeSent,
    codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
  );

  return completer.future;
}
