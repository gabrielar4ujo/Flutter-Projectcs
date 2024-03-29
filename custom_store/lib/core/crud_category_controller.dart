import 'package:customstore/helpers/category_helper.dart';
import 'package:mobx/mobx.dart';

part 'crud_category_controller.g.dart';

class CrudCategoryController = _CrudCategoryController
    with _$CrudCategoryController;

abstract class _CrudCategoryController with Store {
  CategoryHelper _categoryHelper;

  _CrudCategoryController() : _categoryHelper = CategoryHelper();

  @observable
  bool isLoading = false;

  Future<bool> update({String documentID, String categoryName}) async {
    bool success;
    isLoading = true;
    await _categoryHelper.update(documentID, categoryName).then((value) {
      success = value;
      isLoading = false;
    });
    return success;
  }

  Future<bool> insert({String categoryName, String documentID}) async {
    bool success;
    isLoading = true;
    await _categoryHelper.insert(categoryName, documentID: documentID).then((value) {
      success = value;
      isLoading = false;
    });
    return success;
  }

  Future<bool> delete({String documentID}) async {
    bool success;
    isLoading = true;
    await _categoryHelper.delete(documentID).then((value) {
      success = value;
      isLoading = false;
    });
    return success;
  }
}
