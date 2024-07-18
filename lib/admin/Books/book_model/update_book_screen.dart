import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:eproject/admin/Books/book_controller/book_controller.dart';
import 'package:eproject/admin/Books/book_views/book_model.dart';

class UpdateBook extends StatefulWidget {
  const UpdateBook({
    super.key,
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
  List<String> authorsName = [
    "Select Author",
    "Ernest Hemingway",
    "George Orwell",
    "J. K. Rowling",
    "Charles Dickens",
    "Jane Austen",
    "Leo Tolstoy"
  ];

  String? categoryName;
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
  void initState() {
    super.initState();
    // Initialize text controllers with widget data
    bookName.text = widget.bookName ?? "";
    bookPrice.text = widget.bookPrice ?? "";
    bookDesc.text = widget.bookDescription ?? "";
    bookISBN.text = widget.bookISBN ?? "";
    authorName = widget.bookAuthor ?? "Select Author";
    categoryName = widget.bookCategory ?? "Select Category";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Update Book',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              SizedBox(
                width: 250,
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
                width: 250,
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
                width: 250,
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
                width: 250,
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
                width: 250,
                child: DropdownButtonFormField(
                  isExpanded: true,
                  value: authorName,
                  onChanged: (val) => setState(() {
                    authorName = val as String?;
                  }),
                  items: authorsName.map((author) {
                    return DropdownMenuItem(
                      value: author,
                      child: Text(author, style: TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintText: 'Please choose an Author',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: 250,
                child: DropdownButtonFormField(
                  isExpanded: true,
                  value: categoryName,
                  onChanged: (val) => setState(() {
                    categoryName = val as String?;
                  }),
                  items: categoriesName.map((cate) {
                    return DropdownMenuItem(
                      value: cate,
                      child: Text(cate, style: TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintText: 'Please choose a Category',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {
                  bookController.updateBook(
                    BookModel(
                      bookID: widget.bookID,
                      bookName: bookName.text,
                      bookPrice: bookPrice.text,
                      bookISBN: bookISBN.text,
                      bookDescription: bookDesc.text,
                      bookAuthor: authorName ?? "Select Author",
                      bookCategory: categoryName ?? "Select Category",
                    ),
                    context,
                  );
                },
                child: const Text("Update Book"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
