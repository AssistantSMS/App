import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../../../contracts/gameItem/gameItem.dart';

class IGameItemJsonService {
  Future<ResultWithValue<List<GameItem>>> getAll(context) async {
    return ResultWithValue<List<GameItem>>(
        false, List.empty(growable: true), '');
  }

  Future<ResultWithValue<GameItem>> getById(context, String id) async {
    return ResultWithValue<GameItem>(false, GameItem.initial(), '');
  }

  // Future<ResultWithValue<List<Recipe>>> getByInputsId(
  //     context, String id) async {
  //   return ResultWithValue<List<Recipe>>(false, List.empty(growable: true), '');
  // }
}
