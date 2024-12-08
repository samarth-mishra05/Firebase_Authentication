import 'package:auth_project/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget{
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  String email="";

  TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  resetPassword()async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: email
      );
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
            content: const Center(child: Text("Password Reset Email has been sent !",style: TextStyle(fontSize: 17),)),
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 50,vertical: 30),
          )
      );
    }on FirebaseAuthException catch(e){
      if(e.code == "user-not-found"){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 2),
              content: const Center(child: Text("No user found for that Email",style: TextStyle(fontSize: 17),)),
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 50,vertical: 30),
            )
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text("Forgot Password ?",style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),),
              ),

              const SizedBox(height: 15,),

              const Text("No worries, we'll send you reset instructions.",style: TextStyle(
                color: Color(0xff757575),
                fontSize: 17,
              ),),

              const SizedBox(height: 40,),

              TextFormField(
                controller: emailController,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Please Enter Email";
                  }
                  else{
                    return null;
                  }
                },
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      wordSpacing: 5,
                      shadows: [
                      Shadow(
                      blurRadius: 1.3
                  ),
                ],
                  ),
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  label: const Text("EMAIL"),
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold,color: Color(0xff757575),fontSize: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xff757575))
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xff757575),
                      width: 2.4,
                    ),
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),

              const SizedBox(height: 25,),

              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate())
                        {
                          setState(() {
                            email = emailController.text;
                          });
                          resetPassword();
                        }
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xff0063E6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11))
                    ),
                    child: const Text("Reset Password",style: TextStyle(fontSize: 19),),
                  ),
                ),
              ),

              const SizedBox(height: 30,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?",style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff575757)
                  ),),

                  const SizedBox(width: 10,),

                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUp(),));
                    },
                    child: const Text("Sign Up",style: TextStyle(
                        fontSize: 18,
                        wordSpacing: -2,
                        shadows: [Shadow(blurRadius: 2,color: Color(0xff575757))],
                        color: Color(0xff0063E6)
                    ),),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}