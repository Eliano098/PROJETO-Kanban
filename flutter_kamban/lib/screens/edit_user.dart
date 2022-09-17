import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_kamban/models/user.dart';

// ignore: must_be_immutable
class EditUser extends StatefulWidget {
  final String auxId;
  final Usuario auxUsuario;
  bool aux = true;
  EditUser({Key? key, required this.auxUsuario, required this.auxId})
      : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

enum Tipo { adm, user }
bool exibe = false;

class _EditUserState extends State<EditUser> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nome = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  Tipo? radiotipo;

  @override
  Widget build(BuildContext context) {
    final _user =
        FirebaseFirestore.instance.collection('usuario').doc(widget.auxId);
    nome.text = widget.auxUsuario.nome;
    email.text = widget.auxUsuario.email;
    senha.text = widget.auxUsuario.senha;
    void _AtualizarDados(Usuario obj) {
      radiotipo = Tipo.values.firstWhere((e) =>
          e.toString() == 'Tipo.${widget.auxUsuario.radiotipo.toLowerCase()}');
    }

    if (widget.aux == true) {
      _AtualizarDados(widget.auxUsuario);
      widget.aux = false;
    }

    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Editar Usuário"),
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
              padding: EdgeInsets.all(20),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.green[50],
              ),
              onPressed: () async {
                await _user.update({
                  "nome": nome.text,
                  "email": email.text,
                  "senha": senha.text,
                  "radiotipo": radiotipo.toString().split(".").last,
                });
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
