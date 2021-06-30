import 'package:flutter/material.dart';
import 'package:payflow/models/extract/extract_page.dart';
import 'package:payflow/models/user_model.dart';
import 'package:payflow/modules/home/home_controller.dart';
import 'package:payflow/modules/meus_boletos/meus_boletos_page.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/services/logged_user/logged_user_singleton.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_widget.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  final authController = AuthController();
  final loggedUser = LoggedUserSingleton();

  final pages = [
    MeusBoletosPage(
      key: UniqueKey(),
    ),
    ExtractPage(
      key: UniqueKey(),
    ),
  ];

  Future<void> _alertDialog() async {
    final option = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Fazer logout do App?'),
            title: Text('Logout'),
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
        await controller.logout(context);
        break;
      case "No":
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(152),
        child: Container(
          height: 152,
          color: AppColors.primary,
          child: Center(
            child: ListTile(
              title: Text.rich(
                TextSpan(
                    text: "Olá, ",
                    style: TextStyles.titleRegularBackground,
                    children: [
                      TextSpan(
                        text: "${widget.user.name}",
                        style: TextStyles.titleBoldBackground,
                      )
                    ]),
              ),
              subtitle: Text(
                "Matenha suas contas em dia",
                style: TextStyles.captionBackground,
              ),
              trailing: PopupMenuButton(
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem(
                    value: 'logout',
                    child: ListTile(
                      leading: Icon(
                        Icons.logout_outlined,
                        color: Colors.red,
                      ),
                      title: Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'voltar',
                    child: ListTile(
                      leading: Icon(
                        Icons.arrow_back_outlined,
                      ),
                      title: Text(
                        "Voltar",
                      ),
                    ),
                  ),
                ],
                offset: Offset(0, 48),
                onSelected: (String result) async {
                  if (result == 'logout') {
                    _alertDialog();
                  }
                },
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: NetworkImage(widget.user.photoURL!)),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: pages[controller.currentPage],
      bottomNavigationBar: Container(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                controller.setPage(0);
                setState(() {});
              },
              icon: Icon(
                Icons.home,
                color: controller.currentPage == 0
                    ? AppColors.primary
                    : AppColors.body,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/insert_boleto').then(
                  (_) => {
                    setState(() {}),
                  },
                );
                // Navigator.pushNamed(context, '/barcode_scanner').then(
                //   (_) => {
                //     setState(() {}),
                //   },
                // );
              },
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(
                  Icons.add_box_outlined,
                  color: AppColors.background,
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  controller.setPage(1);
                  setState(() {});
                },
                icon: Icon(Icons.description_outlined),
                color: controller.currentPage == 1
                    ? AppColors.primary
                    : AppColors.body),
          ],
        ),
      ),
    );
  }
}
