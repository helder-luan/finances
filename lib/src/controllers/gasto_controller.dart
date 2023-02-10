
import 'package:finances/src/data/models/cartao.dart';
import 'package:finances/src/data/models/transacao.dart';
import 'package:finances/src/data/repositories/cartao_repository.dart';
import 'package:finances/src/data/repositories/transacao_repository.dart';
import 'package:flutter/cupertino.dart';

class GastoController extends ChangeNotifier {
  
  set dataSourceTransacao(value) => dataSourceTransacaoNotifier.value = value;
  List<Transacao> get dataSourceTransacao => dataSourceTransacaoNotifier.value;

  ValueNotifier<List<Transacao>> dataSourceTransacaoNotifier =
      ValueNotifier(<Transacao>[]);

  final TransacaoRepository _transacaoRepository = TransacaoRepository();
  final CartaoRepository _cartaoRepository = CartaoRepository();
  
  // common
  final TextEditingController formaDePagamento = TextEditingController();
  final TextEditingController descricao = TextEditingController();
  final TextEditingController valor = TextEditingController();
  final TextEditingController detalhes = TextEditingController();

  // entry
  final TextEditingController idTipoOperacao = TextEditingController();
  final TextEditingController reembolso = TextEditingController();

  // common out and entry
  final TextEditingController idCartao = TextEditingController();

  // out
  final TextEditingController gastoMensal = TextEditingController();
  final TextEditingController parcelado = TextEditingController();
  final TextEditingController totalParcelas = TextEditingController();
  final TextEditingController parcelaAtual = TextEditingController();

  Future<List<Object>?> validarOperacaoEntrada() async {
    if (descricao.text.trim().isEmpty) {
      return [
        false,
        'Descrição não informada!',
      ];
    }

    if (valor.text.trim().isEmpty) {
      return [
        false,
        'Valor não informado!',
      ];
    }

    if (reembolso.text.trim() == 'true') {
      if (idCartao.text.trim().isEmpty) {
        return [
          false,
          'Cartão não informado!',
        ];
      }
    }

    return null;
  }

  Future<List<Object>?> validarOperacaoSaida() async {
    if (formaDePagamento.text.trim() == '0') {
      return [
        false,
        'Forma de pagamento não informada!',
      ];
    }

    if (formaDePagamento.text.trim() == 'M') {
      if (descricao.text.trim().isEmpty) {
        return [
          false,
          'Descrição não informada!',
        ];
      }

      if (valor.text.trim().isEmpty) {
        return [
          false,
          'Valor não informado!',
        ];
      }
    }

    // credit payment
    if (formaDePagamento.text.trim() == 'C') {
      if (idCartao.text.trim().isEmpty) {
        return [
          false,
          'Cartão não informado!',
        ];
      }

      if (descricao.text.trim().isEmpty) {
        return [
          false,
          'Descrição não informada!',
        ];
      }

      if (valor.text.trim().isEmpty) {
        return [
          false,
          'Valor não informado!',
        ];
      }

      if (parcelado.text.trim() == 'true') {
        if (totalParcelas.text.trim().isEmpty) {
          return [
            false,
            'Total de parcelas não informado!',
          ];
        }

        if (parcelaAtual.text.trim().isEmpty) {
          return [
            false,
            'Parcela atual não informada!',
          ];
        }
      }
    }


    // debit payment
    if (formaDePagamento.text.trim() == 'D') {
      if (idCartao.text.trim().isEmpty) {
        return [
          false,
          'Cartão não informado!',
        ];
      }

      if (descricao.text.trim().isEmpty) {
        return [
          false,
          'Descrição não informada!',
        ];
      }

      if (valor.text.trim().isEmpty) {
        return [
          false,
          'Valor não informado!',
        ];
      }
    }
    
    return null;
  }

