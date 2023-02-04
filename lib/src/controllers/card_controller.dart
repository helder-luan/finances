import 'package:finances/src/data/repositories/card_repository.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/cupertino.dart';

import 'package:finances/src/data/models/card.dart';

class CardController extends ChangeNotifier {
  final CardRepository _repository = CardRepository();

  static const _uuid = Uuid();

  Card? _current;

  Card? get current => _current;

  set current(value) {
    _current = value;
    if (_current != null) {
      nameController.text = _current!.name!;
      finalNumberController.text = _current!.finalNumber!;
      dueDayController.text = _current!.dueDay!;
      hexColorController.text = _current!.hexColor!;
      typeController.text = _current!.type!;
    }
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController finalNumberController = TextEditingController();
  final TextEditingController dueDayController = TextEditingController();
  final TextEditingController hexColorController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  Future<List<Object>?> validate() async {
    if (nameController.text.trim().isEmpty) {
      return [
        false,
        'Nome não informado!',
      ];
    }

    if (dueDayController.text.trim().isNotEmpty && int.parse(dueDayController.text.trim()) > 31) {
      return [
        false,
        'Dia de vencimento inválido!',
      ];
    }

    if (typeController.text.trim().isEmpty) {
      return [
        false,
        'Tipo de cartão não informado!',
      ];
    }

    return null;
  }

  void handleSubmit({
    required VoidCallback? Function() onSuccess,
    required VoidCallback? Function(String motivo) onFailure
  }) async {
    try {
      List<Object>? validation = await validate();

      if (validation != null) {
        onFailure(validation[1].toString());
        return;
      }

      if (current == null) {
        var cartao = Card(
          _uuid.v4(),
          nameController.text,
          finalNumberController.text,
          dueDayController.text,
          hexColorController.text,
          typeController.text,
        );

        await _repository.insert(cartao);
      } else {
        var cartao = Card(
          current!.id,
          nameController.text,
          finalNumberController.text,
          dueDayController.text,
          hexColorController.text,
          typeController.text,
        );
        
        await _repository.update(cartao);
      }

      onSuccess();
    }
    catch (e) {
      onFailure(e.toString());
    }
  }

  void deleteCard(String id, {
    required VoidCallback? Function() onSuccess,
    required VoidCallback? Function(String motivo) onFailure
  }) async {
    try {
      await _repository.delete(id);

      onSuccess();
    }
    catch (e) {
      onFailure(e.toString());
    }
  }
}