
import 'package:eproject/admin/Books/book_controller/book_controller.dart';
import 'package:eproject/admin/Order/order_controller.dart';
import 'package:eproject/admin/Order/order_model.dart';
import 'package:eproject/admin/Users/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FetchOrder extends StatefulWidget {
  const FetchOrder({super.key});

  @override
  State<FetchOrder> createState() => _FetchOrderState();
}

class _FetchOrderState extends State<FetchOrder> {

  String uEmail = "";
  String orderS = "pending";


  final OrderController _orderController = OrderController();
  final BookController _bookController = BookController();
  final TextEditingController reviewController = TextEditingController();
  var userRate = "";


  @override
  void initState() {
    // TODO: implement initState
    UserRegisterLogin.userCredGet().then((value) {
      setState(() {
        uEmail = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(
              height: 10,
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(onPressed: (){
                    setState(() {
                      orderS = "pending";
                    });
                  },
                    style: ButtonStyle(
                        backgroundColor: orderS == "pending" ? MaterialStatePropertyAll(Colors.orange.shade100) : const MaterialStatePropertyAll(Colors.white)
                    ), child: Text("Pending", style: TextStyle(color: orderS == "pending" ? Colors.orange : Colors.black),),),
                  TextButton(onPressed: (){
                    setState(() {
                      orderS = "completed";
                    });
                  },
                    style: ButtonStyle(
                        backgroundColor: orderS == "completed" ?  MaterialStatePropertyAll(Colors.green.shade100) : const MaterialStatePropertyAll(Colors.white)
                    ), child:  Text("Completed", style: TextStyle(color: orderS == "completed" ? Colors.green : Colors.black),),
                  ),
                  TextButton(onPressed: (){
                    setState(() {
                      orderS = "rejected";
                    });
                  },
                    style: ButtonStyle(
                        backgroundColor: orderS == "rejected" ?  MaterialStatePropertyAll(Colors.red.shade100) : const MaterialStatePropertyAll(Colors.white)
                    ), child:  Text("Rejected", style: TextStyle(color: orderS == "rejected" ? Colors.red : Colors.black),),
                  ),
                ],
              ),
            ),


            StreamBuilder(stream: _orderController.fetchOrder(uEmail, orderS), builder: (context, AsyncSnapshot<List<OrderModel>> snapshot) {

              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(),);
              }

              if(snapshot.hasData){

                var orderLength = snapshot.data!.length;

                return orderLength != 0 ? ListView.builder(
                  itemCount: orderLength,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {

                    OrderModel orderDetail = snapshot.data![index];

                    String orderID = orderDetail.orderID!;
                    String totalPrice = orderDetail.totalPrice!;
                    String orderStatus = orderDetail.orderStatus!;


                    List orderDetails = orderDetail.orderItem!;

                    return ExpansionTile(
                      title: Text("ID: $orderID"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("\$ $totalPrice"),
                          Text(orderStatus),
                        ],
                      ),
                      children: List.generate(orderDetails.length, (index) => ListTile(
                        leading: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(orderDetails[index]['bookImage']))
                          ),
                        ),
                        title: Text(orderDetails[index]['bookName']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(orderDetails[index]['bookQuantity']),
                            Text("\$ ${orderDetails[index]['totalPrice']}"),
                            orderStatus == "completed" ? TextButton(onPressed: (){
                              showModalBottomSheet(context: context, builder: (context) {
                                return StatefulBuilder(builder: (context, setState) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      const SizedBox(height: 10,),

                                      RatingBar.builder(
                                        initialRating: 5,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 24,
                                        itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          setState((){
                                            userRate = rating.toString();
                                          });
                                        },
                                      ),

                                      Text(userRate),

                                      const SizedBox(height: 10,),

                                      TextFormField(
                                        controller: reviewController,
                                        decoration: const InputDecoration(
                                            hintText: "Your Review",
                                            border: OutlineInputBorder()
                                        ),
                                      ),

                                      const SizedBox(height: 10,),

                                      ElevatedButton(onPressed: (){
                                        _bookController.addReviewToBook(orderDetails[index]['bookID'], reviewController.text, userRate, uEmail, context);
                                      }, child: const Text("Add Review"))
                                    ],
                                  );
                                },);
                              },);
                            },child: const Text("Add Reviews"),) : Container()
                          ],
                        ),
                      )),
                    );
                  },) : const Center(child: Text("No Order Found"),);
              }

              if(snapshot.hasError){
                return const Center(child: Icon(Icons.error,color: Colors.red,),);
              }

              return Container();
            },),
          ],
        ),
      ),
    );
  }
}
