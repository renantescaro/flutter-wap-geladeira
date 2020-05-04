import 'package:flutter/material.dart';

class Compras extends StatelessWidget{
  
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Compras',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: ComprasPage(title:'Compras'),
    );
  }
}

class ComprasPage extends StatefulWidget {
  ComprasPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ComprasPageState createState() => _ComprasPageState();
}

class _ComprasPageState extends State<ComprasPage> {
  
  int _quantidade = 0;

  void aumentarQuantidade(){
    setState(() {
      _quantidade++;
    });
  }

  void diminuirQuantidade(){
    setState(() {
      _quantidade--;
    });
  }

  _mostrarQuantidade() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Selecione a quantidade"),
          content: Row(
            children: <Widget>[
              RaisedButton(
                child: Text('-', style: TextStyle(fontSize: 30, color: Colors.white)),
                onPressed: diminuirQuantidade,
              ),
              Text(
                '$_quantidade',
              ),
              RaisedButton(
                child: Text('+', style: TextStyle(fontSize: 30, color: Colors.white)),
                onPressed: aumentarQuantidade,
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _comprar(){

  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 180),
              child: Text(
                'Selecione o local da compra',
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 25
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    color: Colors.deepOrange,
                    child: Image(
                      image: AssetImage('assets/cesta.png'),
                      height: 100,
                    ),
                    padding: EdgeInsets.all(30),
                    onPressed: _mostrarQuantidade,
                  ),
                  FlatButton(
                    color: Colors.deepOrange,
                    child: Image(
                      image: AssetImage('assets/geladeira.png'),
                      height: 100,
                    ),
                    padding: EdgeInsets.all(30),
                    onPressed: _mostrarQuantidade,
                  ),
                ]
              ) 
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: RaisedButton(
                color: Colors.deepOrange,
                child: Text('Confirmar',
                  style: TextStyle(color: Colors.white)
                ),
                padding: EdgeInsets.all(30),
                onPressed: _comprar,
              ),
            ),
          ],
        ),
      ),
    );
  }
}