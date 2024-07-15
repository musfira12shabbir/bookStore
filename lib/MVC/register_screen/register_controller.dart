import 'package:eproject/MVC/register_screen/register_model.dart';
import 'package:eproject/login.dart';
import 'package:eproject/user_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRegisterLogin{


  void userRegister(RegisterModel regModel, BuildContext context)async{
    try{
     await FirebaseAuth.instance.createUserWithEmailAndPassword(email: regModel.userEmail!, password: regModel.userPassword!);

      FirebaseFirestore.instance.collection("userData").doc().set({
        "uID" : regModel.userID,
        "uName" : regModel.userName,
        "uEmail" : regModel.userEmail,
        "uAddress" : regModel.userAddress,
        "uPassword" : regModel.userPassword,
        "uAge" : regModel.userAge,
      });
      if(context.mounted){
        Navigator.push(context, MaterialPageRoute(builder:  (context) => const LoginScreen(),));
      }
    } on FirebaseAuthException catch(ex){
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went Wrong"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
      }
    }
  }


  void userLogin(LoginModel logModel, BuildContext context)async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: logModel.userEmail!, password: logModel.userPassword!);
      SharedPreferences userCred = await SharedPreferences.getInstance();
      userCred.setString("email", logModel.userEmail!);
      if(context.mounted){
        Navigator.push(context, MaterialPageRoute(builder:  (context) => const UserDashBoard(),));
      }
    } on FirebaseAuthException catch (ex) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went Wrong"),
          backgroundColor: Colors.red,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          behavior: SnackBarBehavior.floating,));
      }
    }
  }

  void userLogout(BuildContext context)async{
    await FirebaseAuth.instance.signOut();
    SharedPreferences userCred = await SharedPreferences.getInstance();
    userCred.clear();
    if(context.mounted){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
    }
  }

  static Future userCredGet()async{
    SharedPreferences userCred = await SharedPreferences.getInstance();
    var uEmail = userCred.getString("email");
    return uEmail;
  }

}