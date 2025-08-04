import 'package:counter_module/core/utils/theme_service.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:modular_poc/injection_container/injectable.config.dart';



import 'navigation_service.dart';

final getIt = GetIt.instance;
//final GetIt conn = GetIt.instance;

@InjectableInit()
Future<void> configureInjection() async {
  getIt.init();
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());
  getIt.registerLazySingleton<ThemeServiceProvider>(() => ThemeServiceProvider());
}

@module
abstract class RegisterModule {
  @lazySingleton
  Connectivity get connectivity => Connectivity();


}
