import '../base/persistToStorage.dart';
import 'raidState.dart';

class EditRaidAction extends PersistToStorage {
  final int carrot;
  final int tomato;
  final int beetroot;
  final int banana;
  final int berry;
  final int orange;
  final int potato;
  final int pineapple;
  final int broccoli;
  final int cotton;
  EditRaidAction(
    this.carrot,
    this.tomato,
    this.beetroot,
    this.banana,
    this.berry,
    this.orange,
    this.potato,
    this.pineapple,
    this.broccoli,
    this.cotton,
  );
}
