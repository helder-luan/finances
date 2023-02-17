import 'package:finances/src/data/models/base_model.dart';
import 'dart:convert';

class Transacao extends BaseModel{
  int? idTransacao;
  String? descricao;
  String? valor;
  String? detalhes;
  String? dataCadastro;
  int? idTipoOperacao;
  int? mesReferencia;
  int? reembolso; // boolean - 0 => false | 1 => true
  int? idCartao;
  int? gastoMensal; // boolean - 0 => false | 1 => true
  int? parcelado; // boolean - 0 => false | 1 => true
  int? totalParcelas;
  int? parcelaAtual;

  Transacao({
    this.idTransacao,
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
  });

  factory Transacao.fromMap(Map<String, dynamic> map) {
    return Transacao(
      idTransacao: map['idTransacao'],
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
      'idTransacao': idTransacao,
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
