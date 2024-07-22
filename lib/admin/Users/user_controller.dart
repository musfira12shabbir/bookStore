import 'package:eproject/admin/Users/user_model.dart';
import 'package:eproject/login.dart';
import 'package:eproject/user_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRegisterLogin{


  void userRegister(UserModel userModel, BuildContext context)async{
    try{
      if(userModel.userImageWeb != null){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: userModel.userEmail!, password: userModel.userPassword!);

        UploadTask uploadTask =  FirebaseStorage.instance.ref().child("userImages").child(userModel.userID!).putData(userModel.userImageWeb!);
        TaskSnapshot taskSnapshot = await uploadTask;
        String userImage = await taskSnapshot.ref.getDownloadURL();

        FirebaseFirestore.instance.collection("userData").doc(userModel.userID).set({
          "uID" : userModel.userID,
          "uName" : userModel.userName,
          "uImage" : userImage,
          "uEmail" : userModel.userEmail,
          "uAddress" : userModel.userAddress,
          "uPassword" : userModel.userPassword,
          "uAge" : userModel.userAge,
        });
        if(context.mounted){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registration Successful"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
          Navigator.push(context, MaterialPageRoute(builder:  (context) => const LoginScreen(),));
        }
      }
      else if(userModel.userImage != null){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: userModel.userEmail!, password: userModel.userPassword!);

        UploadTask uploadTask = FirebaseStorage.instance.ref().child("userImages").child(userModel.userID!).putFile(userModel.userImage!);
        TaskSnapshot taskSnapshot = await uploadTask;
        String userImage = await taskSnapshot.ref.getDownloadURL();

        FirebaseFirestore.instance.collection("userData").doc(userModel.userID).set({
          "uID" : userModel.userID,
          "uName" : userModel.userName,
          "uImage" : userImage,
          "uEmail" : userModel.userEmail,
          "uAddress" : userModel.userAddress,
          "uPassword" : userModel.userPassword,
          "uAge" : userModel.userAge,
        });
        if(context.mounted){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registration Successful"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
          Navigator.push(context, MaterialPageRoute(builder:  (context) => const LoginScreen(),));
        }
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Image not picked"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
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
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Login Successful"),
          backgroundColor: Colors.green,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          behavior: SnackBarBehavior.floating,));
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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Logout Successful"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
    }
  }

  static Future userCredGet()async{
    SharedPreferences userCred = await SharedPreferences.getInstance();
    var uEmail = userCred.getString("email");
    return uEmail;
  }

  Stream<List<UserModel>> getUser(String? uEmail){
    return FirebaseFirestore.instance.collection("userData").where('uEmail',isEqualTo: uEmail).snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        Map<String, dynamic> data = doc.data();
        return UserModel(
            userName: data['uName'],
          userPassword: data['uPassword'],
          userEmail: data['uEmail'],
          userAddress: data['uAddress'],
          userAge: data['uAge'],
          userID: data['uID'],
          getImage: data['uImage']
        );
      }).toList();
    });
  }

  void userUpdate(UserModel userModel, BuildContext context)async{
    try{
      if(userModel.userImageWeb != null){
        FirebaseStorage.instance.refFromURL(userModel.getImage!).delete();
        UploadTask uploadTask =  FirebaseStorage.instance.ref().child("userImages").child(userModel.userID!).putData(userModel.userImageWeb!);
        TaskSnapshot taskSnapshot = await uploadTask;
        String userImage = await taskSnapshot.ref.getDownloadURL();

        FirebaseFirestore.instance.collection("userData").doc(userModel.userID).update({
          "uName" : userModel.userName,
          "uImage" : userImage,
          "uEmail" : userModel.userEmail,
          "uAddress" : userModel.userAddress,
          "uPassword" : userModel.userPassword,
          "uAge" : userModel.userAge,
        });
        if(context.mounted){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Update Successful"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
          Navigator.push(context, MaterialPageRoute(builder:  (context) => const LoginScreen(),));
        }
      }
      else if(userModel.userImage != null){

        FirebaseStorage.instance.refFromURL(userModel.getImage!).delete();
        UploadTask uploadTask = FirebaseStorage.instance.ref().child("userImages").child(userModel.userID!).putFile(userModel.userImage!);
        TaskSnapshot taskSnapshot = await uploadTask;
        String userImage = await taskSnapshot.ref.getDownloadURL();

        FirebaseFirestore.instance.collection("userData").doc(userModel.userID).update({
          "uName" : userModel.userName,
          "uImage" : userImage,
          "uEmail" : userModel.userEmail,
          "uAddress" : userModel.userAddress,
          "uPassword" : userModel.userPassword,
          "uAge" : userModel.userAge,
        });
        if(context.mounted){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Update Successful"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
          Navigator.push(context, MaterialPageRoute(builder:  (context) => const LoginScreen(),));
        }
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Image not picked"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
      }
    } on FirebaseAuthException catch(ex){
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went Wrong"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
      }
    }

  }

  void userDelete(String? userID, String? userImage, BuildContext context)async{
    try{
      await FirebaseStorage.instance.refFromURL(userImage!).delete();
      await FirebaseAuth.instance.currentUser!.delete();
      await FirebaseFirestore.instance.collection("userData").doc(userID).delete();

      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Account Deleted Successfully"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
      }

    }catch(ex){
     if(context.mounted){
       ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Something went wrong $ex"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
       Navigator.pop(context);
     }
    }
  }

}