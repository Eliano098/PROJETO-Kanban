import 'package:flutter/material.dart';
import 'package:flutter_kamban/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListMyTask extends StatelessWidget {
  final Usuario usuario;
  ListMyTask({Key? key, required this.usuario}) : super(key: key);

  final _task = FirebaseFirestore.instance.collection('task');

  Stream<QuerySnapshot> getStream(String id) {
    return _task.where('responsavel', isEqualTo: id).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: const Text('Minhas Atividades'),
      ),
      body: StreamBuilder(
        stream: getStream(usuario.id),
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
                  onTap: () {},
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: [
                      IconButton(
                        icon: aux
                            ? const Icon(Icons.check_box)
                            : const Icon(Icons.check_box_outlined),
                        color: documentSnapshot['realizado']
                            ? Colors.green
                            : Colors.red,
                        onPressed: () async {
                          final _obj = FirebaseFirestore.instance
                              .collection('task')
                              .doc(documentSnapshot.id);
                          await _obj.update({
                            "realizado": !documentSnapshot['realizado'],
                          });
                        },
                      ),
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
