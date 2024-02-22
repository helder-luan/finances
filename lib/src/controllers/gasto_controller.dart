import 'package:finances/src/controllers/mes_referencia_controller.dart';
import 'package:finances/src/data/models/lancamento.dart';
import 'package:finances/src/data/repositories/lancamento_repository.dart';
import 'package:flutter/cupertino.dart';

class GastoController extends ChangeNotifier {
  
  set dataSourceTransacao(value) => dataSourceTransacaoNotifier.value = value;
  List<Lancamento> get dataSourceTransacao => dataSourceTransacaoNotifier.value;

  ValueNotifier<List<Lancamento>> dataSourceTransacaoNotifier =
      ValueNotifier(<Lancamento>[]);

  final MesReferenciaController _mesReferenciaController = MesReferenciaController();

  final LancamentoRepository _lancamentoRepository = LancamentoRepository();
  
  // common
  final TextEditingController tipo = TextEditingController(text: '');
  final TextEditingController descricao = TextEditingController(text: '');
  final TextEditingController valor = TextEditingController(text: '');
  final TextEditingController detalhes = TextEditingController(text: '');

  // out
  final TextEditingController gastoMensal = TextEditingController(text: '');
  final TextEditingController parcelado = TextEditingController(text: '');
  final TextEditingController totalParcelas = TextEditingController(text: '');
  final TextEditingController parcelaAtual = TextEditingController(text: '');

  Future<Map<String, Object>> validarOperacao() async {
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
      Map validacao = await validarOperacao();

      if (!validacao['isValid']) {
        throw validacao['message'];
      }

      double valorFormatado = double.tryParse(valor.text.replaceAll("R\$ ", "").replaceAll(".", "").replaceAll(",", "."))!;

      // insere transacao
      await _lancamentoRepository.insert(
        Lancamento(
          descricao: descricao.text.trim(),
          valor: valorFormatado,
          detalhes: detalhes.text.trim(),
          dataOcorrencia: DateTime.now(),
          tipo: tipo.text,
          recorrente: 'N',
          situacao: 'A',
          created_at: DateTime.now(),
        )
      );

      onSuccess();
    }
    catch (e) {
      onFailure(e.toString());
    }
  }

  Future<void> getTransacoesMesAtual(int mesAtual) async {    
    try {
      await _lancamentoRepository.recoverAllByMonthReference(mesAtual).then((value) {
        dataSourceTransacao = value;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getTransacoes() async {
    try {
      await _lancamentoRepository.recoverAll().then((value) {
        dataSourceTransacao = value;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List<Lancamento>> getTransacoesRecorrentes() async {
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