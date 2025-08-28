import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

class SmsRetrieverImpl implements SmsRetriever {
  const SmsRetrieverImpl(this.smartAuth, {this.useUserConsentApi = true});
  final SmartAuth smartAuth;
  final bool useUserConsentApi;

  @override
  Future<void> dispose() {
    return smartAuth.removeUserConsentApiListener();
  }

  @override
  Future<String?> getSmsCode() async {
    final signature = await smartAuth.getAppSignature();
    debugPrint('App Signature: ${signature.data}');
    final res = useUserConsentApi
        ? await smartAuth.getSmsWithUserConsentApi(
            matcher: r'\d{4}', // Matches 4-digit OTP
            // senderPhoneNumber: "+1234567890", // Uncomment if known
          )
        : await smartAuth.getSmsWithRetrieverApi();

    if (res.data != null && res.data!.code!.isNotEmpty) {
      return res.data!.code;
    }
    return null;
  }

  @override
  bool get listenForMultipleSms => false;
}
