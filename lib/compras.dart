import 'package:flutter/material.dart';
import 'package:ola_mundo/comprarNovamente.dart';
import 'dart:convert';
import 'Api.dart';
import 'historico.dart';

class Compras extends StatelessWidget{
  
  Compras({this.email});
  final String email;

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Compras',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: ComprasPage(title:'Compras', email:email),
    );
  }
}

class ComprasPage extends StatefulWidget {
  ComprasPage({Key key, this.title, this.email}) : super(key: key);

  final String title;
  final String email;

  @override
  _ComprasPageState createState() => _ComprasPageState(email:email);
}

class _ComprasPageState extends State<ComprasPage> {
  
  _ComprasPageState({this.email}){
    if(email.length > 0){
      _usuarioLogado = email.split("@")[0];
    }
    txtQuantidade.text = '0';
  }

  String email;

  int _quantidade    = 0;
  int _qtdCesta      = 0;
  int _qtdGeladeira  = 0;
  double _valorTotal = 0;
  double _valorProdutoCesta = 1;
  double _valorProdutoGeladeira = 2;
  String _usuarioLogado = '';

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
    dynamic retorno = await api.finalizarCompra(email,_qtdGeladeira,_qtdCesta);

    bool   sucesso  = (json.decode(retorno as dynamic)['sucesso']);
    String mensagem = (json.decode(retorno as dynamic)['mensagem']).toString();

    if(sucesso){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ComprarNovamente()),
      );
    }else{
      mostrarMensagem(mensagem);
    }
  }

  Future<void> mostrarMensagem(mensagem) async{
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            Text(mensagem, textAlign: TextAlign.left)
          ],
        );
      },
    );
  }

  mostrarMensagemCompra(){
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 110,
            child: Column(
              children: <Widget>[
                Text('Usuário: $_usuarioLogado\nValor da compra de R\$ $_valorTotal \nDeseja confirmar?'),
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

  confirmarCompra(){
    if(_qtdCesta == 0 && _qtdGeladeira == 0){
      mostrarMensagem('Selecione a quantidade!\nClique no ícone da Cesta ou da Geladeira');
    }else{
      mostrarMensagemCompra();
    }
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

  abrirHistoricoCompra(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Historico()),
      );
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child:Text('Histórico',style: TextStyle(color: Colors.white)),
              onPressed: abrirHistoricoCompra,
              color: Colors.deepOrange,
            ),
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