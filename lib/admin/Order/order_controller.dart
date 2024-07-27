import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eproject/admin/Order/order_model.dart';
import 'package:flutter/material.dart';

class OrderController{

  final CollectionReference _orderCollection = FirebaseFirestore.instance.collection("Orders");


  void addOrder(OrderModel oModel, BuildContext context){

    try{
      Map<String, dynamic> orderAdd = {
        "orderID" : oModel.orderID,
        "totalPrice" : oModel.totalPrice,
        "userEmail" : oModel.userEmail,
        "orderStatus" : oModel.orderStatus,
        "orderItem" : oModel.orderItem
      };
      _orderCollection.doc(oModel.orderID).set(orderAdd);
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Order Placed"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
      }
    }catch(ex){
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
      }
    }

  }

  Stream<List<OrderModel>> fetchOrder(String uEmail, String status){
    return _orderCollection.where('userEmail', isEqualTo: uEmail).snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        Map<String, dynamic> orderData = doc.data() as Map<String, dynamic>;
        return OrderModel(
            orderID: orderData['orderID'],
            totalPrice: orderData['totalPrice'],
            userEmail: orderData['userEmail'],
            orderStatus: orderData['orderStatus'],
            orderItem: orderData['orderItem'],
        );
      }).where((order) {
        if (status == null || status.isEmpty) {
          return true;
        } else {
          return order.orderStatus!.toLowerCase().contains(status.toLowerCase());
        }
      }).toList();
    });
  }

  Stream<List<OrderModel>> fetchAllOrder(){
    return _orderCollection.snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        Map<String, dynamic> orderData = doc.data() as Map<String, dynamic>;
        return OrderModel(
            orderID: orderData['orderID'],
            totalPrice: orderData['totalPrice'],
            userEmail: orderData['userEmail'],
            orderStatus: orderData['orderStatus'],
            orderItem: orderData['orderItem']
        );
      }).toList();
    });
  }



  void updateOrder(OrderModel oModel, BuildContext context){
    try{
      Map<String, dynamic> orderUpdate = {
        "orderStatus" : oModel.orderStatus
      };
      _orderCollection.doc(oModel.orderID).update(orderUpdate);
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Status Updated"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
      }
    }catch(ex){
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
      }
    }
  }

  void deleteOrder(String orderID, BuildContext context){

    try{
      _orderCollection.doc(orderID).delete();
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Order Deleted"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
      }
    }catch(ex){
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
      }
    }
  }


}

