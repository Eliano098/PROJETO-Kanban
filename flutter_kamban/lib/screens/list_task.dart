import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_kamban/models/task.dart';
import 'package:flutter_kamban/models/user.dart';
import 'package:flutter_kamban/screens/accept_task.dart';

class ListTask extends StatelessWidget {
  final Usuario usuario;
  ListTask({Key? key, required this.usuario}) : super(key: key);

  final CollectionReference _task =
      FirebaseFirestore.instance.collection('task');

  Future<void> _deleteTask(String taskId) async {
    await _task.doc(taskId).delete(); // Show a snackbar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: const Text('Atividades'),
      ),
      body: StreamBuilder(
        stream: _task.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                bool aux = documentSnapshot['realizado'];
                return ListTile(
                  leading: Icon(Icons.book, color: Colors.green[300]),
                  title: Text(documentSnapshot['titulo']),
                  subtitle: Text(documentSnapshot['prazo']),
                  onTap: () {
                    Task tarefa = Task(
                        documentSnapshot.id,
                        documentSnapshot['titulo'],
                        documentSnapshot['descricao'],
                        documentSnapshot['data'],
                        documentSnapshot['prazo'],
                        documentSnapshot['responsavel'],
                        documentSnapshot['realizado']);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AcceptTask(
                                  tarefa: tarefa,
                                  usuario: usuario,
                                )));
                  },
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: [
                      IconButton(
                        icon: aux
                            ? const Icon(Icons.check_box)
                            : const Icon(Icons.check_box_outlined),
                        color: Colors.green,
                        onPressed: () {},
                      ),
                      if (usuario.radiotipo == 'adm') ...[
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red[400]),
                          onPressed: () {
                            _deleteTask(documentSnapshot.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Deletado com sucesso!')));
                          },
                        ),
                      ],
                    ],
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
