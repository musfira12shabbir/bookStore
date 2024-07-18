import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:eproject/admin/Books/book_controller/book_controller.dart';
import 'package:eproject/admin/Books/book_views/book_model.dart';

class AddBook extends StatefulWidget {
  const AddBook({super.key});

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final TextEditingController bookName = TextEditingController();
  final TextEditingController bookPrice = TextEditingController();
  final TextEditingController bookDesc = TextEditingController();
  final TextEditingController bookISBN = TextEditingController();

  String authorName = "Select Author";
  List<String> authorsName = [
    "Select Author",
    "Ernest Hemingway",
    "George Orwell",
    "J. K. Rowling",
    "Charles Dickens",
    "Jane Austen",
    "Leo Tolstoy"
  ];

  String categoryName = "Select Category";
  List<String> categoriesName = [
    "Select Category",
    "Sci-Fi",
    "Horror",
    "Thrill",
    "Comedy",
    "Mystery",
    "Fantasy"
  ];

  BookController bookController = BookController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    controller: bookName,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: "Name",
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    controller: bookPrice,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: "Price",
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    controller: bookDesc,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: "Description",
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    controller: bookISBN,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: "ISBN Number",
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField(
                    dropdownColor: Colors.black,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: 'Please choose an Author',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    value: authorName,
                    onChanged: (val) => setState(() {
                      authorName = val.toString();
                    }),
                    items: authorsName.map((author) {
                      return DropdownMenuItem(
                        value: author,
                        child: Text(author, style: TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField(
                    dropdownColor: Colors.black,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: 'Please choose a Category',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    value: categoryName,
                    onChanged: (val) => setState(() {
                      categoryName = val.toString();
                    }),
                    items: categoriesName.map((cate) {
                      return DropdownMenuItem(
                        value: cate,
                        child: Text(cate, style: TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String bookID = const Uuid().v1();
                    bookController.bookAdd(
                      BookModel(
                        bookID: bookID,
                        bookName: bookName.text,
                        bookPrice: bookPrice.text,
                        bookISBN: bookISBN.text,
                        bookDescription: bookDesc.text,
                        bookAuthor: authorName,
                        bookCategory: categoryName,
                      ),
                      context,
                    );
                  },
                  child: const Text("Add Book"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
