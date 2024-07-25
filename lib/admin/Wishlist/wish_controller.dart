
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eproject/admin/Wishlist/wish_model.dart';
import 'package:flutter/material.dart';

class WishController{

  final wishCollection = FirebaseFirestore.instance.collection("Wishlist");

  void wishAdd(WishModel wishModel, BuildContext context)async{

    try{
      Map<String, dynamic> wishData = {
        "wishID" : wishModel.wishID,
        "bookID" : wishModel.bookID!,
        "bookName" : wishModel.bookName!,
        "bookImage" : wishModel.bookImage!,
        "userEmail" : wishModel.userEmail!,
      };

      wishCollection..doc(wishModel.wishID).set(wishData);
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Book Added to Wishlist"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
      }
    } catch (ex){
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
      }
    }

  }

  Stream<List<WishModel>> wishFetch(String? userEmail){
    return wishCollection.where('userEmail',isEqualTo: userEmail).snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        Map<String, dynamic> wishData = doc.data();
        return WishModel(
            wishID: wishData['wishID'],
            bookID: wishData['bookID'],
            bookImage: wishData['bookImage'],
            bookName: wishData['bookName'],
            userEmail: wishData['userEmail']
        );
      }).toList();
    });
  }

  void wishDelete(String? wishID, BuildContext context)async{

    try{
      await wishCollection.doc(wishID).delete();
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Wish item Removed"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
      }
    } catch (ex){
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
      }
    }

  }

}