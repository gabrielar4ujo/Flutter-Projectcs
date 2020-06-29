import 'package:customstore/helpers/product_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'image_controller.g.dart';

class ImageController = _ImageController with _$ImageController;

abstract class _ImageController with Store {

  @observable
  bool _imageClick = false;

  @computed
  bool get imageClick => _imageClick;

  void imageCliked () {
    print("imageCliked");
    _imageClick = !_imageClick;
  }

}