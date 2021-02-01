import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:scrapmechanic_kurtlourens_com/constants/JsonFile.dart';

import '../../contracts/generated/SteamNewsItem.dart';
import '../../contracts/generated/contributorViewModel.dart';
import '../BaseJsonService.dart';

class BackupJsonService extends BaseJsonService {
  Future<ResultWithValue<List<ContributorViewModel>>> getContributors(
      context) async {
    try {
      dynamic jsonString =
          await this.getJsonFromAssets(context, JsonFile.contributorBackup);
      List responseJson = json.decode(jsonString);
      List<ContributorViewModel> backupItems =
          responseJson.map((m) => ContributorViewModel.fromJson(m)).toList();

      return ResultWithValue<List<ContributorViewModel>>(true, backupItems, '');
    } catch (exception) {
      getLog()
          .e("BackupJsonService getContributors() Ex: ${exception.toString()}");
      return ResultWithValue<List<ContributorViewModel>>(
          false, List<ContributorViewModel>(), exception.toString());
    }
  }

  Future<ResultWithValue<List<SteamNewsItem>>> getSteamNews(context) async {
    try {
      dynamic jsonString =
          await this.getJsonFromAssets(context, JsonFile.steamNewsBackup);
      List responseJson = json.decode(jsonString);
      List<SteamNewsItem> backupItems =
          responseJson.map((m) => SteamNewsItem.fromJson(m)).toList();

      return ResultWithValue<List<SteamNewsItem>>(true, backupItems, '');
    } catch (exception) {
      getLog().e(
          "BackupJsonService getSteamNews() Exception: ${exception.toString()}");
      return ResultWithValue<List<SteamNewsItem>>(
          false, List<SteamNewsItem>(), exception.toString());
    }
  }

  Future<PaginationResultWithValue<List<VersionViewModel>>> getVersions(
    context, {
    String langCode = 'en',
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      dynamic jsonString = await this
          .getJsonFromAssets(context, '${JsonFile.whatIsNewBackup}$langCode');
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
          false, List<VersionViewModel>(), 1, 1, exception.toString());
    }
  }
}
