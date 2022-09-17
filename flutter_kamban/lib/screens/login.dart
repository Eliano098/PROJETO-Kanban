import 'package:flutter/material.dart';
import 'package:flutter_kamban/models/user.dart';
import 'package:flutter_kamban/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

final CollectionReference _user =
    FirebaseFirestore.instance.collection('usuario');

class _LoginState extends State<Login> {
  List<Usuario> usuarios = [];
  // ignore: prefer_typing_uninitialized_variables
  var usuariolog;
  bool exibe = false;
  TextEditingController nome = TextEditingController();
  TextEditingController senha = TextEditingController();

  bool _validacao(String email, String senha) {
    for (int i = 0; i < usuarios.length; i++) {
      if (usuarios[i].email == email) {
        if (usuarios[i].senha == senha) {
          usuariolog = usuarios[i];
          return true;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: _user.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                const Text('Carregando');
              } else {
                for (int i = 0; i < snapshot.data!.docs.length; i++) {
                  DocumentSnapshot snap = snapshot.data!.docs[i];
                  usuarios.add(
                    Usuario(
                      snap.id,
                      snap['nome'],
                      snap['email'],
                      snap['senha'],
                      snap['radiotipo'],
                    ),
                  );
                }
              }
              return const Padding(padding: EdgeInsets.all(20));
            },
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              'images/logo.png',
              height: 200,
              width: 400,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
            child: TextFormField(
              controller: nome,
              decoration: const InputDecoration(
                labelText: 'Nome',
                hintText: '...',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(80, 10, 80, 50),
            child: TextFormField(
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
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              onPrimary: Colors.pink[50],
            ),
            onPressed: () {
              if (_validacao(nome.text, senha.text)) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(
                      usuario: usuariolog,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    'Email ou senha incorretos',
                    style: TextStyle(fontSize: 16),
                  ),
                ));
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Entrar',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
