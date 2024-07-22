import 'package:eproject/admin/Books/book_controller/book_controller.dart';
import 'package:eproject/admin/Books/book_model/book_model.dart';
import 'package:eproject/description_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CateProduct extends StatefulWidget {
  const CateProduct({super.key, required this.bookCate});
  final String? bookCate;

  @override
  State<CateProduct> createState() => _CateProductState();
}

class _CateProductState extends State<CateProduct> {

  BookController bookController = BookController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bookCate!),
      ),

      body: StreamBuilder(stream: bookController.getSpecificCateBooks(widget.bookCate), builder: (context,AsyncSnapshot<List<BookModel>> snapshot) {

        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }

        if(snapshot.hasData){

          return Hero(
            tag: "bookImage",
            child: snapshot.data!.isNotEmpty ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                  childAspectRatio: 160/ 220,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10
              ),
              itemCount: snapshot.data!.length,
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {

                BookModel bookData = snapshot.data![index];

                String bookName = bookData.bookName!;
                String bookImage = bookData.getImage!;
                String bookAuthor = bookData.bookAuthor!;
                String bookCate = bookData.bookCategory!;
                String bookDesc = bookData.bookDescription!;
                String bookISBN = bookData.bookISBN!;
                String bookPrice = bookData.bookPrice!;
                String bookID = bookData.bookID!;


                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BookDescription(
                        bookImage: bookImage,
                        bookCate: bookCate,
                        bookAuthor: bookAuthor,
                        bookName: bookName,
                        bookDesc: bookDesc,
                        bookiSBN: bookISBN,
                        bookPrice: bookPrice,
                      bookID: bookID,
                    )));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
                    width: 160,
                    height: 220,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                            image: NetworkImage(bookImage)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade400,
                              spreadRadius: 1,
                              blurRadius: 10
                          )
                        ]
                    ),
                    child: Container(
                        margin: const EdgeInsets.only(left: 10, top: 140),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(bookName, style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),
                            Row(
                              children: [
                                RatingBar.builder(
                                  initialRating: 5,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 12,
                                  itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                  },
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Text("4.5", style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w400),),
                              ],
                            ),
                            const Text("View Details", style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w400),),
                          ],
                        )),
                  ),
                ) ;
              },) : const Center(child: Text("No Book Available"),),
          );
        }

        if(snapshot.hasError){
          return const Center(child: Icon(Icons.error,color: Colors.red,),);
        }

        return Container();
      },)
    );
  }
}
