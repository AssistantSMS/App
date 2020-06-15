import '../../contracts/gameItem/gameItem.dart';
import '../../contracts/results/resultWithValue.dart';

class IGameItemJsonService {
  Future<ResultWithValue<List<GameItem>>> getAll(context) async {
    return ResultWithValue<List<GameItem>>(false, List<GameItem>(), '');
  }

  Future<ResultWithValue<GameItem>> getById(context, String id) async {
    return ResultWithValue<GameItem>(false, GameItem(), '');
  }

  // Future<ResultWithValue<List<Recipe>>> getByInputsId(
  //     context, String id) async {
  //   return ResultWithValue<List<Recipe>>(false, List<Recipe>(), '');
  // }
}
