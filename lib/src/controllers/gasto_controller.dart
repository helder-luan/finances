
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
      if (idCartao.text.trim().isEmpty || idCartao.text.trim() == '0') {
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
      if (idCartao.text.trim().isEmpty || idCartao.text.trim() == '0') {
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

  // verifica em qual mes deve ser lancado a transacao com base no dia do fechamento do cartao
  Future<int> getMesParaLacamento() async {
    int mes = _mesReferenciaController.current;

    if (idCartao.text.trim().isNotEmpty && idCartao.text.trim() != '0') {
      Cartao cartao = await _cartaoRepository.recover(idCartao.text.trim());

      if (int.tryParse(cartao.diaFechamento.toString())! <= DateTime.now().day) {
        mes = _mesReferenciaController.current + 1;
      }
    }

    return mes;
  }


  void handleSubmitEntry({
    required VoidCallback? Function() onSuccess,
    required VoidCallback? Function(String motivo) onFailure
  }) async {
    try {
      // valida operacao de entrada
      Map validacao = await validarOperacaoEntrada();

      if (!validacao['isValid']) {
        throw validacao['message'];
      }

      // verifica em qual mes deve ser lancado a transacao com base no dia do fechamento do cartao
      int mesReferencia = await getMesParaLacamento();

      double valorFormatado = double.tryParse(valor.text.replaceAll("R\$ ", "").replaceAll(".", "").replaceAll(",", "."))!;

      // insere transacao
      await _transacaoRepository.insert(
        Transacao(
          descricao: descricao.text.trim(),
          valor: valorFormatado,
          detalhes: detalhes.text.trim(),
          dataCadastro: DateTime.now().toString(),
          idTipoOperacao: int.tryParse(idTipoOperacao.text.trim()),
          mesReferencia: mesReferencia,
          anoReferencia: DateTime.now().year,
          reembolso: reembolso.text.trim() == 'true' ? 1 : 0,
          idCartao: int.tryParse(idCartao.text.trim()),
          gastoMensal: 0,
          parcelado: 0,
          totalParcelas: 0,
          parcelaAtual: 0
        )
      );

      // se for reembolso
      if (
        reembolso.text.trim() == 'true'
        &&
        idCartao.text.trim() != '0'
      ) {
        // verifica se existe fatura do mes atual
        Fatura? fatura = await _faturaController.verificaSeExisteFaturaMesAtualDoCartao(idCartao.text.trim(), mesReferencia.toString());

        // se existir fatura, atualiza o valor total da fatura
        if (fatura != null) {
          double valorTotal = fatura.valorTotal! - valorFormatado;

          await _faturaController.atualizaValorFatura(idCartao.text.trim(), mesReferencia.toString(), valorTotal);
        } else {
          // se nao existir fatura, cria uma nova fatura
          var cartao = await _cartaoRepository.recover(idCartao.text.trim());

          await _faturaController.criarFatura(
            Fatura(
              idCartao: cartao.idCartao,
              mesReferencia: mesReferencia,
              anoReferencia: DateTime.now().year,
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
      // valida a operacao de saida
      Map validacao = await validarOperacaoSaida();

      if (!validacao['isValid']) {
        onFailure(validacao['message']);
        return;
      }

      // verifica em qual mes deve ser lancado a transacao com base no dia do fechamento do cartao
      int mesReferencia = await getMesParaLacamento();

      double valorFormatado = double.tryParse(valor.text.replaceAll("R\$ ", "").replaceAll(".", "").replaceAll(",", "."))!;

      // se for parcelado
      if (parcelado.text.trim() == 'true') {
        // calcula o total de parcelas restantes
        int parcelasRestantes = (int.tryParse(totalParcelas.text.trim())! - int.tryParse(parcelaAtual.text.trim())!) + 1;

        // para cada parcela restante insere uma transacao
        for (var i = 1; i <= parcelasRestantes; i++) {
          int mesLancamento = mesReferencia + (i - 1);

          await _transacaoRepository.insert(
            Transacao(
              descricao: descricao.text.trim(),
              valor: valorFormatado,
              detalhes: detalhes.text.trim(),
              dataCadastro: DateTime.now().toString(),
              idTipoOperacao: int.tryParse(idTipoOperacao.text.trim()),
              mesReferencia: mesLancamento > 12 ? mesLancamento - 12 : mesLancamento,
              anoReferencia: mesLancamento > 12 ? DateTime.now().year + 1 : DateTime.now().year,
              reembolso: reembolso.text.trim() == 'true' ? 1 : 0,
              idCartao: int.tryParse(idCartao.text.trim()),
              gastoMensal: gastoMensal.text.trim() == 'true' ? 1 : 0,
              parcelado: 1,
              totalParcelas: int.tryParse(totalParcelas.text.trim()),
              parcelaAtual: int.tryParse(parcelaAtual.text.trim())! + (i - 1),
            )
          );
        }
      } else {
        // se nao for parcelado insere apenas uma transacao
        await _transacaoRepository.insert(
          Transacao(
            descricao: descricao.text.trim(),
            valor: valorFormatado,
            detalhes: detalhes.text.trim(),
            dataCadastro: DateTime.now().toString(),
            idTipoOperacao: int.tryParse(idTipoOperacao.text.trim()),
            mesReferencia: mesReferencia,
            anoReferencia: DateTime.now().year,
            reembolso: reembolso.text.trim() == 'true' ? 1 : 0,
            idCartao: int.tryParse(idCartao.text.trim()),
            gastoMensal: gastoMensal.text.trim() == 'true' ? 1 : 0,
            parcelado: 0,
            totalParcelas: 0,
            parcelaAtual: 0,
          )
        );
      }

      // se pagamento for com cartao de credito
      if (
        formaDePagamento.text.trim() == "C"
        &&
        idCartao.text.trim() != '0'
      ) {
        // verifica se existe fatura do cartao no mes atual
        Fatura? fatura = await _faturaController.verificaSeExisteFaturaMesAtualDoCartao(idCartao.text.trim(), mesReferencia.toString());

        // se existir atualiza o valor total da fatura
        if (fatura != null) {
          double valorTotal = fatura.valorTotal! + valorFormatado;

          await _faturaController.atualizaValorFatura(idCartao.text.trim(), mesReferencia.toString(), valorTotal);
        } else {
          // se nao existir cria uma nova fatura
          var cartao = await _cartaoRepository.recover(idCartao.text.trim());

          await _faturaController.criarFatura(
            Fatura(
              idCartao: cartao.idCartao,
              mesReferencia: mesReferencia,
              anoReferencia: DateTime.now().year,
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
      await _transacaoRepository.recoverAllByMonthReference(mesAtual).then((value) {
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
      return [];
    }
  }

  Future<void> excluirCobrancaRecorrente(Transacao transacao) async {
    try {
      if (transacao.idCartao != null) {
        Cartao cartao = await _cartaoRepository.recover(transacao.idCartao.toString());
        
        DateTime dataFechamento = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          int.tryParse(cartao.diaFechamento.toString())!
        );

        DateTime dataAtual = DateTime.now();

        Fatura? faturaDoCartao = await _faturaController.recuperaFaturaDoCartao(cartao.idCartao.toString());

        if (dataAtual.isBefore(dataFechamento) && faturaDoCartao != null) {
          double valorTotal = faturaDoCartao.valorTotal! - transacao.valor!;

          _faturaController.atualizaValorFatura(
            cartao.idCartao.toString(),
            _mesReferenciaController.current.toString(),
            valorTotal
          );
        }
      }

      await _transacaoRepository.delete(transacao.idTransacao.toString());
    } catch (e) {
      print(e);
    }
  }
}