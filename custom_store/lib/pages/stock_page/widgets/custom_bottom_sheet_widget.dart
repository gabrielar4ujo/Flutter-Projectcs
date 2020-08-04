import 'package:customstore/core/crud_category_controller.dart';
import 'package:customstore/core/crud_product_controller.dart';
import 'package:flutter/material.dart';

import 'bottom_text_field_widget.dart';

class CustomBottomSheetWidget extends StatefulWidget {
  final String lastName;
  final String documentID;
  final String userUID;
  final Map allProductsList;

  CustomBottomSheetWidget(
      {Key key,
      this.lastName,
      this.documentID,
      this.userUID,
      this.allProductsList})
      : super(key: key);

  @override
  _CustomBottomSheetWidgetState createState() => _CustomBottomSheetWidgetState(
      documentID: documentID,
      userUID: userUID,
      allProductsList: allProductsList,
      lastName: lastName);
}

class _CustomBottomSheetWidgetState extends State<CustomBottomSheetWidget> {
  bool isLoading = false;

  final String lastName;
  final String documentID;
  final String userUID;
  final Map allProductsList;

  _CustomBottomSheetWidgetState(
      {this.lastName, this.documentID, this.userUID, this.allProductsList});

  @override
  Widget build(BuildContext context) {
    final _crudController = CrudCategoryController();
    final _productController = CrudProductController();

    return WillPopScope(
      onWillPop: () async => !isLoading,
      child: BottomSheet(
        builder: (context) => Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: isLoading
              ? Container(
                  height: 98,
                  child: Center(child: CircularProgressIndicator()),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () async {
                        print("Mudar Nome");

                        var bottomSheetController = showModalBottomSheet(
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return BottomTextFieldWidget(
                                lastName: lastName,
                                documentID: documentID,
                              );
                            },
                            context: context);

                        bottomSheetController.then((value) {
                          Navigator.pop(context, value);
                        });
                      },
                      child: Text(
                        "Mudar nome da categoria",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    FlatButton(
                      onPressed: () {
                        print("Apagar Categoria");
                        setState(() {
                          isLoading = true;
                        });

                        print(allProductsList);
                        allProductsList.forEach((key, value) async {
                          await value['pictures'].forEach(
                              (url) => _productController.deletePictures(url));
                        });

                        _crudController
                            .delete(documentID: documentID)
                            .then((value) {
                          Navigator.pop(context, [value, "DELETE"]);
                        });
                      },
                      child: Text(
                        "Apagar categoria",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ),
        ),
        onClosing: () {},
      ),
    );
  }
}
