import 'dart:convert';

import '../../contracts/generated/AssistantApps/contributorViewModel.dart';
import '../../contracts/generated/AssistantApps/donationViewModel.dart';
import '../../contracts/generated/PatreonViewModel.dart';
import '../../contracts/generated/SteamNewsItem.dart';
import '../../contracts/results/paginationResultWithValue.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../integration/logging.dart';
import '../BaseJsonService.dart';

class BackupJsonService extends BaseJsonService {
  Future<ResultWithValue<List<PatreonViewModel>>> getPatrons(context) async {
    try {
      dynamic jsonString =
          await this.getJsonFromAssets(context, 'data/patronsBackup');
      List responseJson = json.decode(jsonString);
      List<PatreonViewModel> backupItems =
          responseJson.map((m) => PatreonViewModel.fromJson(m)).toList();

      return ResultWithValue<List<PatreonViewModel>>(true, backupItems, '');
    } catch (exception) {
      logger.e("BackupJsonService getPatrons() Ex: ${exception.toString()}");
      return ResultWithValue<List<PatreonViewModel>>(
          false, List<PatreonViewModel>(), exception.toString());
    }
  }

  Future<PaginationResultWithValue<List<DonationViewModel>>> getDonations(
      context,
      {int page = 1,
      int pageSize = 20}) async {
    try {
      dynamic jsonString =
          await this.getJsonFromAssets(context, 'data/donationBackup');
      List responseJson = json.decode(jsonString);
      List<DonationViewModel> backupItems =
          responseJson.map((m) => DonationViewModel.fromJson(m)).toList();

      int totalPages = backupItems.length ~/ pageSize;
      List<DonationViewModel> filteredItems = backupItems
          .skip((page - 1) * pageSize) //
          .take(pageSize) //
          .toList();

      return PaginationResultWithValue<List<DonationViewModel>>(
          true, filteredItems, page, totalPages, '');
    } catch (exception) {
      logger.e("BackupJsonService getDonations() Ex: ${exception.toString()}");
      return PaginationResultWithValue<List<DonationViewModel>>(
          false, List<DonationViewModel>(), 1, 0, exception.toString());
    }
  }

  Future<ResultWithValue<List<ContributorViewModel>>> getContributors(
      context) async {
    try {
      dynamic jsonString =
          await this.getJsonFromAssets(context, 'data/contributorBackup');
      List responseJson = json.decode(jsonString);
      List<ContributorViewModel> backupItems =
          responseJson.map((m) => ContributorViewModel.fromJson(m)).toList();

      return ResultWithValue<List<ContributorViewModel>>(true, backupItems, '');
    } catch (exception) {
      logger
          .e("BackupJsonService getContributors() Ex: ${exception.toString()}");
      return ResultWithValue<List<ContributorViewModel>>(
          false, List<ContributorViewModel>(), exception.toString());
    }
  }

  Future<ResultWithValue<List<SteamNewsItem>>> getSteamNews(context) async {
    try {
      dynamic jsonString =
          await this.getJsonFromAssets(context, 'data/steamNewsBackup');
      List responseJson = json.decode(jsonString);
      List<SteamNewsItem> backupItems =
          responseJson.map((m) => SteamNewsItem.fromJson(m)).toList();

      return ResultWithValue<List<SteamNewsItem>>(true, backupItems, '');
    } catch (exception) {
      logger
          .e("SteamNewsBackupJsonService() Exception: ${exception.toString()}");
      return ResultWithValue<List<SteamNewsItem>>(
          false, List<SteamNewsItem>(), exception.toString());
    }
  }
}
