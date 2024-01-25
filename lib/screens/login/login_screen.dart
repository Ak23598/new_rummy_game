
import 'package:flutter/material.dart';
import 'package:rummy_game/screens/login/register_screen.dart';

import '../home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/loginBackground.jpg'),
                  fit: BoxFit.cover)),
          child: Center(
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height - 120,
              width: 300,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(108, 8, 23, 1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: const Color.fromRGBO(252, 160, 54, 1))),
              child: Padding(
                padding: const EdgeInsets.only(right: 25,left: 25),
                child: Column(
                  children: [
                    SizedBox(height: 15,),
                    // Baseline(
                    //   baseline: 35,
                    //   baselineType: TextBaseline.alphabetic,
                    //   child: Container(
                    //     height: 70,
                    //     width: 70,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(8),
                    //      /* image: const DecorationImage(
                    //           image: AssetImage("assets/images/rummyLogo.png"),
                    //           fit: BoxFit.cover),*/
                    //     ),
                    //   ),
                    // ),
                    const Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(252, 160, 54, 1),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: SizedBox(
                        height: 35,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              color: Colors.black
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(right: 10,left: 10,top: 5,bottom: 5),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Enter Mobile Number",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50)
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2, bottom: 8),
                      child: SizedBox(
                        height: 35,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                              color: Colors.black
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(right: 10,left: 10,top: 5,bottom: 5),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Enter Password",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50)
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text("Forget Password ?",style: TextStyle(fontSize: 15,color: Colors.white),)
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Center(
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
                        },
                        child: Container(
                          height: 35,
                          width: 140,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color.fromRGBO(252, 160, 54, 1),
                              border: Border.all(width: 2,color: Colors.white)
                          ),
                          child: const Center(
                            child: Text("Login",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w600),),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have a account? ",style: TextStyle(fontSize: 14,color: Colors.white),),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterScreen()));
                          },
                          child: const Text("Register",style: TextStyle(fontSize: 14,color: Color.fromRGBO(252, 160, 54, 1)),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
