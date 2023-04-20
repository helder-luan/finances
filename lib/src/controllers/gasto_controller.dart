
import 'package:finances/src/controllers/fatura_controller.dart';
import 'package:finances/src/controllers/mes_referencia_controller.dart';
import 'package:finances/src/data/models/cartao.dart';
import 'package:finances/src/data/models/fatura.dart';
import 'package:finances/src/data/models/transacao.dart';
import 'package:finances/src/data/repositories/cartao_repository.dart';
import 'package:finances/src/data/repositories/fatura_repository.dart';
import 'package:finances/src/data/repositories/tipo_operacao_repository.dart';
import 'package:finances/src/data/repositories/transacao_repository.dart';
import 'package:flutter/cupertino.dart';

class GastoController extends ChangeNotifier {
  
  set dataSourceTransacao(value) => dataSourceTransacaoNotifier.value = value;
  List<Transacao> get dataSourceTransacao => dataSourceTransacaoNotifier.value;

  ValueNotifier<List<Transacao>> dataSourceTransacaoNotifier =
      ValueNotifier(<Transacao>[]);

  final FaturaController _faturaController = FaturaController();
  final MesReferenciaController _mesReferenciaController = MesReferenciaController();

  final TransacaoRepository _transacaoRepository = TransacaoRepository();
  final CartaoRepository _cartaoRepository = CartaoRepository();
  final FaturaRepository _faturaRepository = FaturaRepository();
  final TipoOperacaoRepository _tipoOperacaoRepository = TipoOperacaoRepository();
  
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

  Future<Map<String, Object>> validarOperacaoEntrada() async {
    if (descricao.text.trim().isEmpty) {
      return {
        'isValid': false,
        'message': 'Descrição não informada!',
      };
    }

    if (valor.text.trim().isEmpty) {
      return {
        'isValid': false,
        'message': 'Valor não informado!'
      };
    }

    if (reembolso.text.trim() == 'true') {
      if (idCartao.text.trim().isEmpty) {
        return {
          'isValid': false,
          'message': 'Cartão não informado!',
        };
      }
    }

    return {
      'isValid': true,
      'message': 'OK',
    };
  }

  Future<Map<String, Object>> validarOperacaoSaida() async {
    if (formaDePagamento.text.trim() == '0') {
      return {
        'isValid': false,
        'message': 'Forma de pagamento não informada!',
      };
    }

    if (formaDePagamento.text.trim() == 'M') {
      if (descricao.text.trim().isEmpty) {
        return {
          'isValid': false,
          'message': 'Descrição não informada!',
        };
      }

      if (valor.text.trim().isEmpty) {
        return {
          'isValid': false,
          'message': 'Valor não informado!',
        };
      }
    }

    // credit payment
    if (formaDePagamento.text.trim() == 'C') {
      if (idCartao.text.trim().isEmpty) {
        return {
          'isValid': false,
          'message': 'Cartão não informado!',
        };
      }

      if (descricao.text.trim().isEmpty) {
        return {
          'isValid': false,
          'message': 'Descrição não informada!',
        };
      }

      if (valor.text.trim().isEmpty) {
        return {
          'isValid': false,
          'message': 'Valor não informado!',
        };
      }

      if (parcelado.text.trim() == 'true') {
        if (totalParcelas.text.trim().isEmpty) {
          return {
            'isValid': false,
            'message': 'Total de parcelas não informado!',
          };
        }

        if (parcelaAtual.text.trim().isEmpty) {
          return {
            'isValid': false,
            'message': 'Parcela atual não informada!',
          };
        }
      }
    }


    // debit payment
    if (formaDePagamento.text.trim() == 'D') {
      if (idCartao.text.trim().isEmpty) {
        return {
          'isValid': false,
          'message': 'Cartão não informado!',
        };
      }

      if (descricao.text.trim().isEmpty) {
        return {
          'isValid': false,
          'message': 'Descrição não informada!',
        };
      }

      if (valor.text.trim().isEmpty) {
        return {
          'isValid': false,
          'message': 'Valor não informado!',
        };
      }
    }
    
    return {
      'isValid': true,
      'message': 'OK',
    };
  }

