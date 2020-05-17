import 'package:flutter/material.dart';
import 'package:ola_mundo/main.dart';

class ComprarNovamente extends StatelessWidget{  

  @override
  Widget build(BuildContext context){
    
    comprarNovamente(){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    }

    return MaterialApp(
      title: 'Comprar Novamente',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Comprar Novamente'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Bom Apetite!',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.deepOrange
                    )
                  ),
                ],
              ),
            ),
            Image(
              image: AssetImage('assets/comendo.png'),
              height: 150,
            ),
            RaisedButton(
              color: Colors.deepOrange,
              child: Container(
                margin: const EdgeInsets.only(top:15.0),
                height: 40,
                width: 160,
                child: Text(
                  'Comprar Novamente',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  )
                )
              ), 
              onPressed: comprarNovamente,
            ),
          ],
        ),
      ),
    );
  }
}
