import 'package:finances/src/data/models/base_model.dart';
import 'dart:convert';

class Cartao extends BaseModel{
  int? idTipoCartao;
  String? nome;
  String? finalCartao;
  int? diaVencimento;
  String? hexCor;

  Cartao({
    String? id,
    this.idTipoCartao,
    this.nome,
    this.finalCartao,
    this.diaVencimento,
    this.hexCor,
  }) : super(id: id);

  factory Cartao.fromMap(Map<String, dynamic> map) {
    return Cartao(
      id: map['id'],
      idTipoCartao: map['idTipoCartao'],
      nome: map['nome'],
      finalCartao: map['finalCartao'],
      diaVencimento: map['diaVencimento'],
      hexCor: map['hexCor'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idTipoCartao': idTipoCartao,
      'nome': nome,
      'finalCartao': finalCartao,
      'diaVencimento': diaVencimento,
      'hexCor': hexCor,
    };
  }

  @override
  String toJson() => json.encode(toMap());

  factory Cartao.fromJson(String source) => Cartao.fromMap(json.decode(source));

  @override
  bool isValid() {
    return
    nome != null &&
    diaVencimento != null &&
    hexCor != null &&
    idTipoCartao != null;
  }
}
