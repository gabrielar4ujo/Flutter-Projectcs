abstract class CategoryHelperI{

  Future<bool> insert(String categoryID);
  Future<bool> delete(String documentID);
  Future<bool> update(String documentID, String data);

}