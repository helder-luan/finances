import 'package:finances/src/data/models/fatura.dart';
import 'package:finances/src/data/repositories/fatura_repository.dart';
import 'package:flutter/cupertino.dart';

class FaturaController extends ChangeNotifier {
  final FaturaRepository _faturaRepository = FaturaRepository();

  Future<Fatura?> verificaSeExisteFaturaMesAtualDoCartao(String idCartao, String mesReferencia) async {
    var fatura = await _faturaRepository.recoverByCardIdAndRefMonth(idCartao, mesReferencia);

    return fatura;
  }

  Future<void> atualizaValorTotalFatura(String idCartao, String mesReferencia, String valorTotal) async {
    await _faturaRepository.updateByCardIdAndRefMonth(idCartao, mesReferencia, valorTotal);
  }

  Future<Fatura?> recuperaFaturaDoCartao(String idCartao) async {
    var fatura = await _faturaRepository.recoverByCardId(idCartao);

    return fatura;
  }

  Future<void> criarFatura(Fatura fatura) async {
    await _faturaRepository.insert(fatura);
  }
}