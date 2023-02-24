
import 'package:finances/src/data/models/cartao.dart';
import 'package:finances/src/data/models/transacao.dart';
import 'package:finances/src/data/repositories/cartao_repository.dart';
import 'package:finances/src/data/repositories/fatura_repository.dart';
import 'package:finances/src/data/repositories/transacao_repository.dart';
import 'package:flutter/cupertino.dart';

class GastoController extends ChangeNotifier {
  
  set dataSourceTransacao(value) => dataSourceTransacaoNotifier.value = value;
  List<Transacao> get dataSourceTransacao => dataSourceTransacaoNotifier.value;

  ValueNotifier<List<Transacao>> dataSourceTransacaoNotifier =
      ValueNotifier(<Transacao>[]);

  final TransacaoRepository _transacaoRepository = TransacaoRepository();
  final CartaoRepository _cartaoRepository = CartaoRepository();
  final FaturaRepository _faturaRepository = FaturaRepository();
  
  // common
  final TextEditingController formaDePagamento = TextEditingController(text: '');
  final TextEditingController descricao = TextEditingController(text: '');
  final TextEditingController valor = TextEditingController(text: '');
  final TextEditingController detalhes = TextEditingController(text: '');

  // entry
  final TextEditingController idTipoOperacao = TextEditingController(text: '');
  final TextEditingController reembolso = TextEditingController(text: '');

  // common out and entry
  final TextEditingController idCartao = TextEditingController(text: '');

  // out
  final TextEditingController gastoMensal = TextEditingController(text: '');
  final TextEditingController parcelado = TextEditingController(text: '');
  final TextEditingController totalParcelas = TextEditingController(text: '');
  final TextEditingController parcelaAtual = TextEditingController(text: '');

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
      
      if ((int.tryParse(cartao.diaVencimento.toString())! - 10) > 0) {
        diaFechamento = int.tryParse(cartao.diaVencimento.toString())! - 10;
      } else {
        diaFechamento = int.tryParse(cartao.diaVencimento.toString())! + 20;
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
          reembolso: reembolso.text.trim() == 'true' ? 1 : 0,
          idCartao: int.tryParse(idCartao.text.trim()),
          gastoMensal: 0,
          parcelado: 0,
          totalParcelas: 0,
          parcelaAtual: 0
        )
      );

      // await _faturaRepository.recoverByCardIdAndRefMonth(
      //   idCartao.text.trim(),
      //   mesReferencia.toString()
      // ).then((fatura) async {
      //   if (fatura != null) {
      //     await _faturaRepository.update(
      //       Fatura(
      //         id: fatura.id,
      //         idCartao: fatura.idCartao,
      //         mesReferencia: fatura.mesReferencia,
      //         dataFechamento: fatura.dataFechamento,
      //         dataVencimento: fatura.dataVencimento,
      //         valorFatura: (double.tryParse(fatura.valorFatura.toString())! + double.tryParse(valorFormatado)).toString(),
      //         valorPago: fatura.valorPago,
      //         valorMinimo: fatura.valorMinimo,
      //         valorParcela: fatura.valorParcela,
      //         totalParcelas: fatura.totalParcelas,
      //         parcelaAtual: fatura.parcelaAtual,
      //         dataPagamento: fatura.dataPagamento,
      //         dataCadastro: fatura.dataCadastro,
      //         dataAtualizacao: DateTime.now().toString()
      //       )
      //     );
      //   } else {
      //     await _faturaRepository.insert(
      //       Fatura(
      //         idCartao: int.tryParse(idCartao.text.trim()),
      //         mesReferencia: mesReferencia,
      //         dataFechamento: DateTime.now().toString(),
      //         dataVencimento: DateTime.now().toString(),
      //         valorFatura: valorFormatado,
      //         valorPago: '0',
      //         valorMinimo: '0',
      //         valorParcela: '0',
      //         totalParcelas: 0,
      //         parcelaAtual: 0,
      //         dataPagamento: DateTime.now().toString(),
      //         dataCadastro: DateTime.now().toString(),
      //         dataAtualizacao: DateTime.now().toString()
      //       )
      //     );
      //   }
      // });

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
          mesReferencia: gastoMensal.text.trim() == 'true' ? null : mesReferencia,
          reembolso: reembolso.text.trim() == 'true' ? 1 : 0,
          idCartao: int.tryParse(idCartao.text.trim()),
          gastoMensal: gastoMensal.text.trim() == 'true' ? 1 : 0,
          parcelado: parcelado.text.trim() == 'true' ? 1 : 0,
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

  Future<void> getTransacoesMesAtual() async {
    DateTime dataInicio = DateTime(DateTime.now().year, DateTime.now().month, 1);
    DateTime dataFim = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
    
    try {
      await _transacaoRepository.recoverAllByDateRange(
        dataInicio.toString(),
        dataFim.toString()
      ).then((value) {
        dataSourceTransacao = value;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getTransacoesMesAtualECartao(String idCartao) async {
    DateTime dataInicio = DateTime(DateTime.now().year, DateTime.now().month, 1);
    DateTime dataFim = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
    
    try {
      await _transacaoRepository.recoverAllByDateRangeAndCard(
        dataInicio.toString(),
        dataFim.toString(),
        idCartao
      ).then((value) {
        dataSourceTransacao = value;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getTransacoes() async {
    try {
      await _transacaoRepository.recoverAll().then((value) {
        dataSourceTransacao = value;
      });
    } catch (e) {
      print(e);
    }
  }
}