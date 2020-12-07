import 'package:mobx/mobx.dart';

part 'global_store.g.dart';

class Config = _Config with _$Config;

abstract class _Config with Store {
  @observable
  String productHighlight = '';

  @action
  void changeHighlightedProduct(String newProduct) {
    productHighlight = newProduct;
  }

}