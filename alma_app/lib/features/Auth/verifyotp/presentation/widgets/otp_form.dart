import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({super.key});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final _controllers = List.generate(6, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(6, (i) {
            return SizedBox(
              width: 44,
              child: TextField(
                controller: _controllers[i],
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 1,
                decoration: const InputDecoration(counterText: ''),
                onChanged: (v) {
                  if (v.isNotEmpty && i < 5) FocusScope.of(context).nextFocus();
                },
              ),
            );
          }),
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {},
            child: Text('auth.resend'.tr()),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: () {},
            child: Text('auth.verify_code'.tr()),
          ),
        ),
      ],
    );
  }
}
