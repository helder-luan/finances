import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/helpers/functions.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:flutter/material.dart';

class CardMes extends StatefulWidget {
  String? mesReferencia;
  CardMes({super.key, this.mesReferencia});

  @override
  State<CardMes> createState() => _CardMesState();
}

class _CardMesState extends State<CardMes> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide.none,
      ),
      onPressed: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => HistoricoMensal(
        //       mesReferencia: widget.mesReferencia,
        //     ),
        //   ),
        // );
      },
      child: Container(
        width: (MediaQuery.of(context).size.width / 2) - 32,
        margin: const EdgeInsets.only(bottom: 16.0, right: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: int.tryParse(widget.mesReferencia.toString()) == DateTime.now().month ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextComponent(
              text: "Mês",
              color: int.tryParse(widget.mesReferencia.toString()) == DateTime.now().month ? Colors.white : Colors.black,
            ),
            TextComponent(
              text: Functions.fullMonthName(int.tryParse(widget.mesReferencia.toString())!),
              style: 'subtitle',
              color: int.tryParse(widget.mesReferencia.toString()) == DateTime.now().month ? Colors.white : Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}