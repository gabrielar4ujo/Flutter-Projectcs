import 'package:customstore/core/crud_category_controller.dart';
import 'package:customstore/helpers/category_helper.dart';
import 'package:flutter/material.dart';

import 'bottom_text_field_widget.dart';

class CustomBottomSheetWidget extends StatefulWidget {

  final String lastName;
  final String documentID;
  final String userUID;

  CustomBottomSheetWidget({Key key, this.lastName, this.documentID, this.userUID}) : super(key: key);

  @override
  _CustomBottomSheetWidgetState createState() => _CustomBottomSheetWidgetState();
}

class _CustomBottomSheetWidgetState extends State<CustomBottomSheetWidget> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    final _crudController = CrudCategoryController();

    return WillPopScope(
      onWillPop: () async => !isLoading,
      child: BottomSheet(
        builder: (context)=> Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: isLoading ? Container(height: 98, child: Center(child: CircularProgressIndicator()),) : Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton(onPressed: ()async {
                print("Mudar Nome");

                var bottomSheetController = showModalBottomSheet(
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                  return BottomTextFieldWidget(lastName: widget.lastName,documentID: widget.documentID,);
                }, context: context);

                bottomSheetController.then((value) {
                  Navigator
                      .pop(context, value);
                });
                ;
              }, child: Text("Mudar nome da categoria", style: TextStyle(fontSize: 18),),),
              Divider(height: 1,thickness: 1,),
              FlatButton(onPressed: () {
                print("Apagar Categoria");
                setState(() {
                  isLoading = true;
                });
                _crudController.delete(documentID: widget.documentID).then((value) {
                 Navigator.pop(context,[value,"DELETE"]);
               });

              }, child: Text("Apagar categoria", style: TextStyle(fontSize: 18),),)
            ],
          ),
        ), onClosing: () {},
      ),
    );
  }
}
