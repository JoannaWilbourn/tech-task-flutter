import 'package:mobx/mobx.dart';

part 'product_store.g.dart';

class Size = _Size with _$Size;

abstract class _Size with Store {
  @observable
  String selectedSize = '';

  @action
  void changeSelectedSize(String newSize) {
    selectedSize = newSize;
  }

}