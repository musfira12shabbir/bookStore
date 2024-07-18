import 'package:eproject/admin/Books/book_controller/book_controller.dart';
import 'package:eproject/admin/Books/book_model/update_book_screen.dart';
import 'package:eproject/admin/Books/book_views/add_book_screen.dart';
import 'package:eproject/admin/Books/book_views/book_model.dart';

import 'package:flutter/material.dart';


class FetchBook extends StatefulWidget {
  const FetchBook({super.key});

  @override
  State<FetchBook> createState() => _FetchBookState();
}

class _FetchBookState extends State<FetchBook> {
  BookController bookController = BookController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: bookController.getBooks(),
        builder:  (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }

          if(snapshot.hasData){

            var bookDataLength = snapshot.data!.length;

            return bookDataLength != 0 ? ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                BookModel book = snapshot.data![index];
                String bookID = book.bookID!;
                String bookISBN = book.bookISBN!;
                String bookName = book.bookName!;
                String bookImage = book.bookImage!;
                String bookPrice = book.bookPrice!;
                String bookDesc = book.bookDescription!;
                String bookCate = book.bookCategory!;
                String bookAuthor = book.bookAuthor!;
                return ListTile(
                  title: Text(bookName),
                  subtitle: Text(bookPrice),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateBook(
                            bookID: bookID,
                            bookName: bookName,
                            bookImage: bookImage,
                            bookPrice: bookPrice,
                            bookISBN: bookISBN,
                            bookCategory: bookCate,
                            bookDescription: bookDesc,
                            bookAuthor: bookAuthor,
                          ),));

                        }, icon: const Icon(Icons.update)),
                        IconButton(onPressed: (){
                          bookController.deleteBook(bookID, context);
                        }, icon: const Icon(Icons.delete,color: Colors.red,)),
                      ],
                    ),
                  ),
                );
              },) : const Center(child: Text("No Book Available"),);
          }

          if(snapshot.hasError){
            return const Center(child: Icon(Icons.error,color: Colors.red,),);
          }

        return Container();
      },),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddBook(),));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
