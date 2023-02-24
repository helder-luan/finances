import 'package:finances/src/data/repositories/cartao_repository.dart';
import 'package:flutter/cupertino.dart';

import 'package:finances/src/data/models/cartao.dart';

class CartaoController extends ChangeNotifier {
  final CartaoRepository _repository = CartaoRepository();

  Cartao? _current;

  Cartao? get current => _current;

  // todos os cartões
  set dataSourceCartao(value) => dataSourceCartaoNotifier.value = value;
  List<Cartao> get dataSourceCartao => dataSourceCartaoNotifier.value;

  ValueNotifier<List<Cartao>> dataSourceCartaoNotifier =
      ValueNotifier(<Cartao>[]);


  set current(value) {
    _current = value;
    if (_current != null) {
      idTipoCartaoController.text = _current!.idTipoCartao!.toString();
      nomeController.text = _current!.nome!;
      finalCartaoController.text = _current!.finalCartao!;
      diaVencimentoController.text = _current!.diaVencimento!.toString();
      diaFechamentoController.text = _current!.diaVencimento!.toString();
      hexCorController.text = _current!.hexCor!;
    }
  }

  final TextEditingController idTipoCartaoController = TextEditingController(text: '');
  final TextEditingController nomeController = TextEditingController(text: '');
  final TextEditingController finalCartaoController = TextEditingController(text: '');
  final TextEditingController diaVencimentoController = TextEditingController(text: '');
  final TextEditingController diaFechamentoController = TextEditingController(text: '');
  final TextEditingController hexCorController = TextEditingController(text: '');

  Future<List<Object>?> validar() async {
    if (nomeController.text.trim().isEmpty) {
      return [
        false,
        'Nome não informado!',
      ];
    }

    if (diaVencimentoController.text.trim().isNotEmpty && (int.tryParse(diaVencimentoController.text.trim())! > 31 || int.tryParse(diaFechamentoController.text.trim())! > 31)) {
      return [
        false,
        'Dia de vencimento inválido!',
      ];
    }

    if (idTipoCartaoController.text.trim().isEmpty) {
      return [
        false,
        'Tipo de cartão não informado!',
      ];
    }

    return null;
  }

  void handleSubmit({
    required VoidCallback? Function() onSuccess,
    required VoidCallback? Function(String motivo) onFailure
  }) async {
    try {
      List<Object>? validation = await validar();

      if (validation != null) {
        onFailure(validation[1].toString());
        return;
      }

      if (current == null) {
        var cartao = Cartao(
          idTipoCartao: int.tryParse(idTipoCartaoController.text),
          nome: nomeController.text,
          finalCartao: finalCartaoController.text,
          diaVencimento: int.tryParse(diaVencimentoController.text),
          diaFechamento: int.tryParse(diaFechamentoController.text),
          hexCor: hexCorController.text,
        );

        await _repository.insert(cartao);
      } else {
        var cartao = Cartao(
          idCartao: current!.idCartao,
          idTipoCartao: int.tryParse(idTipoCartaoController.text),
          nome: nomeController.text,
          finalCartao: finalCartaoController.text,
          diaVencimento: int.tryParse(diaVencimentoController.text),
          diaFechamento: int.tryParse(diaFechamentoController.text),
          hexCor: hexCorController.text,
        );
        
        await _repository.update(cartao);
      }

      onSuccess();
    }
    catch (e) {
      onFailure(e.toString());
    }
  }

  void deleteCard(String id, {
    required VoidCallback? Function() onSuccess,
    required VoidCallback? Function(String motivo) onFailure
  }) async {
    try {
      await _repository.delete(id);

      onSuccess();
    }
    catch (e) {
      onFailure(e.toString());
    }
  }

  Future<void> atualizarDados() async {
    try {
      if (dataSourceCartao.isEmpty) {
        await _repository.recoverAll().then((value) {
          dataSourceCartao = value;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}