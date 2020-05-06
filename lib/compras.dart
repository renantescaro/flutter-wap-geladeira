import 'package:flutter/material.dart';
import 'dart:convert';
import 'Api.dart';

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
  
  int _quantidade    = 0;
  int _qtdCesta      = 0;
  int _qtdGeladeira  = 0;
  double _valorTotal = 0;
  double _valorProdutoCesta = 1;
  double _valorProdutoGeladeira = 2;
  String _usuarioLogado = 'renan teste';

  final txtQuantidade = TextEditingController();

  void aumentarQuantidade(){
    setState(() {
      _quantidade++;
      txtQuantidade.text = _quantidade.toString();
    });
  }

  void diminuirQuantidade(){
    setState(() {
      if(_quantidade>0){
        _quantidade--;
        txtQuantidade.text = _quantidade.toString();
      }
    });
  }

  void confirmarQuantidade(String opcaoSelecionada){
    if(opcaoSelecionada=='cesta'){
      setState(() {
        _qtdCesta = _quantidade;
      });
    }else if(opcaoSelecionada=='geladeira'){
      setState(() {
        _qtdGeladeira = _quantidade;
      });
    }
    setState(() {
      _valorTotal = (_qtdCesta*_valorProdutoCesta) + (_qtdGeladeira*_valorProdutoGeladeira);
    });
    zerarquantidadeSelecionada();
  }

  void zerarquantidadeSelecionada(){
    setState(() {
      _quantidade=0;
      txtQuantidade.text = _quantidade.toString();
    });
  }

  finalizarCompra() async{
    Api api = new Api();
    dynamic retorno = await api.finalizarCompra();
    String retornoFormatado = (json.decode(retorno as dynamic)['timestamp']).toString();
    mostrarMensagem(retornoFormatado);
  }

  Future<void> mostrarMensagem(mensagem) async{
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            Text(mensagem)
          ],
        );
      },
    );
  }

  confirmarCompra(){
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 110,
            child: Column(
              children: <Widget>[
                Text('Usuário: $_usuarioLogado\nValor da crompra de R\$ $_valorTotal \nDeseja confirmar?'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[                    
                    RaisedButton(
                      child: Text('Sim', style: TextStyle(fontSize: 15, color: Colors.white)),
                      onPressed:(){
                        Navigator.of(context).pop();
                        finalizarCompra();
                      }
                    ),
                    RaisedButton(
                      child: Text('Não', style: TextStyle(fontSize: 15, color: Colors.white)),
                      onPressed:(){
                        Navigator.of(context).pop();
                      },
                    ),
                  ], 
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  mostrarQuantidade(String opcaoSelecionada){
    return showDialog(
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
              Expanded(  
                child: TextField(
                  controller: txtQuantidade,
                  textAlign: TextAlign.center,
                ),
              ),
              RaisedButton(
                child: Text('+', style: TextStyle(fontSize: 30, color: Colors.white)),
                onPressed: aumentarQuantidade,
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Confirmar"),
              onPressed: () {
                Navigator.of(context).pop();
                confirmarQuantidade(opcaoSelecionada);
              },
            ),
          ],
        );
      },
    );
  }

  void comprar(){

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
                  Column(
                    children: <Widget>[
                      FlatButton(
                      color: Colors.deepOrange,
                      child: Image(
                        image: AssetImage('assets/cesta.png'),
                        height: 100,
                      ),
                      padding: EdgeInsets.all(30),
                      onPressed:()=>mostrarQuantidade('cesta'),
                    ),
                    Text('$_qtdCesta'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      FlatButton(
                        color: Colors.deepOrange,
                        child: Image(
                          image: AssetImage('assets/geladeira.png'),
                          height: 100,
                        ),
                        padding: EdgeInsets.all(30),
                        onPressed:()=>mostrarQuantidade('geladeira'),
                      ),
                      Text('$_qtdGeladeira')
                    ],
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
                onPressed: confirmarCompra,
              ),
            ),
          ],
        ),
      ),
    );
  }
}