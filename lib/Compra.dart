class Compra{

  final String email;
  final int quantidadeCesta;
  final int quantidadeGeladeira;
  final String data;

  Compra({this.email, this.quantidadeCesta, this.quantidadeGeladeira,this.data});

  factory Compra.fromJson(Map<String,dynamic> json){
    return Compra(
      email: json['email'],
      quantidadeCesta: int.parse(json['qtd_cesta']),
      quantidadeGeladeira: int.parse(json['qtd_geladeira']),
      data: json['data'].toString()
    );
  }
}