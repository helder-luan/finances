import 'package:finances/src/data/models/tipo_operacao_model.dart';
import 'package:finances/src/data/repositories/tipo_operacao_repository.dart';
import 'package:flutter/cupertino.dart';

class TipoOperacaoController extends ChangeNotifier {
  final TipoOperacaoRepository _tipoOperacaoRepository = TipoOperacaoRepository();

  set dataSourceTipoOperacao(value) => dataSourceTipoOperacaoNotifier.value = value;
  List<TipoOperacao> get dataSourceTipoOperacao => dataSourceTipoOperacaoNotifier.value;

  ValueNotifier<List<TipoOperacao>> dataSourceTipoOperacaoNotifier =
      ValueNotifier(<TipoOperacao>[]);

  Future<void> getTiposOperacao() async {
    try {
      if (dataSourceTipoOperacao.isEmpty) {
        await _tipoOperacaoRepository.recoverAll().then((value) {
          dataSourceTipoOperacao = value;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}