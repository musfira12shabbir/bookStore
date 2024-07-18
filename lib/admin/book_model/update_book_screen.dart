import 'package:eproject/admin/book_controller/book_controller.dart';
import 'package:eproject/admin/book_model/book_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class UpdateBook extends StatefulWidget {
  const UpdateBook({super.key,
  this.bookID,
  this.bookName,
  this.bookImage,
  this.bookPrice,
  this.bookDescription,
  this.bookISBN,
  this.bookAuthor,
  this.bookCategory,
  });

  final String? bookID;
  final String? bookName;
  final String? bookImage;
  final String? bookPrice;
  final String? bookDescription;
  final String? bookISBN;
  final String? bookAuthor;
  final String? bookCategory;

  @override
  State<UpdateBook> createState() => _UpdateBookState();
}

class _UpdateBookState extends State<UpdateBook> {

  final TextEditingController bookName = TextEditingController();
  final TextEditingController bookPrice = TextEditingController();
  final TextEditingController bookDesc = TextEditingController();
  final TextEditingController bookISBN = TextEditingController();

  String? authorName;

  List authorsName = ["Select Author","Ernest Hemingway", "George Orwell", "J. K. Rowling",
    "Charles Dickens", "Jane Austen", "Leo Tolstoy"];

  String? categoryName;

  List categoriesName = ["Select Category","Sci-Fi", "Horror", "Thrill",
    "Comedy", "Mystery", "Fantasy"];

  BookController bookController = BookController();

  @override
  void initState() {
    // TODO: implement initState
    bookName.text = widget.bookName!;
    bookPrice.text = widget.bookPrice!;
    bookDesc.text = widget.bookDescription!;
    bookISBN.text = widget.bookISBN!;
    authorName = widget.bookAuthor!;
    categoryName = widget.bookCategory;
    super.initState();
  }

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
                bookController.updateBook(BookModel(
                  bookID: widget.bookID,
                  bookName: bookName.text,
                  bookPrice: bookPrice.text,
                  bookISBN: bookISBN.text,
                  bookDescription: bookDesc.text,
                  bookAuthor: authorName,
                  bookCategory: categoryName,
                ), context);
              }, child: const Text("Update Book"))
            ],
          ),
        ),
      ),
    );
  }
}
