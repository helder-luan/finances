import 'dart:convert';

import 'package:fingen/src/data/models/base_model.dart';

class Recorrencia extends BaseModel {
  String idLancamento;
  DateTime dataInicio;
  DateTime proximaOcorrencia;
  String periodicidade;
  String situacao;
  DateTime? dataCancelamento;
  DateTime ultimaOcorrencia;
  DateTime? dataCadastro;

  Recorrencia({
    super.id,
    required this.idLancamento,
    required this.dataInicio,
    required this.proximaOcorrencia,
    required this.periodicidade,
    required this.situacao,
    this.dataCancelamento,
    required this.ultimaOcorrencia,
    this.dataCadastro,
  });

  factory Recorrencia.fromMap(Map<String, dynamic> map) => Recorrencia(
    id: map['id'],
    idLancamento: map['idLancamento'],
    dataInicio: map['dataInicio'].toDate(),
    proximaOcorrencia: map['proximaOcorrencia'].toDate(),
    periodicidade: map['periodicidade'],
    situacao: map['situacao'],
    dataCancelamento: map['dataCancelamento']?.toDate(),
    ultimaOcorrencia: map['ultimaOcorrencia'].toDate(),
    dataCadastro: map['dataCadastro']?.toDate(),
  );

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idLancamento': idLancamento,
      'dataInicio': dataInicio.toIso8601String(),
      'proximaOcorrencia': proximaOcorrencia.toIso8601String(),
      'periodicidade': periodicidade,
      'situacao': situacao,
      'dataCancelamento': dataCancelamento?.toIso8601String(),
      'ultimaOcorrencia': ultimaOcorrencia.toIso8601String(),
      'dataCadastro': dataCadastro?.toIso8601String(),
    };
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  bool isValid() {
    return idLancamento.isNotEmpty 
      && periodicidade.isNotEmpty
      && situacao.isNotEmpty;
  }
}