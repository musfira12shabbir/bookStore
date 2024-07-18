
import 'package:eproject/admin/Books/book_controller/book_controller.dart';
import 'package:eproject/admin/Books/book_views/book_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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

  List authorsName = ["Select Author","Ernest Hemingway", "George Orwell", "J. K. Rowling",
    "Charles Dickens", "Jane Austen", "Leo Tolstoy"];

  String categoryName = "Select Category";

  List categoriesName = ["Select Category","Sci-Fi", "Horror", "Thrill",
    "Comedy", "Mystery", "Fantasy"];

  BookController bookController = BookController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [

              const SizedBox(height: 10,),

              SizedBox(
                width: 250,
                child: TextFormField(
                  controller: bookName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Name"
                  ),
                ),
              ),

              const SizedBox(height: 10,),

              SizedBox(
                width: 250,
                child: TextFormField(
                  controller: bookPrice,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    hintText: "Price"
                  ),
                ),
              ),

              const SizedBox(height: 10,),

              SizedBox(
                width: 250,
                child: TextFormField(
                  controller: bookDesc,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    hintText: "Description"
                  ),
                ),
              ),

              const SizedBox(height: 10,),

              SizedBox(
                width: 250,
                child: TextFormField(
                  controller: bookISBN,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    hintText: "ISBN Number"
                  ),
                ),
              ),

              const SizedBox(height: 10,),

              SizedBox(
                width: 250,
                child: DropdownButton(
                  isExpanded: true,
                  hint: const Text('Please choose a Author'), // Not necessary for Option 1
                value: authorName,
                             onChanged: (val)=> setState(() {
                 authorName = val as String;
                             }),
                items: authorsName.map((author) {
                  return DropdownMenuItem(
                    value: author,
                    child: Text(author),
                  );
                }).toList(),
                            ),
              ),

              const SizedBox(height: 10,),

              SizedBox(
                width: 250,
                child: DropdownButton(
                  isExpanded: true,
                  hint: const Text('Please choose a Author'), // Not necessary for Option 1
                  value: categoryName,
                  onChanged: (val)=> setState(() {
                    categoryName = val as String;
                  }),
                  items: categoriesName.map((cate) {
                    return DropdownMenuItem(
                      value: cate,
                      child: Text(cate),
                    );
                  }).toList(),
                ),
              ),


              const SizedBox(height: 10,),

              ElevatedButton(onPressed: (){
                String bookID = const Uuid().v1();
                bookController.bookAdd(BookModel(
                  bookID: bookID,
                  bookName: bookName.text,
                  bookPrice: bookPrice.text,
                  bookISBN: bookISBN.text,
                  bookDescription: bookDesc.text,
                  bookAuthor: authorName,
                  bookCategory: categoryName,
                ), context);
              }, child: const Text("Add Book"))
            ],
          ),
        ),
      ),
    );
  }
}
