import 'package:flutter/material.dart';
import 'package:flutter_kamban/models/user.dart';
import 'package:flutter_kamban/screens/create_task.dart';
import 'package:flutter_kamban/screens/list_my_task.dart';
import 'package:flutter_kamban/screens/list_task.dart';
import 'package:flutter_kamban/screens/list_user.dart';

class Home extends StatefulWidget {
  final Usuario usuario;
  const Home({Key? key, required this.usuario}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: size.height * .3,
            decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage(''),
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'images/home.png',
                              height: 50,
                              width: 50,
                            ),
                            const Center(
                              child: Text(
                                'Task Organization',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.power_settings_new_rounded),
                          color: Colors.green[600],
                          iconSize: 30,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 80, 40, 0),
                      child: Center(
                        child: Column(
                          children: [
                            if (widget.usuario.radiotipo != "user") ...[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    onPrimary: Colors.green[50]),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ListUser(
                                                usuario: widget.usuario,
                                              )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      147, 20, 147, 20),
                                  child: Column(
                                    children: const <Widget>[
                                      Icon(
                                        Icons.person,
                                        size: 80,
                                      ),
                                      Text(
                                        'Usuários',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    onPrimary: Colors.green[50]),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CreateTask(
                                        usuario: widget.usuario,
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      100, 20, 100, 20),
                                  child: Column(
                                    children: const <Widget>[
                                      Icon(
                                        Icons.add,
                                        size: 80,
                                      ),
                                      Text(
                                        'Cadastrar Atividade',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                              ),
                            ],
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  onPrimary: Colors.green[50]),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ListTask(
                                      usuario: widget.usuario,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(100, 20, 100, 20),
                                child: Column(
                                  children: const <Widget>[
                                    Icon(
                                      Icons.search,
                                      size: 80,
                                    ),
                                    Text(
                                      'Consultar Atividade',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  onPrimary: Colors.green[50]),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ListMyTask(
                                              usuario: widget.usuario,
                                            )));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(105, 20, 105, 20),
                                child: Column(
                                  children: const <Widget>[
                                    Icon(
                                      Icons.book,
                                      size: 80,
                                    ),
                                    Text(
                                      'Minhas Atividades',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
