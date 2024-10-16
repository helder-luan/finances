import 'package:flutter/material.dart';

class CartaoComponente extends StatelessWidget {
  final String nome;
  final String ultimosDigitos;

  const CartaoComponente({
    super.key,
    this.nome = '',
    this.ultimosDigitos = ''
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 24),
      padding: const EdgeInsets.only(top: 16, left: 8, bottom: 16),
      child: GestureDetector(
        child: Container(
          height: 180,
          width: 300,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/images/background_cartao.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(5, 5),
                blurRadius: 10,
                spreadRadius: 1,
              )
            ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    nome,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16
                    ),
                  ),
                ]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "***$ultimosDigitos",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16
                    ),
                  )
                ]
              ),
            ],
          ),
        )
      ),
    );
  }
}