import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eproject/admin/Books/book_controller/book_controller.dart';
import 'package:eproject/admin/Books/book_model/book_model.dart';

class UpdateBook extends StatefulWidget {
  const UpdateBook({
    super.key,
    this.bookID,
    this.bookName,
    this.getImage,
    this.bookPrice,
    this.bookDescription,
    this.bookISBN,
    this.bookAuthor,
    this.bookCategory,
  });

  final String? bookID;
  final String? bookName;
  final String? getImage;
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

  File? updateBookImage; // For mobile

  Uint8List? updateBookImageWeb; // For Web
  
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
        title: const Text(
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

              updateBookImage == null ? Container(
                width: double.infinity,
                height: 150,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.getImage!))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap:()async{
                        XFile? selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                        if(selectedImage != null){
                          if(kIsWeb){
                            var convertedFile = await selectedImage.readAsBytes();
                            setState(() {
                              updateBookImageWeb = convertedFile;
                            });
                            if(context.mounted){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Image Selected"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
                            }                                  }
                          else{
                            File convertedFile = File(selectedImage.path);
                            setState(() {
                              updateBookImage = convertedFile;
                            });
                            if(context.mounted){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Image Selected"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
                            }                                  }
                        }
                        else{
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Image not Selected"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4.0),
                        width: 100,
                        height: 40,
                        margin: const EdgeInsets.only(right: 14,bottom: 14),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.camera, size: 14,),
                            Text("Choose Photo",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10),)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ) : kIsWeb ?
              Container(
                width: double.infinity,
                height: 150,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: MemoryImage(updateBookImageWeb!))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap:()async{
                        XFile? selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                        if(selectedImage != null){
                          if(kIsWeb){
                            var convertedFile = await selectedImage.readAsBytes();
                            setState(() {
                              updateBookImageWeb = convertedFile;
                            });
                            if(context.mounted){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Image Selected"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
                            }                                  }
                          else{
                            File convertedFile = File(selectedImage.path);
                            setState(() {
                              updateBookImage = convertedFile;
                            });
                            if(context.mounted){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Image Selected"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
                            }                                  }
                        }
                        else{
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Image not Selected"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
                          }
                        }
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        padding: const EdgeInsets.all(4.0),
                        margin: const EdgeInsets.only(right: 14,bottom: 14),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.camera, size: 14,),
                            Text("Change Photo",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10,),)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ) :

              Container(
                width: double.infinity,
                height: 150,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(updateBookImage!))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap:()async{
                        XFile? selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                        if(selectedImage != null){
                          if(kIsWeb){
                            var convertedFile = await selectedImage.readAsBytes();
                            setState(() {
                              updateBookImageWeb = convertedFile;
                            });
                            if(context.mounted){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Image Selected"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
                            }                                  }
                          else{
                            File convertedFile = File(selectedImage.path);
                            setState(() {
                              updateBookImage = convertedFile;
                            });
                            if(context.mounted){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Image Selected"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
                            }
                          }
                        }
                        else{
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Image not Selected"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
                          }
                        }
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        padding: const EdgeInsets.all(4.0),
                        margin: const EdgeInsets.only(right: 14,bottom: 14),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.camera, size: 14,),
                            Text("Change Photo",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10),)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              
              
              SizedBox(
                width: 250,
                child: TextFormField(
                  controller: bookName,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
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
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
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
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
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
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
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
                    authorName = val;
                  }),
                  items: authorsName.map((author) {
                    return DropdownMenuItem(
                      value: author,
                      child: Text(author, style: const TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
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
                    categoryName = val;
                  }),
                  items: categoriesName.map((cate) {
                    return DropdownMenuItem(
                      value: cate,
                      child: Text(cate, style: const TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
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
               kIsWeb ?    bookController.updateBook(
                 BookModel(
                   bookID: widget.bookID,
                   bookName: bookName.text,
                   bookPrice: bookPrice.text,
                   bookISBN: bookISBN.text,
                   getImage: widget.getImage,
                   bookDescription: bookDesc.text,
                   bookImageWeb: updateBookImageWeb,
                   bookAuthor: authorName ?? "Select Author",
                   bookCategory: categoryName ?? "Select Category",
                 ),
                 context,
               ) :    bookController.updateBook(
                 BookModel(
                   bookID: widget.bookID,
                   bookName: bookName.text,
                   bookPrice: bookPrice.text,
                   bookISBN: bookISBN.text,
                   getImage: widget.getImage,
                   bookImage: updateBookImage,
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
