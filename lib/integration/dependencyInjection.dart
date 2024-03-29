import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:get_it/get_it.dart';

import '../env/environment_settings.dart';
import '../helpers/repositoryHelper.dart';
import '../repository/api/ContributorApiRepository.dart';
import '../repository/api/interface/IContributorApiRepository.dart';
import '../services/base/analyticsService.dart';
import '../services/base/baseWidgetService.dart';
import '../services/base/dialogService.dart';
import '../services/base/languageService.dart';
import '../services/base/loadingWidgetService.dart';
import '../services/base/navigationService.dart';
import '../services/base/pathService.dart';
import '../services/base/themeService.dart';
import '../services/json/devDetailJsonService.dart';
import '../services/json/gameItemJsonService.dart';
import '../services/json/interface/IGameItemJsonService.dart';
import '../services/json/interface/IRecipeJsonService.dart';
import '../services/json/packingJsonService.dart';
import '../services/json/recipeJsonService.dart';

final getIt = GetIt.instance;

void initDependencyInjection(EnvironmentSettings _env) {
  getIt.registerSingleton<EnvironmentSettings>(_env);

  // AssistantApps
  initAssistantAppsDependencyInjection(
    _env.toAssistantApps(),
    analytics: AnalyticsService(),
    theme: ThemeService(),
    path: PathService(),
    navigation: NavigationService(),
    baseWidget: BaseWidgetService(),
    dialog: DialogService(),
    loading: LoadingWidgetService(),
    language: LanguageService(),
  );

  getIt.registerFactoryParam<IRecipeJsonService, LocaleKey, String>(
    (LocaleKey key, String unused) =>
        RecipeJsonService(getBaseFileName(key), key),
  );

  getIt.registerFactoryParam<IGameItemJsonService, LocaleKey, String>(
    (LocaleKey key, String unused) =>
        GameItemJsonService(getBaseFileName(key), key),
  );

  //Repository
  getIt.registerSingleton<IContributorApiRepository>(
    ContributorApiRepository(),
  );

  //Service
  getIt.registerSingleton<PackingJsonService>(PackingJsonService());
  getIt.registerSingleton<DevDetailJsonService>(DevDetailJsonService());
}

EnvironmentSettings getEnv() => getIt<EnvironmentSettings>();

IRecipeJsonService getRecipeRepo(LocaleKey key) =>
    getIt<IRecipeJsonService>(param1: key, param2: 'di');

IGameItemJsonService getGameItemRepo(LocaleKey key) =>
    getIt<IGameItemJsonService>(param1: key, param2: 'di');

//Repository
IContributorApiRepository getContributorApiRepo() =>
    getIt<IContributorApiRepository>();

//Service
PackingJsonService getPackingService() => getIt<PackingJsonService>();
DevDetailJsonService getDevDetailService() => getIt<DevDetailJsonService>();
