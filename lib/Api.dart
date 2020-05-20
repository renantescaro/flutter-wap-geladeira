import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;
import 'Compra.dart';

class Api{
  final String urlApi = 'http://192.168.1.207';

  Future<List<Compra>> consultarComprasPorUsuario(String email) async{
    dynamic resposta = await getHttp(urlApi+'/?consultar-compras-usuario&email='+email);

    developer.log('teste');

    List respostaJson = json.decode(resposta);
    return respostaJson.map((compra)=>new Compra.fromJson(compra)).toList();
  }

  finalizarCompra(String email,int qtdGeladeira,int qtdCesta) async{
    var dados = jsonEncode({
      'email':email,
      'qtdGeladeira':qtdGeladeira,
      'qtdCesta':qtdCesta
    });

    return postHttp(urlApi+'/?finalizar-compra',dados);
  }

  verificarLogin(String email, String senha) async{
    var dados = jsonEncode({
      'email':email,
      'senha':senha
    });

    return postHttp(urlApi+'/?logar', dados);
  }

  postHttp(String url, String conteudo) async{
    try{
      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: 'param'+'='+conteudo,
        encoding: Encoding.getByName("utf-8"),
      );

      if(response.statusCode == 200){
        return response.body;
      }else{
        return jsonEncode({
        'mensagem':'Erro resposta servidor',
        'sucesso':false
      });
      }
    }catch(e){
      return jsonEncode({
        'mensagem':'Erro ao acessar servidor',
        'sucesso':false
      });
    }
  }

  getHttp(String url) async{
    try{
      final response = await http.get(url,headers: {"Accept": "application/json"});

      if(response.statusCode == 200){
        return response.body;
      }else{
        return jsonEncode({
        'mensagem':'Erro resposta servidor',
        'sucesso':false
      });
      }
    }catch(e){
      return jsonEncode({
        'mensagem':'Erro ao acessar servidor',
        'sucesso':false
      });
    }
  }
}