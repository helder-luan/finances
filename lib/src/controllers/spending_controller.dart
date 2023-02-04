import 'dart:convert';

import 'package:finances/src/helpers/functions.dart';
import 'package:finances/src/mock/mockDataUser.dart';
import 'package:finances/src/data/models/card.dart' as card_model;
import 'package:uuid/uuid.dart';
import 'package:finances/src/data/models/transaction.dart';
import 'package:flutter/cupertino.dart';

class SpendingController extends ChangeNotifier {
  static const _uuid = Uuid();

  // common
  final TextEditingController formPayment = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController value = TextEditingController();
  final TextEditingController details = TextEditingController();

  // entry
  final TextEditingController movimentType = TextEditingController();
  final TextEditingController refound = TextEditingController();

  // common out and entry
  final TextEditingController cardId = TextEditingController();

  // out
  final TextEditingController monthlyExpense = TextEditingController();
  final TextEditingController paymentInstallments = TextEditingController();
  final TextEditingController totalInstallments = TextEditingController();
  final TextEditingController currentInstallments = TextEditingController();

  void triggerSaveLocalData() {
    print(json.encode(history));
    // String historyJson = json.encode(history);
    // localData.setString("history", historyJson);
  }

  Future<List<Object>?> validateEntry() async {
    if (description.text.trim().isEmpty) {
      return [
        false,
        'Descrição não informada!',
      ];
    }

    if (value.text.trim().isEmpty) {
      return [
        false,
        'Valor não informado!',
      ];
    }

    if (refound.text.trim() == 'true') {
      if (cardId.text.trim().isEmpty) {
        return [
          false,
          'Cartão não informado!',
        ];
      }
    }

    return null;
  }

  Future<List<Object>?> validateOut() async {
    if (formPayment.text.trim() == '0') {
      return [
        false,
        'Forma de pagamento não informada!',
      ];
    }

    if (formPayment.text.trim() == 'M') {
      if (description.text.trim().isEmpty) {
        return [
          false,
          'Descrição não informada!',
        ];
      }

      if (value.text.trim().isEmpty) {
        return [
          false,
          'Valor não informado!',
        ];
      }
    }

    // credit payment
    if (formPayment.text.trim() == 'C') {
      if (cardId.text.trim().isEmpty) {
        return [
          false,
          'Cartão não informado!',
        ];
      }

      if (description.text.trim().isEmpty) {
        return [
          false,
          'Descrição não informada!',
        ];
      }

      if (value.text.trim().isEmpty) {
        return [
          false,
          'Valor não informado!',
        ];
      }

      if (paymentInstallments.text.trim() == 'true') {
        if (totalInstallments.text.trim().isEmpty) {
          return [
            false,
            'Total de parcelas não informado!',
          ];
        }

        if (currentInstallments.text.trim().isEmpty) {
          return [
            false,
            'Parcela atual não informada!',
          ];
        }
      }
    }


    // debit payment
    if (formPayment.text.trim() == 'D') {
      if (cardId.text.trim().isEmpty) {
        return [
          false,
          'Cartão não informado!',
        ];
      }

      if (description.text.trim().isEmpty) {
        return [
          false,
          'Descrição não informada!',
        ];
      }

      if (value.text.trim().isEmpty) {
        return [
          false,
          'Valor não informado!',
        ];
      }
    }
    
    return null;
  }

  // verifica em qual mes deve ser lancado a transacao com base no dia de vencimento do cartao
  Future<int> getMonthToPay() async {
    int month = DateTime.now().month;
    int closingDay = 0;
    card_model.Card card;

    if (cardId.text.trim().isNotEmpty) {
      card = cards.firstWhere((element) => element.id == cardId.text.trim());
      
      if ((int.parse(card.dueDay.toString()) - 7) > 0) {
        closingDay = int.parse(card.dueDay.toString()) - 7;
      } else {
        closingDay = int.parse(card.dueDay.toString()) + 23;
      }

      if (closingDay <= DateTime.now().day) {
        month = DateTime.now().month + 1;
      }
    }

    return month;
  }


  void handleSubmitEntry({
    required VoidCallback? Function() onSuccess,
    required VoidCallback? Function(String motivo) onFailure
  }) async {
    try {
      List<Object>? validation = await validateEntry();

      if (validation != null) {
        onFailure(validation[1].toString());
        return;
      }

      final Transaction transaction = Transaction(
        _uuid.v4(),
        description.text.trim(),
        double.parse(value.text.replaceAll("R\$ ", "").replaceAll(".", "").replaceAll(",", ".")),
        details.text.trim(),
        DateTime.now(),
        movimentType.text.trim(),
        refound.text.trim() == 'true' ? true : false,
        cardId.text.trim(),
        false,
        false,
        "",
        ""
      );

      await create(transaction);
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
      List<Object>? validation = await validateOut();

      if (validation != null) {
        onFailure(validation[1].toString());
        return;
      }

      final Transaction transaction = Transaction(
        _uuid.v4(),
        description.text.trim(),
        double.parse(value.text.replaceAll("R\$ ", "").replaceAll(".", "").replaceAll(",", ".")),
        details.text.trim(),
        DateTime.now(),
        movimentType.text.trim(),
        refound.text.trim() == 'true' ? true : false,
        cardId.text.trim(),
        monthlyExpense.text.trim() == 'true' ? true : false,
        paymentInstallments.text.trim() == 'true' ? true : false,
        totalInstallments.text.trim(),
        currentInstallments.text.trim()
      );

      await create(transaction);
      onSuccess();
    }
    catch (e) {
      onFailure(e.toString());
    }
  }

  Future<void> create(Transaction transaction) async {
    var currentYear = history['${DateTime.now().year}'];

    int launchMonth = await getMonthToPay();

    var monthAttributeExists = currentYear!.firstWhere((element) => element['monthNumber'] == launchMonth, orElse: () => {});

    if (monthAttributeExists != null) {
      var month = currentYear.firstWhere((element) => element['monthNumber'] == launchMonth);

      month['transactions'].add(transaction);
    } else if (currentYear != null){
      currentYear.add({
        "month": Functions.fullMonthName(launchMonth),
        "monthNumber": launchMonth,
        "transactions": [transaction]
      });
    } else {
      history['${DateTime.now().year}'] = [
        {
          "month": Functions.fullMonthName(launchMonth),
          "monthNumber": DateTime.now().month,
          "transactions": [transaction]
        }
      ];
    }
  }

  Future<void> update() async {
    //
  }

  Future<void> delete(String id) async { 
    //
  }

  Future<dynamic> read() async {
    //
  }
}