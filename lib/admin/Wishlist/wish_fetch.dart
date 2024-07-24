import 'package:eproject/admin/Users/user_controller.dart';
import 'package:eproject/admin/Wishlist/wish_controller.dart';
import 'package:flutter/material.dart';

import 'wish_model.dart';


class WishFetch extends StatefulWidget {
  const WishFetch({super.key});

  @override
  State<WishFetch> createState() => _WishFetchState();
}

class _WishFetchState extends State<WishFetch> {

  WishController wishController = WishController();

  String uEmail = "";


  @override
  void initState() {
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
        title: const Text("Your WishList",style: TextStyle(color: Colors.black),),
      ),
      body: StreamBuilder(
          stream: wishController.wishFetch(uEmail),
          builder: (context,AsyncSnapshot<List<WishModel>> snapshot) {

            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child:CircularProgressIndicator());
            }

            if(snapshot.hasData){

              var cartDataLength = snapshot.data!.length;

              return cartDataLength != 0 ? ListView.builder(
                itemCount: cartDataLength,
                itemBuilder: (context, index) {
                  WishModel wishData = snapshot.data![index];

                  // String bookID = cartData.bookID!;
                  String bookName = wishData.bookName!;
                  String bookImage = wishData.bookImage!;
                   String wishID = wishData.wishID!;




                  return GestureDetector(
                    onTap: () {
                      wishController.wishDelete(wishID, context);
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
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },) : const Center(child: Text("No Item in WishList"),);
            }

            if(snapshot.hasError){
              return const Center(child: Icon(Icons.error,color: Colors.red,),);
            }

            return Container();
          },),

    );
  }
}
