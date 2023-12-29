import 'package:flutter/material.dart';
import 'package:test_flutter/src/pages/home.dart';
import 'package:test_flutter/src/widgets/button_widget.dart';
import 'package:test_flutter/src/widgets/input_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static final  validCharacters = RegExp(r'^[a-zA-Z0-9]+$');
  final Uri _url = Uri.parse('https://google.com.br');
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  void submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => const Home())
      );
    }
  }

  String? validateText (text) {
    if (text == null || text.isEmpty) {
      return 'Não pode ser vazio, digite algo para continuar';
    }
    if (text.length < 2 || text.length > 20) {
      return 'Tamanho não válido, digite algo entre 2-20 digitos';
    }
    if(!validCharacters.hasMatch(text)){
      return 'Não use caracter especial ou espaços vazios';
    }
    return null;
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Usuário',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15
                    ),
                  ),
                ),
                InputWidget(
                  validator: validateText,
                  onChanged: (text) => setState(() => _username = text!),
                  prefixIcon: const Icon(Icons.person),
                ),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Senha',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15
                    ),
                  ),
                ),
                InputWidget(
                  validator: validateText,
                  onChanged: (text) => setState(() => _password = text!),
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: ButtonWidget(
                      onPressed: submit,
                      isEnabled: _username.isNotEmpty && _password.isNotEmpty, 
                      child: const Text(
                        'Entrar',
                        style: TextStyle(fontSize: 16),
                      )
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    onPressed: () async{
                      if (!await launchUrl(_url)) {
                        throw Exception('Could not launch $_url');
                      }
                    },
                    child: const Text(
                      'Política de Privacidade',
                       style: TextStyle(color: Colors.white)
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}