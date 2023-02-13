import 'package:finances/src/controllers/cartao_controller.dart';
import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/data/models/cartao.dart';
import 'package:finances/src/ui/components/Button/index.dart';
import 'package:finances/src/ui/components/Cartao/index.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:finances/src/ui/screens/Cartao/index.dart';
import 'package:finances/src/ui/screens/CadastrarCartao/index.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

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
  final _controller = CartaoController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: const Icon(Icons.credit_card),
            ),
            TextComponent(text: widget.cartao.nome.toString()),
          ]
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              color: AppColors.success,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegistrarCartaoScreen(cartao: widget.cartao)
                  )
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: AppColors.danger,
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Remover cartão'),
                      content: SingleChildScrollView(
                        child: Text('Tem certeza que deseja remover ${widget.cartao.nome?.toUpperCase()}?')
                      ),
                      actions: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ButtonComponent(
                              style: 'danger',
                              onPressed: () {
                                _controller.deleteCard(
                                  widget.cartao.idCartao.toString(),
                                  onSuccess: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const CartaoScreen(),
                                      ),
                                      (route) => false
                                    );
                                    
                                    MotionToast.success(description: const Text('Cartão cadastrado com sucesso')).show(context);

                                    return null;
                                  },
                                  onFailure: (onFailure) {
                                    MotionToast
                                      .error(
                                        title: const Text("Atenção"),
                                        description: Text(onFailure)
                                      )
                                      .show(context);
                                    print(onFailure);
                                    return null;
                                  }
                                );
                                
                                
                              },
                              children: TextComponent(
                                text: 'Remover',
                                weight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            ButtonComponent(
                              style: 'success',
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              children: TextComponent(
                                text: 'Cancelar',
                                weight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ), 
                          ]
                        )
                      ],
                    );
                  },
                );
              },
            ),
            Container(
              margin: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: const Icon(Icons.info_outline_rounded),
                color: AppColors.primary,
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Detalhes do cartão'),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 16.0),
                                child: TextComponent(
                                  text: 'Informações do cartão',
                                  weight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextComponent(
                                    text: 'Nome',
                                    weight: FontWeight.bold,
                                  ),
                                  TextComponent(
                                    text: widget.cartao.nome.toString(),
                                  ),
                                ]
                              ),
                              Visibility(
                                visible: widget.cartao.diaVencimento != null && widget.cartao.diaVencimento != 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextComponent(
                                      text: 'Dia de vencimento',
                                      weight: FontWeight.bold,
                                    ),
                                    TextComponent(
                                      text: widget.cartao.diaVencimento.toString(),
                                    ),
                                  ]
                                ),
                              ),
                              Visibility(
                                visible: widget.cartao.finalCartao != null && widget.cartao.finalCartao!.isNotEmpty,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextComponent(
                                      text: 'Final do cartão',
                                      weight: FontWeight.bold,
                                    ),
                                    TextComponent(
                                      text: widget.cartao.finalCartao.toString(),
                                    ),
                                  ]
                                ),
                              ),
                              CartaoComponent(
                                key: widget.key,
                                cardName: widget.cartao.nome.toString(),
                                cardNumVenc: widget.cartao.diaVencimento.toString(),
                                cardNumFinal: widget.cartao.finalCartao.toString(),
                                cardColor: Color(int.tryParse("0xFF${widget.cartao.hexCor}")!),
                                onPressed: () {},
                              )
                            ],
                          )
                        ),
                        actions: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ButtonComponent(
                                style: 'success',
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                children: TextComponent(
                                  text: 'Voltar',
                                  weight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ), 
                            ]
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            )
          ]
        )
      ],
    );
  }
}