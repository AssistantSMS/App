import 'package:redux/redux.dart';

import 'actions.dart';
import 'raidState.dart';

final raidReducer = combineReducers<RaidState>([
  TypedReducer<RaidState, EditRaidAction>(_editRaid),
]);

RaidState _editRaid(RaidState state, EditRaidAction action) {
  return state.copyWith(
    carrot: action.carrot,
    tomato: action.tomato,
    beetroot: action.beetroot,
    banana: action.banana,
    berry: action.berry,
    orange: action.orange,
    potato: action.potato,
    pineapple: action.pineapple,
    broccoli: action.broccoli,
    cotton: action.cotton,
  );
}
