import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:scrapmechanic_kurtlourens_com/constants/JsonFile.dart';

import '../../contracts/generated/contributorViewModel.dart';

class BackupJsonService extends BaseJsonService {
  Future<ResultWithValue<List<ContributorViewModel>>> getContributors(
      context) async {
    try {
      dynamic jsonString =
          await getJsonFromAssets(context, JsonFile.contributorBackup);
      List responseJson = json.decode(jsonString);
      List<ContributorViewModel> backupItems =
          responseJson.map((m) => ContributorViewModel.fromJson(m)).toList();

      return ResultWithValue<List<ContributorViewModel>>(true, backupItems, '');
    } catch (exception) {
      getLog()
          .e("BackupJsonService getContributors() Ex: ${exception.toString()}");
      return ResultWithValue<List<ContributorViewModel>>(
          false, List.empty(growable: true), exception.toString());
    }
  }

  Future<ResultWithValue<List<SteamNewsItemViewModel>>> getSteamNews(
      context) async {
    try {
      dynamic jsonString =
          await getJsonFromAssets(context, JsonFile.steamNewsBackup);
      List responseJson = json.decode(jsonString);
      List<SteamNewsItemViewModel> backupItems =
          responseJson.map((m) => SteamNewsItemViewModel.fromJson(m)).toList();

      return ResultWithValue<List<SteamNewsItemViewModel>>(
          true, backupItems, '');
    } catch (exception) {
      getLog().e(
          "BackupJsonService getSteamNews() Exception: ${exception.toString()}");
      return ResultWithValue<List<SteamNewsItemViewModel>>(
          false, List.empty(growable: true), exception.toString());
    }
  }

  Future<PaginationResultWithValue<List<VersionViewModel>>> getVersions(
    context, {
    String langCode = 'en',
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      dynamic jsonString = await getJsonFromAssets(
          context, '${JsonFile.whatIsNewBackup}$langCode');
      List responseJson = json.decode(jsonString);
      List<VersionViewModel> backupItems =
          responseJson.map((m) => VersionViewModel.fromJson(m)).toList();

      int totalPages = backupItems.length ~/ pageSize;
      List<VersionViewModel> filteredItems = backupItems
          .skip((page - 1) * pageSize) //
          .take(pageSize) //
          .toList();

      return PaginationResultWithValue<List<VersionViewModel>>(
          true, filteredItems, page, totalPages, '');
    } catch (exception) {
      getLog().e(
          "BackupJsonService getVersions() Exception: ${exception.toString()}");
      return PaginationResultWithValue<List<VersionViewModel>>(
          false, List.empty(growable: true), 1, 1, exception.toString());
    }
  }
}
