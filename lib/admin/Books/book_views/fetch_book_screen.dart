

import 'package:flutter/material.dart';
import 'package:eproject/admin/Books/book_controller/book_controller.dart';
import 'package:eproject/admin/Books/book_views/update_book_screen.dart';
import 'package:eproject/admin/Books/book_views/add_book_screen.dart';
import 'package:eproject/admin/Books/book_model/book_model.dart';

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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Book List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: bookController.getBooks(),
        builder: (context, AsyncSnapshot<List<BookModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          }

          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                BookModel book = snapshot.data![index];
                String bookID = book.bookID!;
                String bookISBN = book.bookISBN!;
                String bookName = book.bookName!;
                String bookImage = book.getImage!; // File to String conversion
                String bookPrice = book.bookPrice!;
                String bookDesc = book.bookDescription!;
                String bookCate = book.bookCategory!;
                String bookAuthor = book.bookAuthor!;
                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(backgroundImage: NetworkImage(bookImage),),
                    title: Text(
                      bookName,
                      style: const TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(
                      'Price: $bookPrice',
                      style: const TextStyle(color: Colors.black),
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateBook(
                                    bookID: bookID,
                                    bookName: bookName,
                                    getImage: bookImage,
                                    bookPrice: bookPrice,
                                    bookISBN: bookISBN,
                                    bookCategory: bookCate,
                                    bookDescription: bookDesc,
                                    bookAuthor: bookAuthor,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.update, color: Colors.black),
                          ),
                          IconButton(
                            onPressed: () {
                              bookController.deleteBook(bookID, bookImage,context);
                            },
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Icon(
                Icons.error,
                color: Colors.red,
              ),
            );
          }

          return const Center(
            child: Text(
              "No Book Available",
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddBook()),
          );
        },
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}
