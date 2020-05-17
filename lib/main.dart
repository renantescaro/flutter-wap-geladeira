import 'package:flutter/material.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:flutter/services.dart';
import 'compras.dart';
import 'Api.dart';
import 'dart:convert';
import 'dart:developer' as developer;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wap Geladeira',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'Wap Geladeira'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final txtEmail = TextEditingController();
  final txtSenha = TextEditingController();

  void validarLogin() async{
    if(txtEmail.text == '' || txtSenha.text == ''){
      mostrarMensagem("Email e Senha devem ser preenchidos!");
    }else{
      Api api = new Api();
      dynamic retorno = await api.verificarLogin(txtEmail.text, txtSenha.text);

      String mensagem = (json.decode(retorno as dynamic)['mensagem']);
      bool   sucesso  = (json.decode(retorno as dynamic)['sucesso']);

      if(sucesso){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Compras(email:txtEmail.text)),
        );
      }else{
        mostrarMensagem(mensagem);
      }
    }
  }

  Future mostrarMensagem(String mensagem){
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(mensagem),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('assets/logo.png'),
              height: 100,
            ),
            Container(
              padding: EdgeInsets.only(top:10,bottom: 10, right: 20, left:20),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: txtEmail,
                    decoration: InputDecoration(
                      hintText: 'Email'
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  PasswordField(
                    controller: txtSenha,
                    hintText: 'Senha',
                  ),
                ]
              ),
            ),
            RaisedButton(
              onPressed: validarLogin,
              color: Colors.deepOrange,
              child: Text('Fazer Login', style: TextStyle(color: Colors.white)),
              padding: EdgeInsets.only(left: 125, right: 125),
            ),
          ],
        ),
      ),
    );
  }
}
