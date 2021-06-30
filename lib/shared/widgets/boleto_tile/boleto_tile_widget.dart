import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:payflow/models/boleto_model.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/boleto_tile/boleto_tile_controller.dart';

class BoletoTileWidget extends StatelessWidget {
  final BoletoModel data;
  final BuildContext context;
  final BoletoTileController controller;

  const BoletoTileWidget(
      {Key? key,
      required this.data,
      required this.context,
      required this.controller})
      : super(key: key);

  Future<void> _alertDialog() async {
    final option = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Confirma exclusão do boleto?'),
            title: Text('Excluir boleto'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, "no");
                },
                child: const Text('Não'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, "yes");
                },
                child: const Text('Sim'),
              ),
            ],
          );
        });
    switch (option) {
      case "yes":
        await controller.deleteBoleto(data);
        break;
      case "No":
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      direction: AnimatedCardDirection.right,
      child: ListTile(
        onLongPress: () async {
          _alertDialog();
        },
        contentPadding: EdgeInsets.zero,
        title: Text(
          data.name!,
          style: TextStyles.titleListTile,
        ),
        subtitle: Text(
          "Vence em ${data.dueDate}",
          style: TextStyles.captionBody,
        ),
        trailing: Text.rich(
          TextSpan(text: "R\$", style: TextStyles.trailingRegular, children: [
            TextSpan(
              text: "${data.value!.toStringAsFixed(2)}",
              style: TextStyles.trailingBold,
            ),
          ]),
        ),
      ),
    );
  }
}
