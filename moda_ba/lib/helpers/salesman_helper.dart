
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String SALESMAN_TABLE = "salesmanTable";
final String ID_COLUMN = "idColumn";
final String NAME_COLUMN = "nameColumn";

class SalesmanHelper {

  static final SalesmanHelper _instance = SalesmanHelper.internal();

  factory SalesmanHelper() => _instance;

  SalesmanHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "salesman.db");

    return await openDatabase(
        path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $SALESMAN_TABLE($ID_COLUMN INTEGER PRIMARY KEY, $NAME_COLUMN TEXT)"
      );
    });
  }

  Future<Salesman> saveContact(Salesman contact) async {
    Database dbContact = await db;
    contact.id = await dbContact.insert(SALESMAN_TABLE, contact.toMap());
    return contact;
  }

  Future<Salesman> getContact(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(SALESMAN_TABLE,
        columns: [ID_COLUMN,NAME_COLUMN],
        where: "$ID_COLUMN = ?",
        whereArgs: [id]);

    if(maps.length > 0){
      return Salesman.fromMap(maps.first);
    }

    return null;
  }

  Future<int> deleteContact(int id) async{
    Database dbContact = await db;
    return await dbContact.delete(SALESMAN_TABLE,
        where: "$ID_COLUMN = ?",
        whereArgs: [id]);
  }

  Future<int> updateContact(Salesman contact) async{
    Database dbContact = await db;
    return await dbContact.update(SALESMAN_TABLE, contact.toMap(), where: "$ID_COLUMN = ?", whereArgs: [contact.id]);
  }

  Future<List> getAllContacts() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $SALESMAN_TABLE");
    List<Salesman> listContact = List();
    for(Map m in listMap){
      listContact.add(Salesman.fromMap(m));
    }

    return listContact;
  }

  Future<int>getNumber() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(await dbContact.rawQuery("SELECT COUNT(*) FROM $SALESMAN_TABLE"));
  }

  Future closeTable() async{
    Database dbContact = await db;
    return dbContact.close();
  }

}

class Salesman{

  int id;
  String name;

  Salesman(){}

  Salesman.fromMap(Map map){
    id = map[ID_COLUMN];
    name = map[NAME_COLUMN];
  }

  Map toMap(){
    Map<String, dynamic> map = {
      NAME_COLUMN: name,
    };

    if( id != null){
      map[ID_COLUMN] = id;
    }

    return map;
  }

  @override
  String toString() {
    return "Contact(id: $id, name: $name)";
  }


}