import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookDescription extends StatefulWidget {

  final String bookImage;
  const BookDescription({super.key, required this.bookImage});

  @override
  State<BookDescription> createState() => _BookDescriptionState();
}

class _BookDescriptionState extends State<BookDescription> {

  int cartNumber = 1;
  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Book Name",style: TextStyle(color: Colors.black),overflow: TextOverflow.ellipsis,),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),

            SizedBox(
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: "bookImage",
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
                      width: 180,
                      height: 240,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                              image: NetworkImage(widget.bookImage)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade400,
                                spreadRadius: 1,
                                blurRadius: 10
                            )
                          ]
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text("Author Name:",style: TextStyle(color: Colors.grey.shade400,fontSize: 14, fontWeight: FontWeight.w400),),
                        Text("Muhammad Umar",style: TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.w600),),
                        const SizedBox(
                          height: 16,
                        ),
                        Text("Category:",style: TextStyle(color: Colors.grey.shade400,fontSize: 14, fontWeight: FontWeight.w400),),
                        Text("Fantasy",style: TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.w600),),
                        const SizedBox(
                          height: 16,
                        ),
                        Text("Rating:",style: TextStyle(color: Colors.grey.shade400,fontSize: 14, fontWeight: FontWeight.w400),),
                        RatingBar.builder(
                          initialRating: 5,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 20,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text("Date Published:",style: TextStyle(color: Colors.grey.shade400,fontSize: 14, fontWeight: FontWeight.w400),),
                        Text("2024-02-21",style: TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.w600),),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 80,
                  child: Divider(
                    color: Colors.grey.shade400,
                    thickness: 1,
                  ),
                ),

                const SizedBox(
                  width: 6,
                ),

                const Text("Description", style: TextStyle(color: Colors.black ,fontSize: 14,fontWeight: FontWeight.w600),),

                const SizedBox(
                  width: 6,
                ),

                SizedBox(
                  width: 80,
                  child: Divider(
                    color: Colors.grey.shade400,
                    thickness: 1,
                  ),
                )
              ],
            ),

            const SizedBox(
              height: 30,
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: Text("adskjfhkjhasdfkhasdhflksdhalfkhklsdhflkasdadsadsasdadasdadasdadshdflkhslkajdhflkhaskldhfklhsdfkhskldhflksahdflkhsdfklhsakldfhklhsakdjhfkshdfkhkladsfkjdshfkjadshfkjhsdakjfhkjasdfhkjsadhfkjhasdfkjhadskljfhkjasdfhkjdsfh",overflow: TextOverflow.fade,),
            ),

            const SizedBox(
              height: 30,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 80,
                  child: Divider(
                    color: Colors.grey.shade400,
                    thickness: 1,
                  ),
                ),

                const SizedBox(
                  width: 6,
                ),

                const Text("Add to Shell", style: TextStyle(color: Colors.black ,fontSize: 14,fontWeight: FontWeight.w600),),

                const SizedBox(
                  width: 6,
                ),

                SizedBox(
                  width: 80,
                  child: Divider(
                    color: Colors.grey.shade400,
                    thickness: 1,
                  ),
                )
              ],
            ),

            const SizedBox(
              height: 30,
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Row(
                   children: [
                     Container(
                       width: 40,
                       height: 40,
                       alignment: Alignment.center,
                       decoration: BoxDecoration(
                           color: Colors.black,
                           borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))
                       ),
                       child: IconButton(onPressed: (){
                         setState(() {
                           if (cartNumber>1) {
                             cartNumber  = cartNumber - 1;
                           }
                         });
                       }, icon: Icon(Icons.keyboard_arrow_left,color: Colors.white,)),
                     ),
                     Container(
                       width: 80,
                       height: 40,
                       alignment: Alignment.center,
                       decoration: BoxDecoration(
                         color: Colors.black,
                       ),
                       child: cartNumber == 1 ? Text("Add To Cart",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w600),) : Text("$cartNumber",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                     ),
                     Container(
                       width: 40,
                       height: 40,
                       alignment: Alignment.center,
                       decoration: BoxDecoration(
                           color: Colors.black,
                           borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                       ),
                       child: IconButton(onPressed: (){
                         setState(() {
                           cartNumber = cartNumber + 1;
                         });
                       }, icon: Icon(Icons.keyboard_arrow_right,color: Colors.white,)),
                     )
                   ],
                 ),
                  Container(
                    width: 120,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                        border: Border.all(color: Colors.black,width: 1.6),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Text("Buy Now",style: TextStyle(color: Colors.red,fontSize: 12,fontWeight: FontWeight.w600),),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
