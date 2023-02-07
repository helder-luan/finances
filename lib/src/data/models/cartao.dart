import 'package:finances/src/data/models/base_model.dart';
import 'dart:convert';

class Cartao extends BaseModel{
  int? idCartao;
  int? idTipoCartao;
  String? nome;
  String? finalCartao;
  int? diaVencimento;
  String? hexCor;

  Cartao({
    this.idCartao,
    this.idTipoCartao,
    this.nome,
    this.finalCartao,
    this.diaVencimento,
    this.hexCor,
  });

  factory Cartao.fromMap(Map<String, dynamic> map) {
    return Cartao(
      idCartao: map['idCartao'],
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
      'idCartao': idCartao,
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
