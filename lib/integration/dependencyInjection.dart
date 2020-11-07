import 'package:get_it/get_it.dart';

import '../env/environmentSettings.dart';
import '../helpers/repositoryHelper.dart';
import '../localization/localeKey.dart';
import '../repository/LocalStorageRepository.dart';
import '../repository/api/ContributorApiRepository.dart';
import '../repository/api/DonatorApiRepository.dart';
import '../repository/api/PatreonApiRepository.dart';
import '../repository/api/SteamApiRepository.dart';
import '../repository/api/VersionApiRepository.dart';
import '../repository/api/interface/IContributorApiRepository.dart';
import '../repository/api/interface/IDonatorApiRepository.dart';
import '../repository/api/interface/IPatreonApiRepository.dart';
import '../repository/api/interface/ISteamApiRepository.dart';
import '../repository/api/interface/IVersionApiRepository.dart';
import '../repository/interface/ILocalStorageRepository.dart';
import '../services/LocalStorageService.dart';
import '../services/interface/IGameItemJsonService.dart';
import '../services/interface/ILocalStorageService.dart';
import '../services/interface/IRecipeJsonService.dart';
import '../services/json/gameItemJsonService.dart';
import '../services/json/recipeJsonService.dart';

final getIt = GetIt.instance;

initDependencyInjection(EnvironmentSettings _env) {
  getIt.registerSingleton<EnvironmentSettings>(_env);

  getIt.registerFactoryParam<IRecipeJsonService, LocaleKey, String>(
    (LocaleKey key, String unused) =>
        RecipeJsonService(getBaseFileName(key), key),
  );

  getIt.registerFactoryParam<IGameItemJsonService, LocaleKey, String>(
    (LocaleKey key, String unused) =>
        GameItemJsonService(getBaseFileName(key), key),
  );

  //Repository
  getIt.registerSingleton<ILocalStorageRepository>(LocalStorageRepository());
  getIt.registerSingleton<ISteamApiRepository>(SteamApiRepository());
  getIt.registerSingleton<IPatreonApiRepository>(PatreonApiRepository());
  getIt.registerSingleton<IContributorApiRepository>(
    ContributorApiRepository(),
  );
  getIt.registerSingleton<IVersionApiRepository>(VersionApiRepository());
  getIt.registerSingleton<IDonatorApiRepository>(DonatorApiRepository());

  //Service
  getIt.registerSingleton<ILocalStorageService>(LocalStorageService());
}

EnvironmentSettings getEnv() => getIt<EnvironmentSettings>();

IRecipeJsonService getRecipeRepo(LocaleKey key) =>
    getIt<IRecipeJsonService>(param1: key, param2: 'di');

IGameItemJsonService getGameItemRepo(LocaleKey key) =>
    getIt<IGameItemJsonService>(param1: key, param2: 'di');

//Repository
ILocalStorageRepository getStorageRepo() => getIt<ILocalStorageRepository>();
ISteamApiRepository getSteamApiRepo() => getIt<ISteamApiRepository>();
IPatreonApiRepository getPatreonApiRepo() => getIt<IPatreonApiRepository>();
IContributorApiRepository getContributorApiRepo() =>
    getIt<IContributorApiRepository>();
IVersionApiRepository getVersionApiRepo() => getIt<IVersionApiRepository>();
IDonatorApiRepository getDonatorApiRepo() => getIt<IDonatorApiRepository>();

//Service
ILocalStorageService getStorageService() => getIt<ILocalStorageService>();
