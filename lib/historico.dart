import 'package:flutter/material.dart';
import 'Compra.dart';
import 'Api.dart';

class Historico extends StatelessWidget{

  ListTile _tile(String data, String qtdCesta, String qtdGeladeira) => ListTile(
    title: Text(data,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    subtitle: Text('Qtd Cesta: '+qtdCesta+', Qtd Geladeira: '+qtdGeladeira),
    leading: Icon(
      Icons.work,
      color: Colors.blue[500],
    ),
  );

  ListView compraListView(data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _tile(
          data[index].data,
          data[index].quantidadeCesta.toString(),
          data[index].quantidadeGeladeira.toString()
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {

      Api api = new Api();

      return MaterialApp(
        title: 'Histórico de Compras',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: Material(
          child: FutureBuilder<List<Compra>>(
          future: api.consultarComprasPorUsuario('renan.tescaro@wapstore.com.br'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Compra> data = snapshot.data;
              return compraListView(data);
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}