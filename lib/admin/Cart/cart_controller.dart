
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eproject/admin/Cart/cart_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CartController{

  final _cartCollection = FirebaseFirestore.instance.collection("Cart");

  void cartAdd(CartModel cartModel, BuildContext context)async{

    try{
      String cartID = const Uuid().v1();
      Map<String, dynamic> cartData = {
        "cartID" : cartID,
        "bookID" : cartModel.bookID!,
        "bookName" : cartModel.bookName!,
        "bookImage" : cartModel.bookImage!,
        "bookQuantity" : cartModel.bookQuantity!,
        "bookPrice" : cartModel.bookPrice!,
        "userEmail" : cartModel.userEmail!,
      };

      await _cartCollection.doc(cartID).set(cartData);
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Book Added to Cart"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
      }
    } catch (ex){
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
      }
    }

  }

  Stream<List<CartModel>> cartFetch(String? userEmail){
    return _cartCollection.where('userEmail',isEqualTo: userEmail).snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        Map<String, dynamic> cartData = doc.data();
        return CartModel(
          cartID: cartData['cartID'],
          bookID: cartData['bookID'],
          bookImage: cartData['bookImage'],
          bookName: cartData['bookName'],
          bookPrice: cartData['bookPrice'],
          bookQuantity: cartData['bookQuantity'],
          userEmail: cartData['userEmail']
        );
      }).toList();
    });
  }

  void cartDelete(String? cartID, BuildContext context)async{

    try{
      await _cartCollection.doc(cartID).delete();
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Cart Removed"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
      }
    } catch (ex){
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
      }
    }

  }

}