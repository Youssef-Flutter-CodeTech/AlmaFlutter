import 'package:alma_app/core/extensions/sizedbox_extensions.dart';
import 'package:alma_app/core/theme/app_colors.dart';
import 'package:alma_app/core/theme/text_styles.dart';
import 'package:alma_app/core/utils/background_img.dart';
import 'package:alma_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/login_cubit.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: Scaffold(
        backgroundColor: checkColor(
          context: context,
          lightColor: AppColor.whiteInputBg,
          darkColor: AppColor.veryDark,
        ),
        // appBar:
        //  AppBar(
        //   // title: Text('auth.login_title'.tr()),
        //   scrolledUnderElevation: 0,
        //   elevation: 0,
        //   surfaceTintColor: Colors.transparent,
        //   backgroundColor: checkColor(
        //     context: context,
        //     lightColor: AppColor.whiteInputBg,
        //     darkColor: AppColor.border,
        //   ),
        //   foregroundColor: checkColor(
        //     context: context,
        //     lightColor: AppColor.veryDark,
        //     darkColor: Colors.white,
        //   ),
        // ),

        body: backgroundImg(
          isSvg: false,
          img: 'assets/images/loginbg.png',
          // items: SizedBox()
          items: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    verticalSpace(60),
                    Image.asset(
                      'assets/images/logo.png',
                      width: 62.w,
                      height: 62.h,
                    ),
                    verticalSpace(16),
                    Text(
                      'auth.login_title'.tr(),
                      style: TextStyles.text28Bold?.copyWith(
                        color: checkColor(
                          context: context,
                          lightColor: AppColor.primaryText,
                          darkColor: AppColor.primaryText,
                        ),
                      ),
                    ),
                    verticalSpace(4),
                    Text(
                      'auth.login_subtitle'.tr(),
                      style: TextStyles.text16Regular?.copyWith(
                        color: checkColor(
                          context: context,
                          lightColor: AppColor.bodyText,
                          darkColor: AppColor.primaryText,
                        ),
                      ),
                    ),
                    verticalSpace(24),
                    LoginForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
