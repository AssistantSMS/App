import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../../../contracts/recipe/recipe.dart';

class IRecipeJsonService {
  Future<ResultWithValue<List<Recipe>>> getAll(context) async {
    return ResultWithValue<List<Recipe>>(false, List<Recipe>(), '');
  }

  Future<ResultWithValue<Recipe>> getById(context, String id) async {
    return ResultWithValue<Recipe>(false, Recipe(), '');
  }

  Future<ResultWithValue<List<Recipe>>> getByInputsId(
      context, String id) async {
    return ResultWithValue<List<Recipe>>(false, List<Recipe>(), '');
  }

  Future<ResultWithValue<List<Recipe>>> getByOutputId(
      context, String id) async {
    return ResultWithValue<List<Recipe>>(false, List<Recipe>(), '');
  }
}
