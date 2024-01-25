import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  String? isGender;

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
              height: MediaQuery.of(context).size.height - 5,
              width: 300,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(108, 8, 23, 1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: const Color.fromRGBO(252, 160, 54, 1))),
              child: Padding(
                padding: const EdgeInsets.only(right: 25,left: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Signup",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(252, 160, 54, 1),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.only(top: 2, bottom: 2),
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
                            hintText: "Enter Name",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50)
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 10),
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
                      padding: const EdgeInsets.only(top: 0, bottom: 8),
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
                            hintText: "Password",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50)
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Text("Gender: ",style: TextStyle(color: Colors.white),),
                        Expanded(
                          child: RadioListTile(
                            visualDensity: const VisualDensity(
                              vertical: VisualDensity.minimumDensity,
                              horizontal: VisualDensity.minimumDensity
                            ),
                            contentPadding: const EdgeInsets.all(0),
                            title: const Text("Male",style: TextStyle(fontSize: 14,color: Colors.white),),
                            value: "male",
                            activeColor: Colors.white,
                            groupValue: isGender,
                            onChanged: (value){
                              setState(() {
                                isGender = value.toString();
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            visualDensity: const VisualDensity(
                                vertical: VisualDensity.minimumDensity,
                                horizontal: VisualDensity.minimumDensity
                            ),
                            contentPadding: const EdgeInsets.all(0),
                            title: const Text("Female",style: TextStyle(fontSize: 14,color: Colors.white),),
                            value: "female",
                            activeColor: Colors.white,
                            groupValue: isGender,
                            onChanged: (value){
                              setState(() {
                                isGender = value.toString();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2, bottom: 2),
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
                            hintText: "Enter Referral Code (optional)",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50)
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Center(
                      child: Container(
                        height: 35,
                        width: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: const Color.fromRGBO(252, 160, 54, 1),
                            border: Border.all(width: 2,color: Colors.white)
                        ),
                        child: const Center(
                          child: Text("SignUp",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w600),),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Do you have a account? ",style: TextStyle(fontSize: 14,color: Colors.white),),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: const Text("Login",style: TextStyle(fontSize: 14,color: Color.fromRGBO(252, 160, 54, 1)),),
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
