import 'dart:convert';

import 'package:fingen/src/data/models/base_model.dart';

class Parcelamento extends BaseModel {
  String idLancamento;
  int numeroParcela;
  double valorParcela;
  DateTime dataVencimento;
  DateTime? dataCadastro;

  Parcelamento({
    super.id,
    required this.idLancamento,
    required this.numeroParcela,
    required this.valorParcela,
    required this.dataVencimento,
    this.dataCadastro,
  });

  factory Parcelamento.fromMap(Map<String, dynamic> map) => Parcelamento(
    id: map['id'],
    idLancamento: map['idLancamento'],
    numeroParcela: map['numeroParcela'],
    valorParcela: map['valorParcela'],
    dataVencimento: map['dataVencimento'].toDate(),
    dataCadastro: map['dataCadastro']?.toDate()
  );

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idLancamento': idLancamento,
      'numeroParcela': numeroParcela,
      'valorParcela': valorParcela,
      'dataVencimento': dataVencimento.toIso8601String(),
      'dataCadastro': dataCadastro?.toIso8601String(),
    };
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  bool isValid() {
    return idLancamento.isNotEmpty
      && numeroParcela > 0
      && valorParcela > 0;
  }
}