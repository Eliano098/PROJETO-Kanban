import 'package:flutter/material.dart';
import 'package:flutter_kamban/models/task.dart';
import 'package:flutter_kamban/models/user.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AcceptTask extends StatefulWidget {
  final Task tarefa;
  final Usuario usuario;

  const AcceptTask({
    Key? key,
    required this.tarefa,
    required this.usuario,
  }) : super(key: key);

  @override
  State<AcceptTask> createState() => _AcceptTaskState();
}

class _AcceptTaskState extends State<AcceptTask> {
  @override
  Widget build(BuildContext context) {
    String dataatual = "";
    DateTime data = DateTime.now();
    dataatual = DateFormat("dd/MM/yyyy").format(data).toString();

    final _task =
        FirebaseFirestore.instance.collection('task').doc(widget.tarefa.id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: Text(widget.tarefa.titulo),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column(
              children: <Widget>[
                const Center(
                  child: Text(
                    'Descrição',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(20)),
                Text(
                  widget.tarefa.descricao,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 15),
                ),
                const Padding(padding: EdgeInsets.all(20)),
                Text(
                  "Data de Criação: ${widget.tarefa.data}",
                  style: const TextStyle(
                      fontStyle: FontStyle.normal, fontSize: 20),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Realizada por: ${widget.tarefa.responsavel != "" ? widget.tarefa.responsavel : "Disponível"}",
                  style: TextStyle(
                      color: widget.tarefa.responsavel != ""
                          ? Colors.green
                          : Colors.red,
                      fontSize: 15),
                ),
                Text(
                  "Data de Entrega: ${widget.tarefa.prazo}",
                  style: TextStyle(
                      color: widget.tarefa.prazo.compareTo(dataatual) > 0
                          ? Colors.green
                          : Colors.red,
                      fontSize: 15),
                ),
                const Padding(
                  padding: EdgeInsets.all(20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.tarefa.responsavel == "") ...[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue, onPrimary: Colors.green[50]),
                        onPressed: () async {
                          await _task.update({
                            'titulo': widget.tarefa.titulo,
                            'descricao': widget.tarefa.descricao,
                            'data': widget.tarefa.data,
                            'realizado': widget.tarefa.realizado,
                            'prazo': widget.tarefa.prazo,
                            'responsavel': widget.usuario.id
                          });
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: Icon(
                            Icons.check_circle_outline_sharp,
                            size: 40,
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(20)),
                    ],
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red, onPrimary: Colors.green[50]),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: Icon(
                          Icons.arrow_back_sharp,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
