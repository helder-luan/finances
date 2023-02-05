import 'package:finances/src/data/models/tipo_cartao_model.dart';
import 'package:finances/src/data/repositories/tipo_cartao_repository.dart';
import 'package:flutter/cupertino.dart';

class TipoCartaoController extends ChangeNotifier {
  final TipoCartaoRepository _tipoCartaoRepository = TipoCartaoRepository();

  set dataSourceTipoCartao(value) => dataSourceTipoCartaoNotifier.value = value;
  List<TipoCartao> get dataSourceTipoCartao => dataSourceTipoCartaoNotifier.value;

  ValueNotifier<List<TipoCartao>> dataSourceTipoCartaoNotifier =
      ValueNotifier(<TipoCartao>[]);

  Future<void> getTiposCartao() async {
    try {
      if (dataSourceTipoCartao.isEmpty) {
        await _tipoCartaoRepository.recoverAll().then((value) {
          dataSourceTipoCartao = value;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}