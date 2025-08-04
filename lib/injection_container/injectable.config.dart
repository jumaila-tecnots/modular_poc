// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:modular_poc/core/network/network.dart' as _i508;
import 'package:modular_poc/core/network/network_info.dart' as _i441;
import 'package:modular_poc/core/utils/theme_service.dart' as _i1033;
import 'package:modular_poc/injection_container/injectable.dart' as _i44;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i1033.ThemeServiceProvider>(
        () => _i1033.ThemeServiceProvider());
    gh.lazySingleton<_i895.Connectivity>(() => registerModule.connectivity);
    gh.lazySingleton<_i441.NetworkInfo>(
        () => _i441.NetworkInfoImpl(gh<_i895.Connectivity>()));
    gh.lazySingleton<_i508.NetworkService>(
        () => _i508.HttpNetworkService(gh<_i441.NetworkInfo>()));
    return this;
  }
}

class _$RegisterModule extends _i44.RegisterModule {}
