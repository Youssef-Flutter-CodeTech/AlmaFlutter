import 'package:alma_app/app_bloc_observer.dart';
import 'package:alma_app/core/cubit/locale/locale_cubit.dart';
import 'package:alma_app/core/cubit/theme/theme_cubit.dart';
import 'package:alma_app/core/network/network_info.dart';
import 'package:alma_app/core/services/locale_service.dart'
    as NotificationService;
import 'package:alma_app/core/utils/cash_helper.dart';
import 'package:alma_app/features/Auth/login/presentation/cubit/login_cubit.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
Future<void> getItinit() async {
  CashHelper cashHelper = CashHelper();
  Dio dio = Dio();
  Bloc.observer = AppBlocObserver();
  await EasyLocalization.ensureInitialized();
  Future.wait([
    // NotificationService.getItinit(),

    cashHelper.init(),
  ]);

  sl.registerLazySingleton<InternetConnectivity>(() => NetworkInfo());
  sl.registerLazySingleton<Dio>(() => dio);
  sl.registerLazySingleton<CashHelper>(() => cashHelper);
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  sl.registerLazySingleton(() => LocaleCubit());
  sl.registerFactory<LoginCubit>(() => LoginCubit());
}
