import 'package:fingen/src/data/models/cartao/cartao.dart';
import 'package:fingen/src/ui/screens/Home/components/cartao.dart';
import 'package:flutter/material.dart';

class ListaCartao extends StatefulWidget {
  final List<Cartao> cartoes;

  const ListaCartao({
    super.key,
    this.cartoes = const [],
  });

  @override
  State<ListaCartao> createState() => _ListaCartaoState();
}

class _ListaCartaoState extends State<ListaCartao> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            CartaoComponente(
              nome: 'Cartão 1',
              ultimosDigitos: '3467',
            ),
            CartaoComponente(
              nome: 'Cartão 1',
              ultimosDigitos: '3467',
            ),
            CartaoComponente(
              nome: 'Cartão 1',
              ultimosDigitos: '3467',
            ),
            CartaoComponente(
              nome: 'Cartão 1',
              ultimosDigitos: '3467',
            ),
          ],
        ),
      ),
    );
  }
}