import 'package:auth_project/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget{
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  String email="", password="", name="";

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  registration()async{
    if(password != null && nameController.text != "" && emailController.text != "")
      {
        try{
          UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email,
              password: password
          );
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(userCredential.user!.uid)
              .set({
            "name":name,
            "email":email,
            "createdAt":Timestamp.now(),
          });
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 2),
                content: const Center(child: Text("User Registered",style: TextStyle(fontSize: 17),)),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 50,vertical: 30),
              )
          );
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
        }on FirebaseAuthException catch(e){
          if(e.code=='weak-password'){
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 2),
                  content: const Center(child: Text("Password is too weak",style: TextStyle(fontSize: 17),)),
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 50,vertical: 30),
                )
            );
          }
          else if(e.code == "email-already-in-use"){
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 2),
                  content: const Center(child: Text("An Account already exists with this Email",style: TextStyle(fontSize: 16),)),
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 35,vertical: 30),
                )
            );
          }
        }
      }
  }

  bool _isHidden = true;

  toggleObscure(){
    setState(() {
      if(!_isHidden){
        _isHidden = true;
      }
      else{
        _isHidden = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.asset("assets/images/signup.png",fit: BoxFit.fill,)),

                  const SizedBox(height: 35),

                  const Text("Sign Up",style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),),

                  const SizedBox(height: 30,),

                  TextFormField(
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return "Please enter your name";
                      }
                      else{
                        return null;
                      }
                    },
                    controller: nameController,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        shadows: [
                          Shadow(
                              blurRadius: 1.3
                          )
                        ]
                    ),
                    decoration: InputDecoration(
                        labelText: "FULL NAME",
                        labelStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff757575)
                        ),
                        border: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xff757575),
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Color(0xff757575),
                                width: 2.4
                            )
                        )
                    ),
                  ),

                  const SizedBox(height: 25,),

                  TextFormField(
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return "Please enter your email";
                      }
                      else{
                        return null;
                      }
                    },
                    controller: emailController,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        shadows: [
                          Shadow(
                              blurRadius: 1.3
                          )
                        ]
                    ),
                    decoration: InputDecoration(
                        labelText: "EMAIL ID",
                        labelStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff757575)
                        ),
                        border: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xff757575),
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Color(0xff757575),
                                width: 2.4
                            )
                        )
                    ),
                  ),

                  const SizedBox(height: 25,),

                  TextFormField(
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return "Please enter password";
                      }
                      else{
                        return null;
                      }
                    },
                    controller: passController,
                    obscureText: _isHidden,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        wordSpacing: 5,
                        shadows: [
                          Shadow(
                              blurRadius: 1.3
                          )
                        ]
                    ),
                    decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: IconButton(
                              onPressed: (){
                                toggleObscure();
                              },
                              icon: _isHidden?const Icon(CupertinoIcons.eye_slash,size: 25,):const Icon(CupertinoIcons.eye,size: 25,)),
                        ),
                        labelText: "PASSWORD",
                        labelStyle: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff757575)
                        ),
                        border: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xff757575),
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Color(0xff757575),
                                width: 2.4
                            )
                        )
                    ),
                  ),

                  const SizedBox(height: 25,),

                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                          onPressed: (){
                            if(_formKey.currentState!.validate())
                            {
                              setState(() {
                                name = nameController.text;
                                email = emailController.text;
                                password = passController.text;
                              });
                            }
                            registration();
                          },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xff0063E6),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11))
                        ),
                          child: const Text("Create Account",style: TextStyle(fontSize: 19),),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?",style: TextStyle(
                        color: Color(0xff696F77),
                        fontSize: 18
                      ),),

                      const SizedBox(width: 7,),

                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: const Text("Sign In",style: TextStyle(
                          color: Color(0xff0063E6),
                          fontSize: 19,
                          wordSpacing: -2,
                          shadows: [Shadow(blurRadius: 2,color: Color(0xff575757))]
                        ),),
                      )
                    ],
                  )

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}