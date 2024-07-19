import 'dart:async';
import 'package:eproject/admin/Users/user_controller.dart';
import 'package:eproject/login.dart';
import 'package:eproject/user_dashboard.dart';
import 'package:flutter/material.dart';



class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {



  @override
  void initState() {
    // TODO: implement initState
    UserRegisterLogin.userCredGet().then((val){
      if(val != null){
        Timer(const Duration(milliseconds: 2000), () => Navigator.push(context,MaterialPageRoute(builder: (context) => const UserDashBoard(),)),);
      }
      else{
        Timer(const Duration(milliseconds: 2000), () => Navigator.push(context,MaterialPageRoute(builder: (context) => const LoginScreen(),)),);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
       backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 400,
          height: 400,
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage('images/Logo.png',)),
          ),
        ),
      ),
    );
  }
}