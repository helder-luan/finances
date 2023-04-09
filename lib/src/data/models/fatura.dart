import 'dart:convert';

import 'package:finances/src/data/models/base_model.dart';

class Fatura extends BaseModel {
  int? idFatura;
  int? idCartao;
  int? mesReferencia;
  String? dataFechamento;
  String? dataVencimento;
  String? dataPagamento;
  double? valorTotal;

  Fatura({
    this.idFatura,
    this.idCartao,
    this.mesReferencia,
    this.dataFechamento,
    this.dataVencimento,
    this.dataPagamento,
    this.valorTotal,
  });

  factory Fatura.fromMap(Map<String, dynamic> map) {
    return Fatura(
      idFatura: map['idFatura'],
      idCartao: map['idCartao'],
      mesReferencia: map['mesReferencia'],
      dataFechamento: map['dataFechamento'],
      dataVencimento: map['dataVencimento'],
      dataPagamento: map['dataPagamento'],
      valorTotal: map['valorTotal'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'idFatura': idFatura,
      'idCartao': idCartao,
      'mesReferencia': mesReferencia,
      'dataFechamento': dataFechamento,
      'dataVencimento': dataVencimento,
      'dataPagamento': dataPagamento,
      'valorTotal': valorTotal,
    };
  }

  @override
  String toJson() => json.encode(toMap());

  factory Fatura.fromJson(String source) => Fatura.fromMap(json.decode(source));

  @override
  bool isValid() {
    return 
    idCartao != null
    && mesReferencia != null;
  }
}