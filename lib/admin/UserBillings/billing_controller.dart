import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eproject/admin/UserBillings/billing_model.dart';
import 'package:flutter/material.dart';

class BillingController{

  final CollectionReference _billingCollection = FirebaseFirestore.instance.collection("billings");

  void addBillings(BillingModel bModel, BuildContext context){
   try{
     Map<String, dynamic> addBill = {
       "billingID" : bModel.billingID,
       "receiverName" : bModel.receiverName,
       "receiverPhone" : bModel.receiverPhone,
       "receiverAddress" : bModel.receiverAddress,
       "userEmail" : bModel.userEmail,
     };
     _billingCollection.doc(bModel.billingID).set(addBill);
     if(context.mounted){
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Billing Added"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
       Navigator.pop(context);
     }
   } on FirebaseException catch(ex){
     if(context.mounted){
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
     }
   }
  }

  Stream<List<BillingModel>> fetchBillings(String email){
    return _billingCollection.where('userEmail',isEqualTo: email).snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        Map<String, dynamic> billData = doc.data() as Map<String, dynamic>;
        return BillingModel(
          billingID: billData['billingID'],
          receiverAddress: billData['receiverAddress'],
          receiverName: billData['receiverName'],
          receiverPhone: billData['receiverPhone'],
          userEmail: billData['userEmail']
        );
      }).toList();
    });
  }

  void updateBillings(BillingModel bModel, BuildContext context){
    try{
      Map<String, dynamic> updateBill = {
        "receiverName" : bModel.receiverName,
        "receiverPhone" : bModel.receiverPhone,
        "receiverAddress" : bModel.receiverAddress,
      };
      _billingCollection.doc(bModel.billingID).update(updateBill);
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Billing Modified"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
        Navigator.pop(context);
      }
    } on FirebaseException catch(ex){
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
      }
    }
  }

  void deleteBillings(String billingID, BuildContext context){
    try{
      _billingCollection.doc(billingID).delete();
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Billing Deleted"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
      }
    } on FirebaseException catch(ex){
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
      }
    }
  }

}