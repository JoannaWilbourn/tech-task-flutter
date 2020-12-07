// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Config on _Config, Store {
  final _$productHighlightAtom = Atom(name: '_Config.productHighlight');

  @override
  String get productHighlight {
    _$productHighlightAtom.reportRead();
    return super.productHighlight;
  }

  @override
  set productHighlight(String value) {
    _$productHighlightAtom.reportWrite(value, super.productHighlight, () {
      super.productHighlight = value;
    });
  }

  final _$_ConfigActionController = ActionController(name: '_Config');

  @override
  void changeHighlightedProduct(String newProduct) {
    final _$actionInfo = _$_ConfigActionController.startAction(
        name: '_Config.changeHighlightedProduct');
    try {
      return super.changeHighlightedProduct(newProduct);
    } finally {
      _$_ConfigActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
productHighlight: ${productHighlight}
    ''';
  }
}
