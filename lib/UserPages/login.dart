
import 'package:eproject/admin/Users/user_controller.dart';
import 'package:eproject/admin/Users/user_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userPassword = TextEditingController();
  UserRegisterLogin userRegisterLogin = UserRegisterLogin();
  bool isContainerClicked = true; // Display shadow by default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          top: true,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "Login.",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: userEmail,
                            style: const TextStyle(color: Colors.white), // Set text color to white
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Iconsax.message, color: Colors.white),
                              hintText: "Enter Your Email..",
                              hintStyle: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12), // Set hint text color to white with opacity
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: userPassword,
                            obscureText: true,
                            style: const TextStyle(color: Colors.white), // Set text color to white
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Iconsax.key1, color: Colors.white),
                              hintText: "Enter Your Password..",
                              hintStyle: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12), // Set hint text color to white with opacity
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            userRegisterLogin.userLogin(
                              LoginModel(
                                userEmail: userEmail.text,
                                userPassword: userPassword.text,
                              ),
                              context,
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                return states.contains(MaterialState.disabled) ? Colors.grey : Colors.white;
                              },
                            ),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),



                  const SizedBox(
                    height: 10,
                  ),


                  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen(),));
                      },
                      child: const Text("Don't have an Account. Create One.", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),)),



                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
