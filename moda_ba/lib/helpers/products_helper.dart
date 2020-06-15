
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String PRODUCT_TABLE = "productTable";

final String ID_COLUMN = "idColumn";
final String NAME_COLUMN = "nameColumn";
final String SALESMAN_COLUMN = "nameSalesmanColumn";
final String PRICE_COLUMN = "priceColumn";
final String IMG_COLUMN = "imgColumn";
final String YEAR_COLUMN = "yearColumn";
final String MOUNTH_COLUMN = "mounthColumn";
final String DAY_COLUMN = "dayColumn";

class ProductHelper extends Model{

  static final ProductHelper _instance = ProductHelper.internal();

  factory ProductHelper() => _instance;

  ProductHelper.internal();

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
          "CREATE TABLE $PRODUCT_TABLE($ID_COLUMN INTEGER PRIMARY KEY, $NAME_COLUMN TEXT, $SALESMAN_COLUMN TEXT, $PRICE_COLUMN REAL, $IMG_COLUMN TEXT, $YEAR_COLUMN TEXT, $MOUNTH_COLUMN TEXT, $DAY_COLUMN TEXT)"
      );
    });
  }

  Future<Product> saveContact(Product product) async {
    Database dbContact = await db;
    product.id = await dbContact.insert(PRODUCT_TABLE, product.toMap());
    return product;
  }

  Future<Product> getContact(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(PRODUCT_TABLE,
        columns: [ID_COLUMN,NAME_COLUMN,SALESMAN_COLUMN,PRICE_COLUMN,IMG_COLUMN],
        where: "$ID_COLUMN = ?",
        whereArgs: [id]);

    if(maps.length > 0){
      return Product.fromMap(maps.first);
    }

    return null;
  }

  Future<int> deleteContact(int id) async{
    Database dbContact = await db;
    return await dbContact.delete(PRODUCT_TABLE,
        where: "$ID_COLUMN = ?",
        whereArgs: [id]);
  }

  Future<int> updateContact(Product product) async{
    Database dbContact = await db;
    return await dbContact.update(PRODUCT_TABLE, product.toMap(), where: "$ID_COLUMN = ?", whereArgs: [product.id]);
  }

  Future<Map> getAllContacts() async {

    Map<String, Map<String,dynamic>> mapTest = Map();

    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $PRODUCT_TABLE");
    List<Product> listContact = List();
    for(Map m in listMap){
      Product p = Product.fromMap(m);
      //print(p.year);
      if(!mapTest.containsKey(p.year)){
        mapTest[p.year] = {
          p.mounth : p.price
        };
      }
      else if(!mapTest[p.year].containsKey(p.mounth)){
        mapTest[p.year][p.mounth] = p.price;
      }
      else{
        mapTest[p.year][p.mounth] += p.price;
      }
      listContact.add(Product.fromMap(m));
    }
    //print(listContact);
    return mapTest;
  }

  Future<Map> getLastMonthPurchase() async {

    Map<String, Map<String,Product>> mapTest = Map();

    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $PRODUCT_TABLE");
    List<Product> listContact = List();
    for(Map m in listMap){
      Product p = Product.fromMap(m);

      if(!mapTest.containsKey(p.year)){
        mapTest[p.year] = {
          p.mounth : p,
        };
      }

      else if(!mapTest[p.year].containsKey(p.mounth)){
        mapTest[p.year][p.mounth] = p;
      }

      else{
        if(mapTest[p.year][p.mounth].id < p.id){
          mapTest[p.year][p.mounth] = p;
        }
      }

    }
    //print(listContact);
    return mapTest;
  }

  Future<int>getNumber() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(await dbContact.rawQuery("SELECT COUNT(*) FROM $PRODUCT_TABLE"));
  }

  Future closeTable() async{
    Database dbContact = await db;
    return dbContact.close();
  }

}

class Product{

  int id;
  String name;
  String img;
  double price;
  String nameSalesman;
  String year;
  String mounth;
  String day;
  int time;

  Product(){}

  Product.fromMap(Map map){
    id = map[ID_COLUMN];
    name = map[NAME_COLUMN];
    price = map[PRICE_COLUMN];
    img = map[IMG_COLUMN];
    nameSalesman = map[SALESMAN_COLUMN];
    year = map[YEAR_COLUMN];
    mounth = map[MOUNTH_COLUMN];
    day = map[DAY_COLUMN];
  }

  Map toMap(){
    Map<String, dynamic> map = {
      NAME_COLUMN: name,
      SALESMAN_COLUMN: nameSalesman,
      PRICE_COLUMN: price,
      IMG_COLUMN: img,
      YEAR_COLUMN: year,
      MOUNTH_COLUMN: mounth,
      DAY_COLUMN: day
    };

    if( id != null){
      map[ID_COLUMN] = id;
    }

    return map;
  }

  @override
  String toString() {
    return "Contact(id: $id, name: $name, salesman: $nameSalesman, price: $price, img: $img, year: $year, month: $mounth, day: $day)";
  }


}