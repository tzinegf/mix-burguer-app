import 'package:flutter/material.dart';
import 'package:mix_burguer_app/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'singup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          actionsIconTheme: IconThemeData(color: Colors.green),
          title: Text("MIX BURGUER"),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              child: Text(
                "CRIAR CONTA",
                style: TextStyle(fontSize: 15.0),
              ),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SingUpScreen()));
              },
            ),
          ],
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
                  SizedBox(
                    height: 25.0,
                  ),
                  Container(
                    height: 200.0,
                    child: Image.asset(
                      'assets/logo.png',
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),

                  TextFormField(
                    controller: _emailController,
                    validator: (text) {
                      if (text.isEmpty || !text.contains("@")) {
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        if (_emailController.text.isEmpty)
                          _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Informe seu e-mail para recuperar sua senha!"),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        else {
                          if(_emailController.text.contains("@") && _emailController.text.contains(".")){
                            model.recoverPass(_emailController.text);
                            _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text("Confira sua caixa de e-mail"),
                                backgroundColor: Colors.blue,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }else{
                            _scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text("E-mail invalido!"),
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 2),
                                )
                            );
                          }
                        }
                      },
                      child: Text(
                        "Esqueci minha senha",
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      child: Text(
                        "Entrar",
                        style: TextStyle(fontSize: 18),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {

                        if (_formKey.currentState.validate()) {}
                        model.singIn(
                            email: _emailController.text,
                            pass: _passController.text,
                            onSuccess: _onSuccess,
                            onFail: _onFail);
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
    Navigator.of(context).pop();
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Falha ao entrar!"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
