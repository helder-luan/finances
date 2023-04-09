import 'package:finances/src/data/repositories/cartao_repository.dart';
import 'package:flutter/cupertino.dart';

import 'package:finances/src/data/models/cartao.dart';

class CartaoController extends ChangeNotifier {
  final CartaoRepository _cartaoRepository = CartaoRepository();

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
      diaFechamentoController.text = _current!.diaFechamento!.toString();
      hexCorController.text = _current!.hexCor!;
    }
  }

  final TextEditingController idTipoCartaoController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController finalCartaoController = TextEditingController();
  final TextEditingController diaVencimentoController = TextEditingController();
  final TextEditingController diaFechamentoController = TextEditingController();
  final TextEditingController hexCorController = TextEditingController();

  Future<Map<String, Object>> validar() async {
    if (nomeController.text.trim().isEmpty) {
      return {
        'isValid': false,
        'message': 'Nome não informado!',
      };
    }

    if (diaVencimentoController.text.trim().isNotEmpty && int.tryParse(diaVencimentoController.text.trim())! > 31) {
      return {
        'isValid': false,
        'message': 'Dia de vencimento inválido!',
      };
    }

    if (diaFechamentoController.text.trim().isNotEmpty && int.tryParse(diaFechamentoController.text.trim())! > 31) {
      return {
        'isValid': false,
        'message': 'Dia de fechamento inválido!',
      };
    }

    if (idTipoCartaoController.text.trim().isEmpty) {
      return {
        'isValid': false,
        'message': 'Tipo de cartão não informado!',
      };
    }

    return {
      'isValid': true,
      'message': 'OK'
    };
  }

  void handleSubmit({
    required VoidCallback? Function() onSuccess,
    required VoidCallback? Function(String motivo) onFailure
  }) async {
    try {
      Map validation = await validar();

      if (!validation['isValid']) {
        onFailure(validation['message']);
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

        await _cartaoRepository.insert(cartao);
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
        
        await _cartaoRepository.update(cartao);
      }

      onSuccess();
    }
    catch (e) {
      onFailure(e.toString());
    }
  }

  void deletarCartao(String id, {
    required VoidCallback? Function() onSuccess,
    required VoidCallback? Function(String motivo) onFailure
  }) async {
    try {
      await _cartaoRepository.delete(id);

      onSuccess();
    }
    catch (e) {
      onFailure(e.toString());
    }
  }

  Future<void> atualizarDados() async {
    try {
      if (dataSourceCartao.isEmpty) {
        await _cartaoRepository.recoverAll().then((value) {
          dataSourceCartao = value;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}