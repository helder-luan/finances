import 'package:finances/src/data/providers/database_providers/card_db_provider.dart';
import 'package:finances/src/data/repositories/base_repository.dart';
import 'package:finances/src/data/models/card.dart' as card_model;

class CardRepository extends BaseRepository<card_model.Card> {
  CardRepository()
      : super(CardDbProvider(), (map) => card_model.Card.fromMap(map));
}
