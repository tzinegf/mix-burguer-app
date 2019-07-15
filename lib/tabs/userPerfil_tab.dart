import 'package:flutter/material.dart';
import 'package:mix_burguer_app/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class UserPerfilTab extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<UserPerfilTab> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _numberController = TextEditingController();
  final _phoneController =  new  MaskedTextController (mask:'(00)00000-0000');



  final _scaffoldKey = GlobalKey<ScaffoldState>();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Minhas Infor"),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(
                child: CircularProgressIndicator(),
              );
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  Text("Nome e dados de login",style: TextStyle(fontSize: 10.0),),
                  TextFormField(
                    controller: _nameController,
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Nome invalido!";
                      }
                    },
                    decoration: InputDecoration(hintText: "Nome Completo"),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),

                  TextFormField(
                    controller: _emailController,
                    validator: (text) {
                      if (text.isEmpty || !text.contains("@") && !text.contains(".")) {
                        return "E-mail invalido!";
                      }
                    },
                    decoration: InputDecoration(hintText: "E-mail"),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _passController,
                    validator: (text) {
                      if (text.isEmpty || text.length < 6) {
                        return "Senha invalida!";
                      }
                    },
                    decoration: InputDecoration(hintText: "Senha"),
                    obscureText: true,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text("Endereço",style: TextStyle(fontSize: 10.0),),
                  TextFormField(
                    controller: _addressController,
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Endereço invalido!";
                      }
                    },
                    decoration: InputDecoration(hintText: "Rua / Avenida"),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),TextFormField(
                    controller: _numberController,
                    autovalidate: true,
                    validator: (text) {
                      if (text.isEmpty) {
                        text = "S/N";
                      }
                    },
                    decoration: InputDecoration(hintText: "Número"),
                    keyboardType: TextInputType.number,

                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _neighborhoodController,
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Bairro invalido!";
                      }
                    },
                    decoration: InputDecoration(hintText: "Bairro"),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    initialValue: "Nova Serrana MG",
                    keyboardType: TextInputType.text,
                    enabled: false,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text("Contato",style: TextStyle(fontSize: 10.0),),
                  TextFormField(
                    controller: _phoneController,

                    validator: (text) {
                      if (text.isEmpty) {
                        return "Telefone Invalido!";
                      }

                    },
                    decoration: InputDecoration(hintText: "Telefone"),
                    keyboardType: TextInputType.phone,

                  ),
                  SizedBox(
                    height: 16.0,
                  ),


                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(fontSize: 18),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Map<String, dynamic> userData = {
                            "name": _nameController.text,
                            "email": _emailController.text,
                            "address": _addressController.text,
                            "neighborhood": _neighborhoodController.text ,
                            "number":_numberController.text ,
                            "phone":_phoneController.text,
                            "city" :"Nova Serrana"
                          };
                          model.singUp(
                            userData: userData,
                            pass: _passController.text,
                            onSuccess: _onSuccess,
                            onFail: _onFail,
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Usuário Criado com sucesso!"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Falha ao criar o cadastro!"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
