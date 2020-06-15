import 'package:get_it/get_it.dart';

import '../env/environmentSettings.dart';
import '../helpers/repositoryHelper.dart';
import '../localization/localeKey.dart';
import '../services/LocalStorageService.dart';
import '../services/interface/ILocalStorageService.dart';
import '../services/interface/IRecipeJsonService.dart';

final getIt = GetIt.instance;

initDependencyInjection(EnvironmentSettings _env) {
  getIt.registerSingleton<EnvironmentSettings>(_env);

  getIt.registerFactoryParam<IRecipeJsonService, LocaleKey, String>(
    (LocaleKey key, String unused) => initRepo(key),
  );

  getIt.registerSingleton<ILocalStorageService>(
    LocalStorageService(),
  );
}

EnvironmentSettings getEnv() => getIt<EnvironmentSettings>();

IRecipeJsonService getGenericRepo(LocaleKey key) =>
    getIt<IRecipeJsonService>(param1: key, param2: 'di');

ILocalStorageService getStorageService() => getIt<ILocalStorageService>();
