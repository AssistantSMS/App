import '../../contracts/recipe/recipe.dart';
import '../../contracts/results/resultWithValue.dart';

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