  // verifica em qual mes deve ser lancado a transacao com base no dia de vencimento do cartao
  Future<int> getMesParaLacamento() async {
    int mes = DateTime.now().month;
    int diaFechamento = 0;

    if (idCartao.text.trim().isNotEmpty) {
      Cartao cartao = await _cartaoRepository.recover(idCartao.text.trim());
      
      if ((cartao.diaVencimento! - 10) > 0) {
        diaFechamento = cartao.diaVencimento! - 10;
      } else {
        diaFechamento = cartao.diaVencimento! + 20;
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
      Map validacao = await validarOperacaoEntrada();

      if (!validacao['isValid']) {
        throw validacao['message'];
      }

      int mesReferencia = await getMesParaLacamento();
      double valorFormatado = double.tryParse(valor.text.replaceAll("R\$ ", "").replaceAll(".", "").replaceAll(",", "."))!;

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

      var tipoOperacao = await _tipoOperacaoRepository.recover(idTipoOperacao.text.trim());

      if (
        reembolso.text.trim() == 'true'
        &&
        idCartao.text.trim() != '0'
      ) {
        Fatura? fatura = await _faturaController.verificaSeExisteFaturaMesAtualDoCartao(idCartao.text.trim(), mesReferencia.toString());

        if (fatura != null) {
          var valorTotal = fatura.valorTotal! - valorFormatado;

          await _faturaController.atualizaValorTotalFatura(idCartao.text.trim(), mesReferencia.toString(), valorTotal.toString());
        } else {
          var cartao = await _cartaoRepository.recover(idCartao.text.trim());

          await _faturaController.criarFatura(
            Fatura(
              idCartao: cartao.idCartao,
              mesReferencia: mesReferencia,
              dataFechamento: cartao.diaFechamento.toString(),
              dataVencimento: cartao.diaVencimento.toString(),
              dataPagamento: null,
              valorTotal: valorFormatado,
            )
          );
        }
      }

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
      Map validacao = await validarOperacaoSaida();

      if (!validacao['isValid']) {
        onFailure(validacao['message']);
        return;
      }

      int mesReferencia = await getMesParaLacamento();
      double valorFormatado = double.tryParse(valor.text.replaceAll("R\$ ", "").replaceAll(".", "").replaceAll(",", "."))!;

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

      if (
        formaDePagamento.text.trim() == "C"
        &&
        idCartao.text.trim() != '0'
      ) {
        Fatura? fatura = await _faturaController.verificaSeExisteFaturaMesAtualDoCartao(idCartao.text.trim(), mesReferencia.toString());

        if (fatura != null) {
          var valorTotal = fatura.valorTotal! + valorFormatado;

          await _faturaController.atualizaValorTotalFatura(idCartao.text.trim(), mesReferencia.toString(), valorTotal.toString());
        } else {
          var cartao = await _cartaoRepository.recover(idCartao.text.trim());

          await _faturaController.criarFatura(
            Fatura(
              idCartao: cartao.idCartao,
              mesReferencia: mesReferencia,
              dataFechamento: cartao.diaFechamento.toString(),
              dataVencimento: cartao.diaVencimento.toString(),
              dataPagamento: null,
              valorTotal: valorFormatado,
            )
          );
        }
      }

      onSuccess();
    }
    catch (e) {
      onFailure(e.toString());
    }
  }

  Future<void> getTransacoesMesAtual(int mesAtual) async {    
    try {
      await _transacaoRepository.recoverAllByMonthReference(_mesReferenciaController.current).then((value) {
        dataSourceTransacao = value;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getTransacoesMesAtualECartao(String idCartao) async {    
    try {
      await _transacaoRepository.recoverAllByMonthReferenceAndCard(
        _mesReferenciaController.current,
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

  Future<List<Transacao>> getTransacoesRecorrentes() async {
    try {
      return await _transacaoRepository.recoverAllGastoMensal();
    } catch (e) {
      print(e);
      return [];
    }
  }
}