import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_kamban/models/user.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreateTask extends StatefulWidget {
  final Usuario usuario;
  const CreateTask({Key? key, required this.usuario}) : super(key: key);

  @override
  CreateTaskFormState createState() {
    return CreateTaskFormState();
  }
}

final CollectionReference _task = FirebaseFirestore.instance.collection('task');

class CreateTaskFormState extends State<CreateTask> {
  final _formKey = GlobalKey<FormState>();

  bool realizado = false;
  TextEditingController titulo = TextEditingController();
  TextEditingController descricao = TextEditingController();
  TextEditingController responsavel = TextEditingController();
  TextEditingController prazo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Cadastrar Atividade"),
          backgroundColor: Colors.green[500],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(60, 20, 60, 0),
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              ),
              TextFormField(
                controller: titulo,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo Obrigatório';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: '...',
                  labelText: 'Título',
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              ),
              TextFormField(
                controller: descricao,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo Obrigatório';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: '...',
                  labelText: 'Descrição',
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              ),
              TextFormField(
                controller: prazo,
                decoration: const InputDecoration(
                  hintText: '...',
                  labelText: 'Data Entrega',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo Obrigatório';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                inputFormatters: [
                  MaskTextInputFormatter(
                      mask: '##/##/####',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy)
                ],
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[400],
                  onPrimary: Colors.green[50],
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Validando')),
                    );
                    String datageracao = "";
                    DateTime data = DateTime.now();
                    datageracao =
                        DateFormat("dd/MM/yyyy").format(data).toString();
                    await _task.add({
                      "titulo": titulo.text,
                      "descricao": descricao.text,
                      "responsavel": responsavel.text,
                      "realizado": realizado,
                      "data": datageracao,
                      "prazo": prazo.text,
                    });
                    Navigator.pop(context);
                  }
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
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
