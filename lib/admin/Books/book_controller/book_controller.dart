import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eproject/admin/Books/book_model/book_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class BookController{

  final CollectionReference collectionReference = FirebaseFirestore.instance.collection("Books");

  void bookAdd(BookModel bookModel, BuildContext context)async{

   try{
     if(bookModel.bookImageWeb != null){
       UploadTask uploadTask =  FirebaseStorage.instance.ref().child("bookImages").child(bookModel.bookID!).putData(bookModel.bookImageWeb!);
       TaskSnapshot taskSnapshot = await uploadTask;
       String bookImage = await taskSnapshot.ref.getDownloadURL();

       Map<String, dynamic> bookAdd = {
         "bookID" : bookModel.bookID,
         "bookName" : bookModel.bookName!,
         "bookImage" : bookImage,
         "bookPrice" : bookModel.bookPrice!,
         "bookDesc" : bookModel.bookDescription!,
         "bookISBN" : bookModel.bookISBN!,
         "bookAuthor" : bookModel.bookAuthor!,
         "bookCate" : bookModel.bookCategory!,
         "reviews" : []
       };

       await collectionReference.doc(bookModel.bookID).set(bookAdd);
       if(context.mounted){
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Book Added Successfully"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
         Navigator.pop(context);
       }
     }
     else if(bookModel.bookImage != null){
       UploadTask uploadTask =  FirebaseStorage.instance.ref().child("bookImages").child(bookModel.bookID!).putFile(bookModel.bookImage!);
       TaskSnapshot taskSnapshot = await uploadTask;
       String bookImage = await taskSnapshot.ref.getDownloadURL();

       Map<String, dynamic> bookAdd = {
         "bookID" : bookModel.bookID,
         "bookName" : bookModel.bookName!,
         "bookImage" : bookImage,
         "bookPrice" : bookModel.bookPrice!,
         "bookDesc" : bookModel.bookDescription!,
         "bookISBN" : bookModel.bookISBN!,
         "bookAuthor" : bookModel.bookAuthor!,
         "bookCate" : bookModel.bookCategory!,
         "reviews" : []
       };

       await collectionReference.doc(bookModel.bookID).set(bookAdd);
       if(context.mounted){
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Book Added Successfully"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
         Navigator.pop(context);
       }
     }
     else{
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Book image not Selected"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
     }
   } catch(ex){
       if(context.mounted){
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
       }
     }
   }

   Stream<List<BookModel>> getBooks(){
    return collectionReference.snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return BookModel(
          bookID: data['bookID'],
          bookName: data['bookName'],
          getImage: data['bookImage'],
          bookPrice: data['bookPrice'],
          bookISBN: data['bookISBN'],
          bookCategory: data['bookCate'],
          bookAuthor: data['bookAuthor'],
          bookDescription: data['bookDesc']
        );
      }).toList();
    });
   }

  Stream<List<BookModel>> getSpecificCateBooks(String? bookCate){
    return FirebaseFirestore.instance.collection("Books").where("bookCate", isEqualTo: bookCate).snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        Map<String, dynamic> data = doc.data();
        return BookModel(
            bookID: data['bookID'],
            bookName: data['bookName'],
            getImage: data['bookImage'],
            bookPrice: data['bookPrice'],
            bookISBN: data['bookISBN'],
            bookCategory: data['bookCate'],
            bookAuthor: data['bookAuthor'],
            bookDescription: data['bookDesc']
        );
      }).toList();
    });
  }

  Stream<List<BookModel>> getSearchBook({String? searchQuery}) {
    return collectionReference.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return BookModel(
          bookID: data['bookID'],
          bookName: data['bookName'],
          getImage: data['bookImage'],
          bookPrice: data['bookPrice'],
          bookISBN: data['bookISBN'],
          bookCategory: data['bookCate'],
          bookAuthor: data['bookAuthor'],
          bookDescription: data['bookDesc'],
        );
      }).where((book) {
        if (searchQuery == null || searchQuery.isEmpty) {
          return true;
        } else {
          return book.bookName!.toLowerCase().contains(searchQuery.toLowerCase());
        }
      }).toList();
    });
  }

   void updateBook(BookModel bookModel, BuildContext context)async{
     try{
       if(bookModel.bookImageWeb != null){
         await FirebaseStorage.instance.refFromURL(bookModel.getImage!).delete();

         UploadTask uploadTask =  FirebaseStorage.instance.ref().child("bookImages").child(bookModel.bookID!).putData(bookModel.bookImageWeb!);
         TaskSnapshot taskSnapshot = await uploadTask;
         String updateImage = await taskSnapshot.ref.getDownloadURL();

         Map<String, dynamic> bookAdd = {
           "bookName" : bookModel.bookName!,
           "bookImage" : updateImage,
           "bookPrice" : bookModel.bookPrice!,
           "bookDesc" : bookModel.bookDescription!,
           "bookISBN" : bookModel.bookISBN!,
           "bookAuthor" : bookModel.bookAuthor!,
           "bookCate" : bookModel.bookCategory!,
           "reviews" : []
         };

         await collectionReference.doc(bookModel.bookID).update(bookAdd);
         if(context.mounted){
           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Book Updated Successfully"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
           Navigator.pop(context);
         }
       }
       else if(bookModel.bookImage != null){
         await FirebaseStorage.instance.refFromURL(bookModel.getImage!).delete();

         UploadTask uploadTask =  FirebaseStorage.instance.ref().child("bookImages").child(bookModel.bookID!).putFile(bookModel.bookImage!);
         TaskSnapshot taskSnapshot = await uploadTask;
         String updateImage = await taskSnapshot.ref.getDownloadURL();

         Map<String, dynamic> bookAdd = {
           "bookName" : bookModel.bookName!,
           "bookImage" : updateImage,
           "bookPrice" : bookModel.bookPrice!,
           "bookDesc" : bookModel.bookDescription!,
           "bookISBN" : bookModel.bookISBN!,
           "bookAuthor" : bookModel.bookAuthor!,
           "bookCate" : bookModel.bookCategory!,
           "reviews" : []
         };

         await collectionReference.doc(bookModel.bookID).update(bookAdd);
         if(context.mounted){
           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Book Updated Successfully"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
           Navigator.pop(context);
         }
       }
       else{
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Book image not selected"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
       }
     } catch(ex){
       if(context.mounted){
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
       }
     }
   }

  void addReview(String? bookID, BuildContext context, List? reviewData)async{
    try{

      Map<String, dynamic> addReview = {
        "reviews" : reviewData
      };

      await collectionReference.doc(bookID).update(addReview);
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Review Added Successfully"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
        Navigator.pop(context);
      }
    } catch(ex){
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
      }
    }
  }


  void deleteBook(String? bookID, String bookImageUrl,BuildContext context)async{
     try{
       await FirebaseStorage.instance.refFromURL(bookImageUrl).delete();
       await collectionReference.doc(bookID).delete();
       if(context.mounted){
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Book Deleted Successfully"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
       }
     } catch(ex){
       if(context.mounted){
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
       }
     }
   }
}
