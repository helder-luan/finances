import 'package:finances/src/data/models/cartao.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:finances/src/ui/screens/CadastrarCartao/index.dart';
import 'package:flutter/material.dart';

class CartaoListagemComponent extends StatefulWidget {
  final Cartao cartao;

  const CartaoListagemComponent({
    super.key,
    required this.cartao
  });

  @override
  State<CartaoListagemComponent> createState() => _CartaoListagemComponentState();
}

class _CartaoListagemComponentState extends State<CartaoListagemComponent> {

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.transparent, width: 0.0),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CadastrarCartaoScreen(
              cartao: widget.cartao,
            ),
          ),
        );
      },
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: const Icon(Icons.credit_card),
          ),
          TextComponent(text: widget.cartao.nome.toString()),
        ],
      ),
    );
  }
}