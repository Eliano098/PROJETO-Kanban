import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_kamban/models/user.dart';
import 'package:flutter_kamban/screens/create_user.dart';
import 'package:flutter_kamban/screens/edit_user.dart';
import 'package:flutter_kamban/screens/home.dart';

class ListUser extends StatelessWidget {
  final Usuario usuario;
  ListUser({Key? key, required this.usuario}) : super(key: key);

  final CollectionReference _user =
      FirebaseFirestore.instance.collection('usuario');

  Future<void> _deleteProduct(String productId) async {
    await _user.doc(productId).delete(); // Show a snackbar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: const Text('Usuários'),
      ),
      body: StreamBuilder(
        stream: _user.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return ListTile(
                  leading: Icon(Icons.person, color: Colors.green[300]),
                  title: Text(documentSnapshot['nome']),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue[400]),
                        onPressed: () {
                          Usuario usuario = Usuario(
                            documentSnapshot.id,
                            documentSnapshot['nome'],
                            documentSnapshot['email'],
                            documentSnapshot['senha'],
                            documentSnapshot['radiotipo'],
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditUser(
                                        auxUsuario: usuario,
                                        auxId: documentSnapshot.id,
                                      )));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red[400]),
                        onPressed: () {
                          _deleteProduct(documentSnapshot.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Deletado com sucesso!')));
                        },
                      ),
                    ],
                  ),
                  onTap: () {},
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.green[400],
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateUser(
                        usuario: usuario,
                      )));
        },
      ),
    );
  }
}
