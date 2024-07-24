import 'package:eproject/admin/Cart/cart_controller.dart';
import 'package:eproject/admin/Cart/cart_model.dart';
import 'package:eproject/admin/Users/user_controller.dart';
import 'package:flutter/material.dart';


class CartFetch extends StatefulWidget {
  const CartFetch({super.key});

  @override
  State<CartFetch> createState() => _CartFetchState();
}

class _CartFetchState extends State<CartFetch> {

  CartController cartController = CartController();

  String uEmail = "";
  List<int> totalPrices = [];
  int cartPrice = 0;

  void calculateTotal(){
    for(int price in totalPrices){
      setState(() {
        cartPrice += price;
      });
    }
  }

  @override
  void initState() {
    calculateTotal();
    UserRegisterLogin.userCredGet().then((val){
      setState(() {
        uEmail = val;
      });
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Your Cart",style: TextStyle(color: Colors.black),),
      ),
      body: StreamBuilder(
          stream: cartController.cartFetch(uEmail),
          builder: (context,AsyncSnapshot<List<CartModel>> snapshot) {

            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child:CircularProgressIndicator());
            }

            if(snapshot.hasData){

              var cartDataLength = snapshot.data!.length;

              return cartDataLength != 0 ? ListView.builder(
                itemCount: cartDataLength,
                itemBuilder: (context, index) {
                  CartModel cartData = snapshot.data![index];

                  // String bookID = cartData.bookID!;
                  String bookName = cartData.bookName!;
                  String bookImage = cartData.bookImage!;
                  String bookQuantity = cartData.bookQuantity!;
                  String bookPrice = cartData.bookPrice!;
                  String totalPrice = cartData.totalPrice!;
                   String cartID = cartData.cartID!;

                   int tPrice = int.parse(totalPrice);

                  totalPrices.add(tPrice);

                  return GestureDetector(
                    onTap: () {
                      cartController.cartDelete(cartID, context);
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => BookDescription(bookImage: bookImages[index],),));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      width: double.infinity,
                      height: 160,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                          border: Border.all(color: Colors.black38 , width: 1.4)
                      ),
                      child: Row(
                        children: [
                          Hero(
                            tag: "bookImage",
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 120,
                              height: 140,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(bookImage)),
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.red,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top:14),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Book Name:",style: TextStyle(color: Colors.grey.shade400,fontSize: 12, fontWeight: FontWeight.w400),),
                                Text(bookName,style: const TextStyle(color: Colors.black,fontSize: 14, fontWeight: FontWeight.w600),),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text("Book Price:",style: TextStyle(color: Colors.grey.shade400,fontSize: 12, fontWeight: FontWeight.w400),),
                                Text("\$ $bookPrice",style: const TextStyle(color: Colors.black,fontSize: 14, fontWeight: FontWeight.w600),),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Text("x$bookQuantity",style: TextStyle(color: Colors.grey.shade400,fontSize: 12, fontWeight: FontWeight.w400),),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(totalPrice,style: const TextStyle(color: Colors.black45,fontSize: 12, fontWeight: FontWeight.w400),),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },) : const Center(child: Text("No Item in Cart"),);
            }

            if(snapshot.hasError){
              return const Center(child: Icon(Icons.error,color: Colors.red,),);
            }

            return Container();
          },),

      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Total Price:",style: TextStyle(color: Colors.black54,fontSize: 14, fontWeight: FontWeight.w800),),
                Text("$cartPrice",style: const TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.w800),),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 120,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Text("Buy Now",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w400),) ),
                const Text("*T & C Applied*",style: TextStyle(color: Colors.black54,fontSize: 12, fontWeight: FontWeight.w800),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
