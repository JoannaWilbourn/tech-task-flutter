// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Size on _Size, Store {
  final _$selectedSizeAtom = Atom(name: '_Size.selectedSize');

  @override
  String get selectedSize {
    _$selectedSizeAtom.reportRead();
    return super.selectedSize;
  }

  @override
  set selectedSize(String value) {
    _$selectedSizeAtom.reportWrite(value, super.selectedSize, () {
      super.selectedSize = value;
    });
  }

  final _$_SizeActionController = ActionController(name: '_Size');

  @override
  void changeSelectedSize(String newSize) {
    final _$actionInfo =
        _$_SizeActionController.startAction(name: '_Size.changeSelectedSize');
    try {
      return super.changeSelectedSize(newSize);
    } finally {
      _$_SizeActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedSize: ${selectedSize}
    ''';
  }
}
