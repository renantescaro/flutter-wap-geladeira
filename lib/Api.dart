import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;

class Api{
  final String urlApi = 'http://192.168.1.201';

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
        return false;
      }
    }catch(e){
      return jsonEncode({
        'mensagem':'Erro ao acessar servidor',
        'sucesso':false
      });
    }
  }
}