  // verifica em qual mes deve ser lancado a transacao com base no dia de vencimento do cartao
  Future<int> getMesParaLacamento() async {
    int mes = DateTime.now().month;
    int diaFechamento = 0;

    if (idCartao.text.trim().isNotEmpty) {
      Cartao cartao = await _cartaoRepository.recover(idCartao.text.trim());
      
      if ((int.tryParse(cartao.diaVencimento.toString())! - 7) > 0) {
        diaFechamento = int.tryParse(cartao.diaVencimento.toString())! - 7;
      } else {
        diaFechamento = int.tryParse(cartao.diaVencimento.toString())! + 23;
      }

      if (diaFechamento <= DateTime.now().day) {
        mes = DateTime.now().month + 1;
      }
    }

    return mes;
  }


  void handleSubmitEntry({
    required VoidCallback? Function() onSuccess,
    required VoidCallback? Function(String motivo) onFailure
  }) async {
    try {
      List<Object>? validacao = await validarOperacaoEntrada();

      if (validacao != null) {
        onFailure(validacao[1].toString());
        return;
      }

      int mesReferencia = await getMesParaLacamento();
      String valorFormatado = valor.text.replaceAll("R\$ ", "").replaceAll(",", ".").replaceAll(".", "");

      await _transacaoRepository.insert(
        Transacao(
          descricao: descricao.text.trim(),
          valor: valorFormatado,
          detalhes: detalhes.text.trim(),
          dataCadastro: DateTime.now().toString(),
          idTipoOperacao: int.tryParse(idTipoOperacao.text.trim()),
          mesReferencia: mesReferencia,
          reembolso: reembolso.text.trim() == 'true' ? true : false,
          idCartao: int.tryParse(idCartao.text.trim()),
          gastoMensal: false,
          parcelado: false,
          totalParcelas: 0,
          parcelaAtual: 0
        )
      );
      onSuccess();
    }
    catch (e) {
      onFailure(e.toString());
    }
  }

  void handleSubmitOut({
    required VoidCallback? Function() onSuccess,
    required VoidCallback? Function(String motivo) onFailure
  }) async {
    try {
      List<Object>? validacao = await validarOperacaoSaida();

      if (validacao != null) {
        onFailure(validacao[1].toString());
        return;
      }

      int mesReferencia = await getMesParaLacamento();
      String valorFormatado = valor.text.replaceAll("R\$ ", "").replaceAll(",", ".").replaceAll(".", "");

      await _transacaoRepository.insert(
        Transacao(
          descricao: descricao.text.trim(),
          valor: valorFormatado,
          detalhes: detalhes.text.trim(),
          dataCadastro: DateTime.now().toString(),
          idTipoOperacao: int.tryParse(idTipoOperacao.text.trim()),
          mesReferencia: mesReferencia,
          reembolso: reembolso.text.trim() == 'true' ? true : false,
          idCartao: int.tryParse(idCartao.text.trim()),
          gastoMensal: gastoMensal.text.trim() == 'true' ? true : false,
          parcelado: parcelado.text.trim() == 'true' ? true : false,
          totalParcelas: int.tryParse(totalParcelas.text.trim()),
          parcelaAtual: int.tryParse(parcelaAtual.text.trim())
        )
      );
      onSuccess();
    }
    catch (e) {
      onFailure(e.toString());
    }
  }

  Future<List<Map<String, dynamic>>> getTransacoesMesAtual() async {
    DateTime dataInicio = DateTime(DateTime.now().year, DateTime.now().month, 1);
    DateTime dataFim = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);

    return await _transacaoRepository.recoverAllByDateRange(
      dataInicio.toString(),
      dataFim.toString()
    );
  }

  Future<List<Map<String, dynamic>>> getTransacoesMesAtualECartao() async {

    return await _transacaoRepository.recoverAllByDateAndCard(
      DateTime.now().month.toString(),
      idCartao.text.trim()
    );
  }

  Future<List<Transacao>> getTransacoes() async {
    try {
      if (dataSourceTransacao.isEmpty) {
        await _transacaoRepository.recoverAll().then((value) {
          return value;
        });
      }
    } catch (e) {
      print(e);
    }
    return dataSourceTransacao;
  }
}