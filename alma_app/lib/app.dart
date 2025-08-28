import 'package:alma_app/core/cubit/color/color_cubit.dart';
import 'package:alma_app/core/cubit/locale/locale_cubit.dart';
import 'package:alma_app/core/services/theme_service.dart';
import 'package:alma_app/core/services/navigation_service.dart';
import 'package:alma_app/features/Auth/setnewpassword/presentation/widgets/set_new_password_form.dart';
import 'package:alma_app/features/Auth/setnewpassword/set_new_password.dart';
import 'package:alma_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/routing/app_router.dart';
import 'core/constants/app_constants.dart';
import 'core/cubit/theme/theme_cubit.dart';

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(430, 932),
        child: BlocListener<LocaleCubit, LocaleState>(
          listenWhen: (previous, current) => previous.locale != current.locale,
          listener: (context, localeState) {
            context.setLocale(localeState.locale);
          },
          child: BlocBuilder<PrimaryColorCubit, Color>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              return BlocBuilder<ThemeCubit, ThemeMode>(
                //  buildWhen: (previous, current) => previous != current,
                builder: (context, state) {
                  return MaterialApp(
                    navigatorKey: NavigationService.navigatorKey,
                    debugShowCheckedModeBanner: false,
                    title: AppConstants.appName,
                    theme: AppTheme.lightTheme,
                    darkTheme: AppTheme.darkTheme,
                    themeMode: context.watch<ThemeCubit>().themeMode,
                    locale: context.locale,
                    supportedLocales: context.supportedLocales,
                    localizationsDelegates: context.localizationDelegates,
                    onGenerateRoute: appRouter.generateRoute,
                    home: SplashScreen(),
                    initialRoute: '/',
                  );
                },
              );
            },
          ),
        ));
  }
}
