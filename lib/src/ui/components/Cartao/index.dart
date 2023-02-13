import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:flutter/material.dart';

class CartaoComponent extends StatefulWidget {
  String cardName;
  Color cardColor;
  String cardNumVenc;
  String cardNumFinal;
  VoidCallback onPressed;

  CartaoComponent({
    super.key,
    required this.cardName,
    this.cardColor = Colors.grey,
    this.cardNumVenc = "",
    this.cardNumFinal = "",
    required this.onPressed
  });

  @override
  State<CartaoComponent> createState() => _CartaoComponentState();
}

class _CartaoComponentState extends State<CartaoComponent> {
  final _heightScale = 175.0;
  final _widthScale = 375.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide.none,
      ),
      onPressed: widget.onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width-32,
        height: (MediaQuery.of(context).size.width*_heightScale)/_widthScale,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: widget.cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8.0,
              spreadRadius: 1.0,
              offset: Offset(0, 0),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  TextComponent(
                    text: widget.cardName,
                    style: 'cardTitle',
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          TextComponent(
                            text: widget.cardNumVenc.isNotEmpty ? "Venc.    " : "",
                            style: 'cardVenc',
                          ),
                          TextComponent(
                            text: widget.cardNumVenc.isNotEmpty ? widget.cardNumVenc.toString().padLeft(2, '0') : "",
                            style: 'cardNumVenc',
                          )
                        ],
                      ),
                      Row(
                        children: [
                          TextComponent(
                            text: widget.cardNumFinal.isNotEmpty ? "Final " : "",
                            style: 'cardVenc',
                          ),
                          TextComponent(
                            text: widget.cardNumFinal.isNotEmpty ? widget.cardNumFinal : "",
                            style: 'cardNumVenc',
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ]
          ),
        ),
      ),
    );
  }
}