import 'package:eproject/admin/Cart/cart_controller.dart';
import 'package:eproject/admin/Cart/cart_model.dart';
import 'package:eproject/admin/Users/user_controller.dart';
import 'package:eproject/admin/Wishlist/wish_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:uuid/uuid.dart';

import 'admin/Wishlist/wish_model.dart';

class BookDescription extends StatefulWidget {

  const BookDescription({super.key, required this.bookID,required this.bookImage, required this.bookCate, required this.bookAuthor, required this.bookName, required this.bookDesc, required this.bookiSBN, required this.bookPrice});
  final String bookName;
  final String bookID;
  final String bookImage;
  final String bookPrice;
  final String bookDesc;
  final String bookiSBN;
  final String bookAuthor;
  final String bookCate;
  @override
  State<BookDescription> createState() => _BookDescriptionState();
}

class _BookDescriptionState extends State<BookDescription> {

  int cartNumber = 1;

  CartController cartController = CartController();
  WishController wishController = WishController();

  String uEmail = "";

  @override
  void initState() {
    // TODO: implement initState
    UserRegisterLogin.userCredGet().then((val){
      setState(() {
        uEmail = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(widget.bookName,style: const TextStyle(color: Colors.black),overflow: TextOverflow.ellipsis,),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            wishController.wishAdd(WishModel(
              userEmail: uEmail,
              bookImage: widget.bookImage,
              bookName: widget.bookName,
              bookID: widget.bookID,
              wishID: const Uuid().v1()
            ), context);
          }, icon: const Icon(Icons.heart_broken)),
          const SizedBox(width: 4,)
        ],
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
                        Text(widget.bookAuthor,style: const TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.w600),),
                        const SizedBox(
                          height: 16,
                        ),
                        Text("Category:",style: TextStyle(color: Colors.grey.shade400,fontSize: 14, fontWeight: FontWeight.w400),),
                        Text(widget.bookCate,style: const TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.w600),),
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
                        Text("Book Price:",style: TextStyle(color: Colors.grey.shade400,fontSize: 14, fontWeight: FontWeight.w400),),
                        Text("\$ ${widget.bookPrice}",style: const TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.w600),),

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
              child: Text(widget.bookDesc,overflow: TextOverflow.fade,),
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
                       decoration: const BoxDecoration(
                           color: Colors.black,
                           borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))
                       ),
                       child: IconButton(onPressed: (){
                         setState(() {
                           if (cartNumber>1) {
                             cartNumber  = cartNumber - 1;
                           }
                         });
                       }, icon: const Icon(Icons.keyboard_arrow_left,color: Colors.white,)),
                     ),
                     GestureDetector(
                       onTap: (){
                         var totalPrice = cartNumber * int.parse(widget.bookPrice);
                         cartController.cartAdd(CartModel(
                           bookQuantity: "$cartNumber",
                           bookName: widget.bookName,
                           bookPrice: widget.bookPrice,
                           totalPrice: "$totalPrice",
                           bookImage: widget.bookImage,
                           bookID: widget.bookID,
                           userEmail: uEmail
                         ), context);
                       },
                       child: Container(
                         width: 80,
                         height: 40,
                         alignment: Alignment.center,
                         decoration: const BoxDecoration(
                           color: Colors.black,
                         ),
                         child: cartNumber == 1 ? const Text("Add To Cart",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w600),) : Text("$cartNumber",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                       ),
                     ),

                     Container(
                       width: 40,
                       height: 40,
                       alignment: Alignment.center,
                       decoration: const BoxDecoration(
                           color: Colors.black,
                           borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                       ),
                       child: IconButton(onPressed: (){
                         setState(() {
                           cartNumber = cartNumber + 1;
                         });
                       }, icon: const Icon(Icons.keyboard_arrow_right,color: Colors.white,)),
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
                    child: const Text("Buy Now",style: TextStyle(color: Colors.red,fontSize: 12,fontWeight: FontWeight.w600),),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }
}
