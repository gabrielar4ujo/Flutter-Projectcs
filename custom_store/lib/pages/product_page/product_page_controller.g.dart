// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_page_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductPageController on _ProductPageController, Store {
  Computed<String> _$nameTextComputed;

  @override
  String get nameText =>
      (_$nameTextComputed ??= Computed<String>(() => super.nameText,
              name: '_ProductPageController.nameText'))
          .value;
  Computed<String> _$priceTextComputed;

  @override
  String get priceText =>
      (_$priceTextComputed ??= Computed<String>(() => super.priceText,
              name: '_ProductPageController.priceText'))
          .value;
  Computed<String> _$spentTextComputed;

  @override
  String get spentText =>
      (_$spentTextComputed ??= Computed<String>(() => super.spentText,
              name: '_ProductPageController.spentText'))
          .value;
  Computed<bool> _$duplicatedNameComputed;

  @override
  bool get duplicatedName =>
      (_$duplicatedNameComputed ??= Computed<bool>(() => super.duplicatedName,
              name: '_ProductPageController.duplicatedName'))
          .value;
  Computed<bool> _$nameValidatorComputed;

  @override
  bool get nameValidator =>
      (_$nameValidatorComputed ??= Computed<bool>(() => super.nameValidator,
              name: '_ProductPageController.nameValidator'))
          .value;
  Computed<bool> _$emptyPriceValidatorComputed;

  @override
  bool get emptyPriceValidator => (_$emptyPriceValidatorComputed ??=
          Computed<bool>(() => super.emptyPriceValidator,
              name: '_ProductPageController.emptyPriceValidator'))
      .value;
  Computed<bool> _$invalidPriceValidatorComputed;

  @override
  bool get invalidPriceValidator => (_$invalidPriceValidatorComputed ??=
          Computed<bool>(() => super.invalidPriceValidator,
              name: '_ProductPageController.invalidPriceValidator'))
      .value;
  Computed<bool> _$invalidSpentValidatorComputed;

  @override
  bool get invalidSpentValidator => (_$invalidSpentValidatorComputed ??=
          Computed<bool>(() => super.invalidSpentValidator,
              name: '_ProductPageController.invalidSpentValidator'))
      .value;
  Computed<int> _$amountComputed;

  @override
  int get amount => (_$amountComputed ??= Computed<int>(() => super.amount,
          name: '_ProductPageController.amount'))
      .value;
  Computed<ObservableList<dynamic>> _$pictureListComputed;

  @override
  ObservableList<dynamic> get pictureList => (_$pictureListComputed ??=
          Computed<ObservableList<dynamic>>(() => super.pictureList,
              name: '_ProductPageController.pictureList'))
      .value;
  Computed<bool> _$stateIconComputed;

  @override
  bool get stateIcon =>
      (_$stateIconComputed ??= Computed<bool>(() => super.stateIcon,
              name: '_ProductPageController.stateIcon'))
          .value;
  Computed<bool> _$isLockedComputed;

  @override
  bool get isLocked =>
      (_$isLockedComputed ??= Computed<bool>(() => super.isLocked,
              name: '_ProductPageController.isLocked'))
          .value;

  final _$isLoadingAtom = Atom(name: '_ProductPageController.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$_nameTextAtom = Atom(name: '_ProductPageController._nameText');

  @override
  String get _nameText {
    _$_nameTextAtom.reportRead();
    return super._nameText;
  }

  @override
  set _nameText(String value) {
    _$_nameTextAtom.reportWrite(value, super._nameText, () {
      super._nameText = value;
    });
  }

  final _$_priceTextAtom = Atom(name: '_ProductPageController._priceText');

  @override
  String get _priceText {
    _$_priceTextAtom.reportRead();
    return super._priceText;
  }

  @override
  set _priceText(String value) {
    _$_priceTextAtom.reportWrite(value, super._priceText, () {
      super._priceText = value;
    });
  }

  final _$_spentTextAtom = Atom(name: '_ProductPageController._spentText');

  @override
  String get _spentText {
    _$_spentTextAtom.reportRead();
    return super._spentText;
  }

  @override
  set _spentText(String value) {
    _$_spentTextAtom.reportWrite(value, super._spentText, () {
      super._spentText = value;
    });
  }

  final _$_amountAtom = Atom(name: '_ProductPageController._amount');

  @override
  int get _amount {
    _$_amountAtom.reportRead();
    return super._amount;
  }

  @override
  set _amount(int value) {
    _$_amountAtom.reportWrite(value, super._amount, () {
      super._amount = value;
    });
  }

  final _$_pictureListAtom = Atom(name: '_ProductPageController._pictureList');

  @override
  ObservableList<dynamic> get _pictureList {
    _$_pictureListAtom.reportRead();
    return super._pictureList;
  }

  @override
  set _pictureList(ObservableList<dynamic> value) {
    _$_pictureListAtom.reportWrite(value, super._pictureList, () {
      super._pictureList = value;
    });
  }

  final _$_lockAtom = Atom(name: '_ProductPageController._lock');

  @override
  bool get _lock {
    _$_lockAtom.reportRead();
    return super._lock;
  }

  @override
  set _lock(bool value) {
    _$_lockAtom.reportWrite(value, super._lock, () {
      super._lock = value;
    });
  }

  final _$observableFeaturesAtom =
      Atom(name: '_ProductPageController.observableFeatures');

  @override
  ObservableMap<dynamic, dynamic> get observableFeatures {
    _$observableFeaturesAtom.reportRead();
    return super.observableFeatures;
  }

  @override
  set observableFeatures(ObservableMap<dynamic, dynamic> value) {
    _$observableFeaturesAtom.reportWrite(value, super.observableFeatures, () {
      super.observableFeatures = value;
    });
  }

  final _$_ProductPageControllerActionController =
      ActionController(name: '_ProductPageController');

  @override
  void changeName(String text) {
    final _$actionInfo = _$_ProductPageControllerActionController.startAction(
        name: '_ProductPageController.changeName');
    try {
      return super.changeName(text);
    } finally {
      _$_ProductPageControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changePrice(String text) {
    final _$actionInfo = _$_ProductPageControllerActionController.startAction(
        name: '_ProductPageController.changePrice');
    try {
      return super.changePrice(text);
    } finally {
      _$_ProductPageControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSpent(String text) {
    final _$actionInfo = _$_ProductPageControllerActionController.startAction(
        name: '_ProductPageController.changeSpent');
    try {
      return super.changeSpent(text);
    } finally {
      _$_ProductPageControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementOrDecrement(int number) {
    final _$actionInfo = _$_ProductPageControllerActionController.startAction(
        name: '_ProductPageController.incrementOrDecrement');
    try {
      return super.incrementOrDecrement(number);
    } finally {
      _$_ProductPageControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLock(bool state) {
    final _$actionInfo = _$_ProductPageControllerActionController.startAction(
        name: '_ProductPageController.setLock');
    try {
      return super.setLock(state);
    } finally {
      _$_ProductPageControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListColorProductPage({String size, String colorName, String amount}) {
    final _$actionInfo = _$_ProductPageControllerActionController.startAction(
        name: '_ProductPageController.setListColorProductPage');
    try {
      return super.setListColorProductPage(
          size: size, colorName: colorName, amount: amount);
    } finally {
      _$_ProductPageControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
observableFeatures: ${observableFeatures},
nameText: ${nameText},
priceText: ${priceText},
spentText: ${spentText},
duplicatedName: ${duplicatedName},
nameValidator: ${nameValidator},
emptyPriceValidator: ${emptyPriceValidator},
invalidPriceValidator: ${invalidPriceValidator},
invalidSpentValidator: ${invalidSpentValidator},
amount: ${amount},
pictureList: ${pictureList},
stateIcon: ${stateIcon},
isLocked: ${isLocked}
    ''';
  }
}
