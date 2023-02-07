import 'package:finances/src/data/models/transacao.dart';
import 'package:finances/src/data/providers/database_providers/transacao_db_provider.dart';
import 'package:finances/src/data/repositories/base_repository.dart';

class TransacaoRepository extends BaseRepository<Transacao> {
  TransacaoRepository()
      : super(TransacaoDbProvider(), (map) => Transacao.fromMap(map));

  Future<List<Map<String, dynamic>>> recoverAllByCard(String cardId) {
    return (provider as TransacaoDbProvider).recoverAllByCard(cardId);
  }

  Future<List<Map<String, dynamic>>> recoverAllByDate(String date) {
    return (provider as TransacaoDbProvider).recoverAllByDate(date);
  }

  Future<List<Map<String, dynamic>>> recoverAllByDateAndCard(String date, String cardId) {
    return (provider as TransacaoDbProvider).recoverAllByDateAndCard(date, cardId);
  }

  Future<List<Map<String, dynamic>>> recoverAllByDateRange(String startDate, String endDate) {
    return (provider as TransacaoDbProvider).recoverAllByDateRange(startDate, endDate);
  }

  Future<List<Map<String, dynamic>>> recoverAllByDateRangeAndCard(String startDate, String endDate, String cardId) {
    return (provider as TransacaoDbProvider).recoverAllByDateRangeAndCard(startDate, endDate, cardId);
  }
}
