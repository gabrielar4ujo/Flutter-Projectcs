// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ImageController on _ImageController, Store {
  Computed<bool> _$imageClickComputed;

  @override
  bool get imageClick =>
      (_$imageClickComputed ??= Computed<bool>(() => super.imageClick,
              name: '_ImageController.imageClick'))
          .value;

  final _$_imageClickAtom = Atom(name: '_ImageController._imageClick');

  @override
  bool get _imageClick {
    _$_imageClickAtom.reportRead();
    return super._imageClick;
  }

  @override
  set _imageClick(bool value) {
    _$_imageClickAtom.reportWrite(value, super._imageClick, () {
      super._imageClick = value;
    });
  }

  @override
  String toString() {
    return '''
imageClick: ${imageClick}
    ''';
  }
}
