import 'package:customstore/models/salesman.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AddSalesmanWidget extends StatefulWidget {
  final crudSalesmanController;
  final salesmanController;

  AddSalesmanWidget({this.crudSalesmanController, this.salesmanController});

  @override
  _AddSalesmanWidgetState createState() => _AddSalesmanWidgetState();
}

class _AddSalesmanWidgetState extends State<AddSalesmanWidget> {
  UnderlineInputBorder _underLineBorder =
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.white));

  UnderlineInputBorder _underlineInputBorderError = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.deepOrange[600]));

  TextStyle _textStyle =
      TextStyle(color: Colors.white, decorationColor: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Observer(
              builder: (context) => Text(
                    widget.salesmanController.isEditing
                        ? "Editar"
                        : "Adicionar",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  )),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 12.0, top: 2, bottom: 2, right: 6),
          child: Row(
            children: <Widget>[
              Flexible(
                child: Observer(
                  builder: (context) => TextFormField(
                    inputFormatters: widget.salesmanController.nameText.isEmpty
                        ? [
                            WhitelistingTextInputFormatter(RegExp("[a-zA-Z]")),
                          ]
                        : [
                            WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                          ],
                    enabled: !(widget.salesmanController.isLoading ||
                        widget.crudSalesmanController.isLoading),
                    focusNode: widget.salesmanController.focusNode,
                    controller:
                        widget.salesmanController.nameTextEditingController,
                    style: _textStyle,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    onChanged: widget.salesmanController.changeName,
                    decoration: _getInputDecoration(
                        text: "Nome",
                        onError: widget.salesmanController.onErrorName),
                  ),
                ),
                flex: 3,
              ),
              SizedBox(
                width: 35,
              ),
              Flexible(
                flex: 2,
                child: Observer(
                  builder: (context) => TextFormField(
                    enabled: !(widget.salesmanController.isLoading ||
                        widget.crudSalesmanController.isLoading),
                    controller: widget
                        .salesmanController.comissionTextEditingController,
                    style: _textStyle,
                    onChanged: widget.salesmanController.changeComission,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: _getInputDecoration(
                        text: "Comissão",
                        onError: widget.salesmanController.onErrorComission),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Observer(
                    builder: (context) => widget
                            .crudSalesmanController.isLoading
                        ? Container(
                            child: Center(child: CircularProgressIndicator()),
                            height: 20,
                            width: 20,
                            margin: EdgeInsets.only(left: 10),
                          )
                        : ClipOval(
                            child: Container(
                              height: 42,
                              width: 42,
                              color: Colors.deepPurple,
                              child: IconButton(
                                alignment: Alignment.bottomCenter,
                                icon: Icon(
                                  widget.salesmanController.isEditing
                                      ? Icons.check
                                      : Icons.add,
                                  color: Colors.white,
                                ),
                                onPressed: widget.salesmanController.isEditing
                                    ? () async {
                                        print("Editing");
                                        Salesman salesman = Salesman(
                                            comission: double.parse(widget
                                                .salesmanController
                                                .comissionText),
                                            name: widget
                                                .salesmanController.nameText);
                                        await widget.crudSalesmanController
                                            .update(
                                                salesman: salesman,
                                                documentID: widget
                                                    .salesmanController
                                                    .editedDocumentId)
                                            .then((value) {
                                          widget.salesmanController
                                              .resetFields();
                                          widget.salesmanController.isEditing =
                                              false;

                                          String message;
                                          if (value) {
                                            message =
                                                "Vendedor ATUALIZADO com sucesso!";
                                          } else
                                            message =
                                                "Problema de conexão! Vendedor ATUALIZADO localmente!";

                                          widget.salesmanController.scaffoldKey
                                              .currentState
                                              .showSnackBar(widget
                                                  .salesmanController
                                                  .getSnackBar(
                                                      message: message));
                                        });
                                      }
                                    : !widget.crudSalesmanController
                                                .isLoading &&
                                            (!widget.salesmanController
                                                    .nameValidator &&
                                                !widget.salesmanController
                                                    .comissionValidator)
                                        ? () async {
                                            print("Adding");
                                            await widget.crudSalesmanController
                                                .insert(
                                                    categoryName: widget
                                                        .salesmanController
                                                        .nameText,
                                                    comission: widget
                                                        .salesmanController
                                                        .comissionText)
                                                .then((value) {
                                              FocusScope.of(context).unfocus();
                                              widget.salesmanController
                                                  .resetFields();
                                              String message;
                                              if (value) {
                                                message =
                                                    "Vendedor ADICIONADO com sucesso!";
                                              } else
                                                message =
                                                    "Problema de conexão! Vendedor ADICIONADO localmente!";

                                              widget.salesmanController
                                                  .scaffoldKey.currentState
                                                  .showSnackBar(widget
                                                      .salesmanController
                                                      .getSnackBar(
                                                          message: message));
                                            });
                                          }
                                        : null,
                              ),
                            ),
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  InputDecoration _getInputDecoration(
      {@required String text, @required Function onError}) {
    return InputDecoration(
        errorBorder: _underlineInputBorderError,
        focusedErrorBorder: _underlineInputBorderError,
        errorText: onError(),
        errorStyle: TextStyle(color: Colors.deepOrange[500]),
        enabledBorder: _underLineBorder,
        focusedBorder: _underLineBorder,
        border: _underLineBorder,
        labelStyle: TextStyle(color: Colors.white, fontSize: 15),
        labelText: text);
  }
}
