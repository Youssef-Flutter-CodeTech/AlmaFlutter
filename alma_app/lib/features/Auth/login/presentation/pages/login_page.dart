import 'package:alma_app/core/cubit/theme/theme_cubit.dart';
import 'package:alma_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubit/login_cubit.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // Helper function to select color based on theme mode
  Color checkColor({
    required BuildContext context,
    required Color lightColor,
    required Color darkColor,
  }) {
    final ThemeMode themeMode = context.watch<ThemeCubit>().state;
    final Brightness platformBrightness =
        MediaQuery.of(context).platformBrightness;
    return themeMode == ThemeMode.system
        ? (platformBrightness == Brightness.dark ? darkColor : lightColor)
        : (themeMode == ThemeMode.dark ? darkColor : lightColor);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: Scaffold(
        backgroundColor: checkColor(
          context: context,
          lightColor: AppColor.bgWhite,
          darkColor: AppColor.veryDark,
        ),
        appBar: AppBar(
          title: Text('auth.login_title'.tr()),
          backgroundColor: checkColor(
            context: context,
            lightColor: AppColor.bgWhite,
            darkColor: AppColor.veryDark,
          ),
          foregroundColor: checkColor(
            context: context,
            lightColor: AppColor.veryDark,
            darkColor: Colors.white,
          ),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'auth.login_subtitle'.tr(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: checkColor(
                        context: context,
                        lightColor: theme.hintColor,
                        darkColor: Colors.grey[400]!,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Expanded(child: LoginForm()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
