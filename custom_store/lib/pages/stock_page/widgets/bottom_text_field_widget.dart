import 'package:customstore/core/crud_category_controller.dart';
import 'package:customstore/pages/stock_page/stock_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class BottomTextFieldWidget extends StatefulWidget {
  const BottomTextFieldWidget({Key key, this.lastName, this.documentID})
      : super(key: key);

  @override
  _BottomTextFieldWidgetState createState() =>
      _BottomTextFieldWidgetState(lastName, documentID);

  final String lastName;
  final String documentID;
}

class _BottomTextFieldWidgetState extends State<BottomTextFieldWidget> {
  StockPageController stockPageController;
  CrudCategoryController crudController;

  final String lastName;
  final String documentID;

  _BottomTextFieldWidgetState(this.lastName, this.documentID);

  @override
  void initState() {
    super.initState();
    crudController = CrudCategoryController();
    stockPageController = StockPageController();
    stockPageController.textEditingController.text = lastName ?? "";
  }

  @override
  Widget build(BuildContext context) {
    print("lastName: $lastName");

    final edit = lastName != null;
    final title = edit ? "Digite um novo nome" : "Digite o nome da categoria";

    return Observer(
      builder: (context) => WillPopScope(
        onWillPop: () async => !crudController.isLoading,
        child: SingleChildScrollView(
            child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  enabled: !crudController.isLoading,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  controller: stockPageController.textEditingController,
                  onChanged: (text) {
                    stockPageController.setProductText(text, lastName);
                  },
                  decoration: InputDecoration(
                      suffixIcon: crudController.isLoading
                          ? Container(
                              padding: EdgeInsets.all(10),
                              child: CircularProgressIndicator())
                          : IconButton(
                              icon: Icon(Icons.close),
                              onPressed:
                                  stockPageController.textFormFieldClear),
                      border: OutlineInputBorder()),
                ),
              ),
              ListTile(
                leading: FlatButton(
                    onPressed: crudController.isLoading
                        ? null
                        : () => Navigator.pop(context),
                    child: Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    )),
                trailing: FlatButton(
                    onPressed: stockPageController.productTextValidator ||
                            !stockPageController.wasEdited ||
                        crudController.isLoading
                        ? null
                        : () async {
                            bool result;
                            String type;

                            if (!edit) {
                              type = "INSERT";
                              await crudController.insert(categoryName: stockPageController.productText).then((value) {
                                result = value;
                              });
                            } else {
                              print("UPDATE");
                              type = "UPDATE";
                              await crudController
                                  .update(documentID: documentID, categoryName: stockPageController.productText)
                                  .then((value) {
                                result = value;
                              });
                            }
                            print("Value : $result");
                            Navigator.pop(context, [result,type]);
                            //Navigator.pop(context);
                          },
                    child: Text(
                      "Salvar",
                      style: TextStyle(
                          color: stockPageController.productTextValidator ||
                                  !stockPageController.wasEdited ||
                              crudController.isLoading
                              ? Colors.grey
                              : Colors.black,
                          fontSize: 15),
                    )),
              )
            ],
          ),
        )),
      ),
    );
  }
}
