import 'package:finances/src/data/models/lancamento.dart';
import 'package:finances/src/data/repositories/lancamento_repository.dart';
import 'package:finances/src/helpers/functions.dart';
import 'package:flutter/cupertino.dart';

class GastoController extends ChangeNotifier {
  
  set dataSourceLancamento(value) => dataSourceLancamentoNotifier.value = value;
  List<Lancamento> get dataSourceLancamento => dataSourceLancamentoNotifier.value;

  ValueNotifier<List<Lancamento>> dataSourceLancamentoNotifier =
      ValueNotifier(<Lancamento>[]);

  final LancamentoRepository _lancamentoRepository = LancamentoRepository();
  
  // common
  final TextEditingController tipo = TextEditingController(text: '');
  final TextEditingController descricao = TextEditingController(text: '');
  final TextEditingController valor = TextEditingController(text: '');
  final TextEditingController detalhes = TextEditingController(text: '');
  final TextEditingController dataOcorrencia = TextEditingController(text: '');
  final TextEditingController idCategoria = TextEditingController(text: '');

  // out
  final TextEditingController gastoMensal = TextEditingController(text: 'N');
  final TextEditingController parcelado = TextEditingController(text: 'N');
  final TextEditingController totalParcelas = TextEditingController(text: '');
  final TextEditingController parcelaAtual = TextEditingController(text: '');

  // filtro
  final TextEditingController dataInicial = TextEditingController(text: '');
  final TextEditingController dataFinal = TextEditingController(text: '');

  Future<Map<String, Object>> validarOperacao() async {
    if (descricao.text.trim().isEmpty) {
      return {
        'isValid': false,
        'message': 'Descrição é obrigatória',
      };
    }

    if (valor.text.trim().isEmpty) {
      return {
        'isValid': false,
        'message': 'Valor é obrigatório',
      };
    }

    if (parcelado.text == 'S') {
      if (totalParcelas.text.trim().isEmpty) {
        return {
          'isValid': false,
          'message': 'Quantidade de parcelas é obrigatória',
        };
      }

      if (parcelaAtual.text.trim().isEmpty) {
        return {
          'isValid': false,
          'message': 'Parcela atual é obrigatória',
        };
      }
    }

    return {
      'isValid': true,
      'message': 'OK',
    };
  }


  void handleSubmit({
    required VoidCallback? Function() onSuccess,
    required VoidCallback? Function(String motivo) onFailure
  }) async {
    try {
      // valida operacao de entrada
      Map<String, dynamic> validacao = await validarOperacao();

      if (!validacao['isValid']) {
        throw validacao['message'];
      }

      double valorFormatado = double.tryParse(valor.text.replaceAll("R\$ ", "").replaceAll(".", "").replaceAll(",", "."))!;

      // insere transacao
      if (parcelado.text == 'S') {
        var valorParcelas = (valorFormatado / int.tryParse(totalParcelas.text)!);

        for (int i = int.tryParse(parcelaAtual.text)!; i <= int.tryParse(totalParcelas.text)!; i++) {
          DateTime dataOcorrenciaParcela = DateTime.parse(Functions.dataEn(dataOcorrencia.text)).add(Duration(days: 30 * (i - 1)));

          await _lancamentoRepository.insert(
            Lancamento(
              descricao: "$i/${totalParcelas.text} - ${descricao.text.trim()}",
              valor: valorParcelas,
              detalhes: detalhes.text.trim(),
              dataOcorrencia: dataOcorrenciaParcela,
              tipo: tipo.text,
              recorrente: gastoMensal.text,
              situacao: 'A',
              created_at: DateTime.now(),
            )
          );
        }
      } else {
        await _lancamentoRepository.insert(
          Lancamento(
            descricao: descricao.text.trim(),
            valor: valorFormatado,
            detalhes: detalhes.text.trim(),
            dataOcorrencia: dataOcorrencia.text.trim().isEmpty ? DateTime.now() : DateTime.parse(Functions.dataEn(dataOcorrencia.text)),
            tipo: tipo.text,
            recorrente: gastoMensal.text,
            situacao: 'A',
            created_at: DateTime.now(),
          )
        );
      }

      onSuccess();
    }
    catch (e) {
      onFailure(e.toString());
    }
  }

  Future<void> getLancamentosMesAtual(int mesAtual) async {    
    try {
      await _lancamentoRepository.recoverAllByMonthReference(mesAtual).then((value) {
        dataSourceLancamento = value;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getLancamentosDatas() async {
    try {
      DateTime dataInicialFormatada = DateTime.parse(Functions.dataEn(dataInicial.text));
      DateTime dataFinalFormatada = DateTime.parse(Functions.dataEn(dataFinal.text));

      await _lancamentoRepository.recoverAllByDateRange(dataInicialFormatada, dataFinalFormatada).then((value) {
        dataSourceLancamento = value;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getLancamentos() async {
    try {
      await _lancamentoRepository.recoverAll().then((value) {
        dataSourceLancamento = value;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List<Lancamento>> getLancamentosRecorrentes() async {
    try {
      return await _lancamentoRepository.recoverAllGastoMensal();
    } catch (e) {
      return [];
    }
  }

  Future<void> excluirCobrancaRecorrente(Lancamento transacao) async {
    try {
      //
    } catch (e) {
      print(e);
    }
  }
}