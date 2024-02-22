import 'package:finances/src/data/models/lancamento.dart';
import 'package:finances/src/data/providers/database_providers/lancamento_db_provider.dart';
import 'package:finances/src/data/repositories/base_repository.dart';

class LancamentoRepository extends BaseRepository<Lancamento> {
  LancamentoRepository()
      : super(LancamentoDbProvider(), (map) => Lancamento.fromMap(map));

  Future<List<Lancamento>> recoverAllByDate(DateTime date) async {
    List<Map<String, dynamic>> result = await (provider as LancamentoDbProvider).recoverAllByDate(date);

    var lista = <Lancamento>[];

    for (Map<String, dynamic> transacao in result) {
      lista.add(instanceFromMap(transacao));
    }

    return lista;
  }

  Future<List<Lancamento>> recoverAllByDateRange(DateTime startDate, DateTime endDate) async {
    List<Map<String, dynamic>> result = await (provider as LancamentoDbProvider).recoverAllByDateRange(startDate, endDate);

    var lista = <Lancamento>[];

    for (Map<String, dynamic> transacao in result) {
      lista.add(instanceFromMap(transacao));
    }

    return lista;
  }

  Future<List<Lancamento>> recoverAllByMonthReference(int monthReference) async {
    List<Map<String, dynamic>> result = await (provider as LancamentoDbProvider).recoverAllByMonthReference(monthReference);

    var lista = <Lancamento>[];

    for (Map<String, dynamic> transacao in result) {
      lista.add(instanceFromMap(transacao));
    }

    return lista;
  }

  Future<List<Lancamento>> recoverAllGastoMensal() async {
    List<Map<String, dynamic>> result = await (provider as LancamentoDbProvider).recoverAllGastoMensal();

    var lista = <Lancamento>[];

    for (Map<String, dynamic> transacao in result) {
      lista.add(instanceFromMap(transacao));
    }

    return lista;
  }
}
