import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_kamban/models/user.dart';

class CreateUser extends StatefulWidget {
  final Usuario usuario;
  const CreateUser({Key? key, required this.usuario}) : super(key: key);

  @override
  State<CreateUser> createState() => _CreateUserState();
}

final CollectionReference _user =
    FirebaseFirestore.instance.collection('usuario');

enum Tipo { adm, user }
bool exibe = false;
bool agree = false;

class _CreateUserState extends State<CreateUser> {
  Tipo? radiotipo = Tipo.user;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nome = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Cadastrar Usuário"),
          backgroundColor: Colors.green[500],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(60, 20, 60, 0),
          child: ListView(children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<Tipo>(
                  value: Tipo.adm,
                  groupValue: radiotipo,
                  onChanged: ((Tipo? value) {
                    setState(() {
                      radiotipo = value;
                    });
                  }),
                  activeColor: Colors.green[300],
                ),
                const Text('Administrador'),
                Radio<Tipo>(
                  value: Tipo.user,
                  groupValue: radiotipo,
                  onChanged: ((Tipo? value) {
                    setState(() {
                      radiotipo = value;
                    });
                  }),
                  activeColor: Colors.green[300],
                ),
                const Text('Usuário'),
              ],
            ),
            TextFormField(
              controller: nome,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Obrigatório';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: '...',
                labelText: 'Nome Completo',
              ),
            ),
            TextFormField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                bool A = false;
                int point = 0;
                for (int i = 0; i < value.toString().length; i++) {
                  if (A == false && value.toString()[i] == '@') {
                    for (int j = i; j < value.toString().length; j++) {
                      if (value.toString()[j] == '.' &&
                          (i < value.toString().length - 2 ||
                              i < value.toString().length - 3)) {
                        point++;
                        if (point == 1) A = true;
                      }
                    }
                  }
                }
                if (value == null || value.isEmpty || A == false) {
                  return 'Campo Obrigatório';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'email@gmail.com',
                labelText: 'E-mail',
              ),
            ),
            TextFormField(
              controller: senha,
              decoration: InputDecoration(
                labelText: 'Senha',
                hintText: '...',
                suffixIcon: GestureDetector(
                  child: Icon(
                      exibe == false ? Icons.visibility_off : Icons.visibility,
                      color: Colors.green),
                  onTap: () {
                    setState(() {
                      exibe = !exibe;
                    });
                  },
                ),
              ),
              obscureText: exibe == false ? true : false,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  onChanged: (_) {
                    setState(() {
                      agree = !agree;
                    });
                  },
                  value: agree,
                ),
                const Flexible(
                  child:
                      Text('Termos e Condições e a Política de Privacidade.'),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(20),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.green[50],
              ),
              onPressed: () async {
                await _user.add({
                  "nome": nome.text,
                  "email": email.text,
                  "senha": senha.text,
                  "radiotipo": radiotipo.toString().split(".").last,
                });
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Salvar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
