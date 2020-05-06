import 'package:http/http.dart' as http;
import 'dart:convert';

class Api{

  finalizarCompra() async{
    String url = 'http://armariosinteligentes.com/api/v3/timestamp';
    return getHttp(url);
  }

  getHttp(String url) async{
    final response = await http.get(url);
  
    if(response.statusCode == 200){
      return response.body;
    }else{
      return null;
    }
  }
}