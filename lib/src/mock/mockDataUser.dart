import 'package:uuid/uuid.dart';

import 'package:finances/src/data/models/card.dart';
import 'package:finances/src/data/models/transaction.dart';

const _uuid = Uuid();

String commonId = _uuid.v4();

Map<String, List<Map<String, dynamic>>> history = {
  "2023": [
    {
      "month": "Janeiro",
      "monthNumber": 1,
      "transactions": [
        Transaction(
          _uuid.v4(),
          'Pagamentro freelancer',
          4616.00,
          'Pagamento do projeto de desenvolvimento de aplicativo',
          DateTime(2022, 5, 1),
          'entry',
          false,
          null,
          false,
          false,
          "",
          ""
        ),
        Transaction(
          _uuid.v4(),
          'Ressarcimento compra botas',
          4616.00,
          'Ressarcimento da compra de botas',
          DateTime(2022, 5, 3),
          'entry',
          true,
          null,
          false,
          false,
          "",
          ""
        ),
        Transaction(
          _uuid.v4(),
          'Mercado',
          500.00,
          'Compra no mercado',
          DateTime(2022, 5, 2),
          'out',
          false,
          commonId,
          true,
          false,
          "",
          ""
        ),
        Transaction(
          _uuid.v4(),
          'Pagamento aluguel',
          1000.00,
          'Pagamento do aluguel do apartamento',
          DateTime(2022, 5, 7),
          'out',
          false,
          null,
          true,
          false,
          "",
          ""
        ),
        Transaction(
          _uuid.v4(),
          'Combo Burger King',
          79.90,
          'Combo Burger King',
          DateTime(2022, 5, 14),
          'out',
          false,
          null,
          false,
          false,
          "",
          ""
        ),
        Transaction(
          _uuid.v4(),
          'Peixes',
          27.80,
          'Peixes para o aquário',
          DateTime(2022, 5, 15),
          'out',
          false,
          commonId,
          false,
          false,
          "",
          ""
        ),
      ]
    },
    {
      "month": "Abril",
      "monthNumber": 4,
      "transactions": [
        Transaction(
          _uuid.v4(),
          'Pagamentro freelancer',
          4616.00,
          'Pagamento do projeto de desenvolvimento de aplicativo',
          DateTime(2022, 5, 1),
          'entry',
          false,
          null,
          false,
          false,
          "",
          ""
        ),
        Transaction(
          _uuid.v4(),
          'Ressarcimento compra botas',
          4616.00,
          'Ressarcimento da compra de botas',
          DateTime(2022, 5, 3),
          'entry',
          true,
          null,
          false,
          false,
          "",
          ""
        ),
        Transaction(
          _uuid.v4(),
          'Mercado',
          100.00,
          'Compra no mercado',
          DateTime(2022, 5, 2),
          'out',
          false,
          null,
          false,
          false,
          "",
          ""
        ),
        Transaction(
          _uuid.v4(),
          'Pagamento aluguel',
          1000.00,
          'Pagamento do aluguel do apartamento',
          DateTime(2022, 5, 7),
          'out',
          false,
          null,
          false,
          false,
          "",
          ""
        ),
      ]
    },
    {
      "month": "Maio",
      "monthNumber": 5,
      "transactions": [
        Transaction(
          _uuid.v4(),
          'Pagamentro freelancer',
          4616.00,
          'Pagamento do projeto de desenvolvimento de aplicativo',
          DateTime(2022, 5, 1),
          'entry',
          false,
          null,
          false,
          false,
          "",
          ""
        ),
        Transaction(
          _uuid.v4(),
          'Ressarcimento compra botas',
          4616.00,
          'Ressarcimento da compra de botas',
          DateTime(2022, 5, 3),
          'entry',
          true,
          null,
          false,
          false,
          "",
          ""
        ),
        Transaction(
          _uuid.v4(),
          'Mercado',
          100.00,
          'Compra no mercado',
          DateTime(2022, 5, 2),
          'out',
          false,
          null,
          false,
          false,
          "",
          ""
        ),
        Transaction(
          _uuid.v4(),
          'Pagamento aluguel',
          1000.00,
          'Pagamento do aluguel do apartamento',
          DateTime(2022, 5, 7),
          'out',
          false,
          null,
          false,
          false,
          "",
          ""
        ),
      ]
    },
    {
      "month": "Setembro",
      "monthNumber": 9,
      "transactions": [
        Transaction(
          _uuid.v4(),
          'Pagamentro freelancer',
          4616.00,
          'Pagamento do projeto de desenvolvimento de aplicativo',
          DateTime(2022, 5, 1),
          'entry',
          false,
          null,
          false,
          false,
          "",
          ""
        ),
        Transaction(
          _uuid.v4(),
          'Ressarcimento compra botas',
          4616.00,
          'Ressarcimento da compra de botas',
          DateTime(2022, 5, 3),
          'entry',
          true,
          null,
          false,
          false,
          "",
          ""
        ),
        Transaction(
          _uuid.v4(),
          'Mercado',
          100.00,
          'Compra no mercado',
          DateTime(2022, 5, 2),
          'out',
          false,
          null,
          false,
          false,
          "",
          ""
        ),
        Transaction(
          _uuid.v4(),
          'Pagamento aluguel',
          1000.00,
          'Pagamento do aluguel do apartamento',
          DateTime(2022, 5, 7),
          'out',
          false,
          null,
          false,
          false,
          "",
          ""
        ),
      ]
    },
    {
      "month": "Novembro",
      "monthNumber": 11,
      "transactions": [
        Transaction(
          _uuid.v4(),
          'Pagamentro freelancer',
          4616.00,
          'Pagamento do projeto de desenvolvimento de aplicativo',
          DateTime(2022, 5, 1),
          'entry',
          false,
          null,
          false,
          false,
          "",
          ""
        ),
        Transaction(
          _uuid.v4(),
          'Ressarcimento compra botas',
          4616.00,
          'Ressarcimento da compra de botas',
          DateTime(2022, 5, 3),
          'entry',
          true,
          null,
          false,
          false,
          "",
          ""
        ),
        Transaction(
          _uuid.v4(),
          'Mercado',
          100.00,
          'Compra no mercado',
          DateTime(2022, 5, 2),
          'out',
          false,
          null,
          false,
          false,
          "",
          ""
        ),
        Transaction(
          _uuid.v4(),
          'Pagamento aluguel',
          1000.00,
          'Pagamento do aluguel do apartamento',
          DateTime(2022, 5, 7),
          'out',
          false,
          null,
          false,
          false,
          "",
          ""
        ),
      ]
    }
  ],
};

List<Card> cards = [
  Card(
    commonId,
    'Cartão PicPay',
    '1234',
    '10',
    'FFC107',
    'debit',
  ),
  Card(
    _uuid.v4(),
    'Cartão Nubank',
    '5678',
    '20',
    'FF5722',
    'credit',
  ),
  Card(
    _uuid.v4(),
    'Cartão Itaú',
    '9012',
    '30',
    '2196F3',
    'debit',
  ),
];
