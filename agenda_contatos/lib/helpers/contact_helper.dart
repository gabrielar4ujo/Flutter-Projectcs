
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String CONTACT_TABLE = "contactTable";
final String ID_COLUMN = "idColumn";
final String NAME_COLUMN = "nameColumn";
final String PHONE_COLUMN = "phoneColumn";
final String EMAIL_COLUMN = "emailColumn";
final String IMG_COLUMN = "imgColumn";

class ContactHelper {

  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  ContactHelper.internal();

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
    final path = join(databasePath, "contacts.db");

    return await openDatabase(
        path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $CONTACT_TABLE($ID_COLUMN INTEGER PRIMARY KEY, $NAME_COLUMN TEXT, $EMAIL_COLUMN TEXT, $PHONE_COLUMN TEXT, $IMG_COLUMN TEXT)"
      );
    });
  }

  Future<Contact> saveContact(Contact contact) async {
    Database dbContact = await db;
    contact._id = await dbContact.insert(CONTACT_TABLE, contact.toMap());
    return contact;
  }

  Future<Contact> getContact(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(CONTACT_TABLE,
        columns: [ID_COLUMN,NAME_COLUMN,EMAIL_COLUMN,PHONE_COLUMN,IMG_COLUMN],
        where: "$ID_COLUMN = ?",
        whereArgs: [id]);

    if(maps.length > 0){
      return Contact.fromMap(maps.first);
    }

    return null;
  }

  Future<int> deleteContact(int id) async{
    Database dbContact = await db;
    return await dbContact.delete(CONTACT_TABLE,
        where: "$ID_COLUMN = ?",
        whereArgs: [id]);
  }

  Future<int> updateContact(Contact contact) async{
    Database dbContact = await db;
    return await dbContact.update(CONTACT_TABLE, contact.toMap(), where: "$ID_COLUMN = ?", whereArgs: [contact.id]);
  }

  Future<List> getAllContacts() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $CONTACT_TABLE");
    List<Contact> listContact = List();
    for(Map m in listMap){
      listContact.add(Contact.fromMap(m));
    }

    return listContact;
  }

  Future<int>getNumber() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(await dbContact.rawQuery("SELECT COUNT(*) FROM $CONTACT_TABLE"));
  }

  Future closeTable() async{
    Database dbContact = await db;
    return dbContact.close();
  }

}

class Contact{

  int _id;
  String _name;
  String _img;
  String _phone;
  String _email;

  Contact(){}

  Contact.fromMap(Map map){
    _id = map[ID_COLUMN];
    _name = map[NAME_COLUMN];
    _phone = map[PHONE_COLUMN];
    _img = map[IMG_COLUMN];
    _email = map[EMAIL_COLUMN];
  }

  Map toMap(){
    Map<String, dynamic> map = {
      NAME_COLUMN: _name,
      EMAIL_COLUMN: _email,
      PHONE_COLUMN: _phone,
      IMG_COLUMN: _img
    };

    if( _id != null){
      map[ID_COLUMN] = _id;
    }

    return map;
  }

  @override
  String toString() {
    return "Contact(id: $_id, name: $_name, email: $_email, phone: $_phone, img: $_img)";
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get img => _img;

  set img(String value) {
    _img = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

}