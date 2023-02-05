import 'package:finances/src/data/models/base_model.dart';
import 'dart:convert';

class Transacao extends BaseModel{
  String? descricao;
  String? valor;
  String? detalhes;
  DateTime? dataCadastro;
  int? idTipoOperacao;
  int? mesReferencia;
  bool? reembolso;
  int? idCartao;
  bool? gastoMensal;
  bool? parcelado;
  int? totalParcelas;
  int? parcelaAtual;

  Transacao({
    String? id,
    this.descricao,
    this.valor,
    this.detalhes,
    this.dataCadastro,
    this.idTipoOperacao,
    this.mesReferencia,
    this.reembolso,
    this.idCartao,
    this.gastoMensal,
    this.parcelado,
    this.totalParcelas,
    this.parcelaAtual,
  }) : super(id: id);

  factory Transacao.fromMap(Map<String, dynamic> map) {
    return Transacao(
      id: map['id'],
      descricao: map['descricao'],
      valor: map['valor'],
      detalhes: map['detalhes'],
      dataCadastro: map['dataCadastro'],
      idTipoOperacao: map['idTipoOperacao'],
      mesReferencia: map['mesReferencia'],
      reembolso: map['reembolso'],
      idCartao: map['idCartao'],
      gastoMensal: map['gastoMensal'],
      parcelado: map['parcelado'],
      totalParcelas: map['totalParcelas'],
      parcelaAtual: map['parcelaAtual'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descricao': descricao,
      'valor': valor,
      'detalhes': detalhes,
      'dataCadastro': dataCadastro,
      'idTipoOperacao': idTipoOperacao,
      'mesReferencia': mesReferencia,
      'reembolso': reembolso,
      'idCartao': idCartao,
      'gastoMensal': gastoMensal,
      'parcelado': parcelado,
      'totalParcelas': totalParcelas,
      'parcelaAtual': parcelaAtual,
    };
  }

  @override
  String toJson() => json.encode(toMap());

  factory Transacao.fromJson(String source) => Transacao.fromMap(json.decode(source));

  @override
  bool isValid() {
    return
    descricao != null &&
    valor != null &&
    detalhes != null &&
    idTipoOperacao != null;
  }
}
