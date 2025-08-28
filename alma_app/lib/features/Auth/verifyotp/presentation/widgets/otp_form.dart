import 'package:alma_app/core/constants/app_constants.dart';
import 'package:alma_app/core/extensions/sizedbox_extensions.dart';
import 'package:alma_app/core/theme/app_colors.dart';
import 'package:alma_app/core/theme/text_styles.dart';
import 'package:alma_app/core/utils/card_widget.dart';
import 'package:alma_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';
import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

class OtpForm extends StatefulWidget {
  final String source; // 'login' or 'forget_password'
  const OtpForm({super.key, required this.source});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController pinController;
  SmartAuth smartAuth = SmartAuth.instance;
  late final FocusNode focusNode;
  // late final SmsRetriever smsRetriever;
  Timer? _timer;
  int _secondsRemaining = 60;
  // String? _appSignature;
  bool _canResend = false;
  bool _isVerifying = false;
  bool isinvalid = false;
  bool firstsubmit = false;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      BrowserContextMenu.disableContextMenu();
    }
    pinController = TextEditingController();
    focusNode = FocusNode();
    // smsRetriever = SmsRetrieverImpl(smartAuth, useUserConsentApi: true);
    _startTimer();
    // _getAppSignature();
  }

  // void _getAppSignature() async {
  //   final signature = await smartAuth.getAppSignature();
  //   setState(() {
  //     _appSignature = signature.data;
  //   });
  //   debugPrint('App Signature: $_appSignature');
  // }

  void _startTimer() {
    _canResend = false;
    _secondsRemaining = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        setState(() {
          firstsubmit = true;
          isinvalid = true;
          _canResend = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    pinController.dispose();
    focusNode.dispose();
    // smsRetriever.dispose();
    if (kIsWeb) {
      BrowserContextMenu.enableContextMenu();
    }
    super.dispose();
  }

  Future<void> _verifyOtp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isVerifying = true;
        firstsubmit = true;
      });
      String otp = pinController.text;
      debugPrint('Submitted OTP: $otp');
      // Replace with actual backend API call
      try {
        await Future.delayed(const Duration(seconds: 1)); // Simulate API call
        setState(() {
          _isVerifying = false;
        });
        if (!isinvalid) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('OTP verified successfully!')),
          );

          // Navigate based on source
          if (widget.source == 'forget_password') {
            // Navigate to set new password page with OTP
            Navigator.of(context).pushReplacementNamed(
              '/setNewPasswordScreen',
              arguments: {
                'otp': otp,
                'email': ''
              }, // You might want to pass email too
            );
          } else {
            // Navigate to home page for login
            Navigator.of(context).pushReplacementNamed('/homeScreen');
          }
        }
      } catch (e) {
        setState(() {
          _isVerifying = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('otp_verification_failed'.tr())),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('otp_invalid'.tr())),
      );
    }
  }

  Future<void> _resendOtp() async {
    pinController.clear();
    setState(() {
      firstsubmit = false;
      isinvalid = false;
      _canResend = true;
    });
    _startTimer();
    // Replace with actual backend API call
    try {
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('otp_resent'.tr())),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('otp_resend_failed'.tr())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: AppColor.border),
      ),
    );

    return cardWidget(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // OTP Input Fields
              Directionality(
                textDirection: ui.TextDirection.ltr,
                child: Pinput(
                  length: 6,
                  // smsRetriever: smsRetriever,
                  controller: pinController,
                  focusNode: focusNode,
                  defaultPinTheme: defaultPinTheme,
                  separatorBuilder: (index) => horizontalSpace(8),

                  validator: (value) {
                    setState(() {
                      isinvalid = value == '222222' ? false : true;
                    });
                    return value == '222222' ? null : null;
                  },
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  autofillHints: const [AutofillHints.oneTimeCode],
                  onCompleted: (pin) {
                    debugPrint('onCompleted: $pin');
                    _verifyOtp();
                  },

                  onChanged: (value) {
                    setState(() {
                      firstsubmit = false;
                      isinvalid = false;
                    });
                    debugPrint('onChanged: $value');
                  },

                  disabledPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: AppColor.whiteInputBg,
                      borderRadius: BorderRadius.circular(rRadius(4)),
                      border: Border.all(color: appColor),
                    ),
                  ),
                  followingPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: AppColor.whiteInputBg,
                      borderRadius: BorderRadius.circular(rRadius(4)),
                      border: Border.all(color: appColor),
                    ),
                  ),
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      borderRadius: BorderRadius.circular(rRadius(4)),
                      border: Border.all(color: appColor),
                    ),
                  ),
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: AppColor.whiteInputBg,
                      borderRadius: BorderRadius.circular(rRadius(4)),
                      border: Border.all(color: appColor),
                    ),
                  ),
                  errorPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: AppColor.whiteInputBg,
                      borderRadius: BorderRadius.circular(rRadius(4)),
                      border: Border.all(color: appColor),
                    ),
                  ),
                ),
              ),
              // Resend Button
              if (isinvalid)
                Wrap(
                  //  direction: Axis.vertical,
                  spacing: 0,
                  children: [
                    Text(
                      'otp.entered_oTP_is_invalid_or_expired'.tr(),
                      style:
                          TextStyles.text14Regular?.copyWith(color: appColor),
                    ),
                    GestureDetector(
                      onTap: _canResend ? _resendOtp : null,
                      child: IntrinsicWidth(
                        // width: 55,
                        child: Column(
                          children: [
                            Text(
                              'otp.resend_now'.tr(),
                              style: TextStyles.text14Bold?.copyWith(
                                color:
                                    _canResend ? appColor : AppColor.bodyText,
                              ),
                            ),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: _canResend ? appColor : AppColor.bodyText,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

              // Timer and Status
              if (!firstsubmit)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    '${'otp.resend_code_in'.tr()} $_secondsRemaining '.tr(),
                    style: TextStyle(
                      color: _canResend ? Colors.grey : Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),

              verticalSpace(32),
              // Verify Button
              ElevatedButton(
                onPressed: (_canResend || _isVerifying) ? null : _verifyOtp,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: _isVerifying
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text('auth.verify_code'.tr()),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
