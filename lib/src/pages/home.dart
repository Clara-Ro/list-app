
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:test_flutter/src/controllers/home_controller.dart';
import 'package:test_flutter/src/widgets/button_widget.dart';
import 'package:test_flutter/src/widgets/card.dart';
import 'package:test_flutter/src/widgets/card_delete_dialog.dart';
import 'package:test_flutter/src/widgets/card_editing_dialog.dart';
import 'package:test_flutter/src/widgets/input_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  final Uri url = Uri.parse('https://google.com.br');
  final formKey = GlobalKey<FormState>();
  String note= '';
  final HomeController controller = HomeController();
  
  @override
  void initState() {
    super.initState();
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.3, 0.9],
            colors: [
              Color(0xff1f5466),
              Color(0xff2d958e)
            ]
          )
        ),
        child: Container(
          padding: const EdgeInsets.symmetric( horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: FractionallySizedBox(
                  heightFactor: 0.6,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(4))
                    ),
                    child: Observer(
                      builder: (context) {
                        return ListView.separated(
                          padding: const EdgeInsets.all(8),
                          itemCount: controller.items.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (BuildContext context, int index){
                            String text = controller.items[index];
                            return CardWidget(
                              text: text, 
                              index: index, 
                              openDeleteDialog: (){
                                showDialog(
                                  context: context, 
                                  builder: (BuildContext context) => CardDeleteDialog(
                                    deleteItem: controller.deleteItem, 
                                    index: index
                                  )
                                );
                              },
                              openEditDialog: (){
                                controller.editingController.text = text;
                                showDialog(
                                  context: context, 
                                  builder: (BuildContext context) => Observer(
                                    builder: (context) {
                                      return CardEditingDialog(
                                        editItem: controller.editItem, 
                                        editingController: controller.editingController, 
                                        index: index, 
                                        isEditingEnabled: controller.isEditingEnabled,
                                        validateEditing: (_) => controller.validateEditing()
                                      );
                                    }
                                  )
                                );
                              },
                            );
                          }
                        );
                      }
                    ),
                  ),
                ),
              ),
              Form(
                key: formKey,
                child: InputWidget(
                  textController: controller.textController,
                  focusNode: controller.focusNode,
                  onChanged: (_) => controller.validateText(),
                  hintText: 'Digite seu texto',
                )
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30),
                alignment: Alignment.center,
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: Observer(
                    builder: (context) {
                      return ButtonWidget(
                        onPressed:(){
                          controller.addItem();
                        },
                        isEnabled: controller.isAddEnabled,
                        child: const Text(
                          'Adicionar',
                          style: TextStyle(fontSize: 16),
                        )
                      );
                    }
                  ),
                ),
              ), 
              Container(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  onPressed: () async{
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                    }
                  },
                  child: const Text(
                    'Política de Privacidade',
                      style: TextStyle(color: Colors.white)
                  ),
                )
              )
            ]
          ),
        ),
      ),
    );
  }
}