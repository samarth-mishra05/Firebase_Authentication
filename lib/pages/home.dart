import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final user = FirebaseAuth.instance.currentUser!;

  signOut()async{
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
              signOut();
              Navigator.pop(context);
            },
           icon: const Icon(Icons.logout),
          )
        ],
        centerTitle: true,
        title: const Text("Home",style: TextStyle(fontSize: 26)),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Hello, ",style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),),
            Text("${user.email}",style: const TextStyle(
              color: Colors.white,
              fontSize: 21
            ),),
          ],
        ),
      )
    );
  }
}