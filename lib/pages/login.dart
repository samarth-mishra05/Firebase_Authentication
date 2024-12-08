import 'package:auth_project/pages/forgetpassword.dart';
import 'package:auth_project/pages/home.dart';
import 'package:auth_project/pages/signup.dart';
import 'package:auth_project/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget{
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  String email = "", password = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final _formKey=GlobalKey<FormState>();

  bool _isHidden = true;

  toggleObscure(){
  setState(() {
    if(!_isHidden)
      {
        _isHidden = true;
      }
    else{
      _isHidden = false;
    }
    });
  }

  userLogin()async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
    }on FirebaseAuthException catch(e){

      String errorMessage = "Invalid Login Credentials";

      if(e.code == "user-not-found"){
       errorMessage = "User not found with this Email";
      }
      else if(e.code == "invalid-email"){
        errorMessage = "Invalid E-mail Address";
      }
      else if(e.code == "wrong-password"){
        errorMessage = "Wrong Password";
      }
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
            content: Center(
                child: Text(errorMessage,
              style: const TextStyle(fontSize: 18,color: Colors.white),)),
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 50,vertical: 30),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset("assets/images/login.png",fit: BoxFit.fill,height: 250,width: 280,)),

                const SizedBox(height: 40),

                const Text("Log In",style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.w800
                  ),
                ),

                const SizedBox(height: 30,),

                TextFormField(
                  controller: emailController,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Please enter your E-mail";
                    }
                    else{
                      return null;
                    }
                  },
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

                const SizedBox(height: 30,),

                TextFormField(
                  controller: passController,
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return "Please enter password";
                    }
                    else{
                      return null;
                    }
                  },
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

                const SizedBox(height: 17,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPassword(),));
                      },
                      child: const Text("Forget Password ?",style: TextStyle(
                        color: Color(0xff0063E6),
                        fontSize: 19,
                        shadows: [Shadow(blurRadius: 1.3,color: Color(0xff0063E6))]
                      ),),
                    ),
                  ],
                ),

                const SizedBox(height: 20,),

                Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
                        backgroundColor: const Color(0xff0063E6),
                        foregroundColor: Colors.white
                      ),
                        onPressed: (){
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            email = emailController.text;
                            password = passController.text;
                          });
                        }
                        userLogin();
                        },
                        child: const Text("Login",style: TextStyle(fontSize: 20),)
                    ),
                  ),
                ),

                const SizedBox(height: 20,),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Divider(thickness: 2.5,)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text("Or",style: TextStyle(fontSize: 20),),
                    ),
                    Expanded(child: Divider(thickness: 2.5,))
                  ],
                ),

                const SizedBox(height: 20,),

                Center(
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      iconAlignment: IconAlignment.end,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        foregroundColor: const Color(0xff575757),
                      ),
                    onPressed: (){
                      AuthMethods().signInWithGoogle(context);
                    },
                    label:const Text("Continue with Google",style: TextStyle(fontSize: 22,),),
                      icon: Image.asset("assets/images/google.png",height: 44,width: 44,)
                    ),
                  ),
                ),

                const SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?",style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff575757)
                    ),),

                    const SizedBox(width: 10,),

                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUp(),));
                      },
                      child: const Text("Sign Up",style: TextStyle(
                        fontSize: 20,
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
        ]
        ),
      ),
    );
  }
}