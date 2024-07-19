import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:eproject/admin/Books/book_controller/book_controller.dart';
import 'package:eproject/admin/Books/book_model/book_model.dart';

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

  File? bookImage; // For mobile

  Uint8List? bookImageWeb; // For Web

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
                
              bookImageWeb == null ? Container(
              width: double.infinity,
              height: 150,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20)
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
                            bookImageWeb = convertedFile;
                          });
                          if(context.mounted){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Image Selected"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
                          }                                  }
                        else{
                          File convertedFile = File(selectedImage.path);
                          setState(() {
                            bookImage = convertedFile;
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
                    image: MemoryImage(bookImageWeb!))
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
                          bookImageWeb = convertedFile;
                        });
                        if(context.mounted){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Image Selected"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
                        }                                  }
                      else{
                        File convertedFile = File(selectedImage.path);
                        setState(() {
                          bookImage = convertedFile;
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
                  image: FileImage(bookImage!))
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
                        bookImageWeb = convertedFile;
                      });
                      if(context.mounted){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Image Selected"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
                      }                                  }
                    else{
                      File convertedFile = File(selectedImage.path);
                      setState(() {
                        bookImage = convertedFile;
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
                  width: double.infinity,
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
                  width: double.infinity,
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
                  width: double.infinity,
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
                  width: double.infinity,
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
                  width: double.infinity,
                  child: DropdownButtonFormField(
                    dropdownColor: Colors.black,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
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
                        child: Text(author, style: const TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField(
                    dropdownColor: Colors.black,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
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
                        child: Text(cate, style: const TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String bookID = const Uuid().v1();
                   kIsWeb ?  bookController.bookAdd(
                     BookModel(
                       bookID: bookID,
                       bookName: bookName.text,
                       bookPrice: bookPrice.text,
                       bookISBN: bookISBN.text,
                       bookDescription: bookDesc.text,
                       bookAuthor: authorName,
                       bookCategory: categoryName,
                       bookImageWeb: bookImageWeb
                     ),
                     context,
                   ) :  bookController.bookAdd(
                     BookModel(
                       bookID: bookID,
                       bookName: bookName.text,
                       bookPrice: bookPrice.text,
                       bookISBN: bookISBN.text,
                       bookDescription: bookDesc.text,
                       bookAuthor: authorName,
                       bookCategory: categoryName,
                       bookImage: bookImage
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
