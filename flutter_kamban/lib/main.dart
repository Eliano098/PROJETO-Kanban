import 'package:flutter/material.dart';
import 'package:flutter_kamban/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCjhaJR4g3bOD2UY3s9gFchNYetUmQSzw0",
      appId: "1:130393503039:web:910e56f1085b128dd74f8a",
      messagingSenderId: "130393503039",
      projectId: "flutterkamban",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Flutter Kamban',
        debugShowCheckedModeBanner: false,
        home: Login());
  }
}
