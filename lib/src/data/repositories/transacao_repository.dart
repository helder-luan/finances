import 'package:finances/src/data/models/transacao.dart';
import 'package:finances/src/data/providers/database_providers/transacao_db_provider.dart';
import 'package:finances/src/data/repositories/base_repository.dart';

class TransacaoRepository extends BaseRepository<Transacao> {
  TransacaoRepository()
      : super(TransacaoDbProvider(), (map) => Transacao.fromMap(map));

  Future<List<Transacao>> recoverAllByCard(String cardId) async {
    List<Map<String, dynamic>> result = await (provider as TransacaoDbProvider).recoverAllByCard(cardId);

    var lista = <Transacao>[];

    for (Map<String, dynamic> transacao in result) {
      lista.add(instanceFromMap(transacao));
    }

    return lista;
  }

  Future<List<Transacao>> recoverAllByDate(String date) async {
    List<Map<String, dynamic>> result = await (provider as TransacaoDbProvider).recoverAllByDate(date);

    var lista = <Transacao>[];

    for (Map<String, dynamic> transacao in result) {
      lista.add(instanceFromMap(transacao));
    }

    return lista;
  }

  Future<List<Transacao>> recoverAllByDateAndCard(String date, String cardId) async {
    List<Map<String, dynamic>> result = await (provider as TransacaoDbProvider).recoverAllByDateAndCard(date, cardId);

    var lista = <Transacao>[];

    for (Map<String, dynamic> transacao in result) {
      lista.add(instanceFromMap(transacao));
    }

    return lista;
  }

  Future<List<Transacao>> recoverAllByDateRange(String startDate, String endDate) async {
    List<Map<String, dynamic>> result = await (provider as TransacaoDbProvider).recoverAllByDateRange(startDate, endDate);

    var lista = <Transacao>[];

    for (Map<String, dynamic> transacao in result) {
      lista.add(instanceFromMap(transacao));
    }

    return lista;
  }

  Future<List<Transacao>> recoverAllByDateRangeAndCard(String startDate, String endDate, String cardId) async {
    List<Map<String, dynamic>> result = await (provider as TransacaoDbProvider).recoverAllByDateRangeAndCard(startDate, endDate, cardId);

    var lista = <Transacao>[];

    for (Map<String, dynamic> transacao in result) {
      lista.add(instanceFromMap(transacao));
    }

    return lista;
  }

  Future<List<Transacao>> recoverAllByMonthReference(int monthReference) async {
    List<Map<String, dynamic>> result = await (provider as TransacaoDbProvider).recoverAllByMonthReference(monthReference);

    var lista = <Transacao>[];

    for (Map<String, dynamic> transacao in result) {
      lista.add(instanceFromMap(transacao));
    }

    return lista;
  }

  Future<List<Transacao>> recoverAllByMonthReferenceAndCard(int monthReference, String cardId) async {
    List<Map<String, dynamic>> result = await (provider as TransacaoDbProvider).recoverAllByMonthReferenceAndCard(monthReference, cardId);

    var lista = <Transacao>[];

    for (Map<String, dynamic> transacao in result) {
      lista.add(instanceFromMap(transacao));
    }

    return lista;
  }
}
