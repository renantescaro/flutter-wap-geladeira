import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'Compra.dart';
import 'Api.dart';

class Historico extends StatelessWidget{

  String email='';

  Historico(this.email);

  ListTile _tile(String data, String qtdCesta, String qtdGeladeira) => 
    ListTile(
      title: Text(
        data,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )
      ),
      subtitle: Text('Qtd Cesta: '+qtdCesta+', Qtd Geladeira: '+qtdGeladeira),
  );

  ListView compraListView(data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _tile(
          converterData(data[index].data),
          data[index].quantidadeCesta.toString(),
          data[index].quantidadeGeladeira.toString()
        );
      }
    );
  }

  converterData(String dataStr){
     DateTime data = DateTime.parse(dataStr);
    return (formatDate(data, [dd,'/',mm,'/',yyyy,' ',HH,':',nn,':',ss]));
  }

  @override
  Widget build(BuildContext context) {

    Api api = new Api();

    return MaterialApp(
      title: 'Histórico de Compras',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Histórico de Compras'),
        ),
        body: Container(
          child: FutureBuilder<List<Compra>>(
            future: api.consultarComprasPorUsuario(email),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Compra> data = snapshot.data;
                return compraListView(data);
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}