import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:get_it/get_it.dart';

import '../env/environmentSettings.dart';
import '../helpers/repositoryHelper.dart';
import '../repository/LocalStorageRepository.dart';
import '../repository/api/ContributorApiRepository.dart';
import '../repository/api/interface/IContributorApiRepository.dart';
import '../repository/interface/ILocalStorageRepository.dart';
import '../services/LocalStorageService.dart';
import '../services/base/analyticsService.dart';
import '../services/base/baseWidgetService.dart';
import '../services/base/dialogService.dart';
import '../services/base/loadingWidgetService.dart';
import '../services/base/loggingService.dart';
import '../services/base/navigationService.dart';
import '../services/base/pathService.dart';
import '../services/base/themeService.dart';
import '../services/json/gameItemJsonService.dart';
import '../services/json/interface/IGameItemJsonService.dart';
import '../services/json/interface/ILocalStorageService.dart';
import '../services/json/interface/IRecipeJsonService.dart';
import '../services/json/recipeJsonService.dart';

final getIt = GetIt.instance;

void initDependencyInjection(EnvironmentSettings _env) {
  getIt.registerSingleton<EnvironmentSettings>(_env);

  // AssistantApps
  initBaseDependencyInjection(
    _env.toAssistantApps(),
    logger: LoggerService(),
    analytics: AnalyticsService(),
    theme: ThemeService(),
    path: PathService(),
    navigation: NavigationService(),
    baseWidget: BaseWidgetService(),
    dialog: DialogService(),
    loading: LoadingWidgetService(),
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
  getIt.registerSingleton<ILocalStorageRepository>(LocalStorageRepository());
  getIt.registerSingleton<IContributorApiRepository>(
    ContributorApiRepository(),
  );

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
IContributorApiRepository getContributorApiRepo() =>
    getIt<IContributorApiRepository>();

//Service
ILocalStorageService getStorageService() => getIt<ILocalStorageService>();
