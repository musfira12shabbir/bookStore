
import 'package:eproject/admin/Order/order_controller.dart';
import 'package:eproject/admin/Order/order_model.dart';
import 'package:eproject/admin/Users/user_controller.dart';
import 'package:flutter/material.dart';

class FetchOrder extends StatefulWidget {
  const FetchOrder({super.key});

  @override
  State<FetchOrder> createState() => _FetchOrderState();
}

class _FetchOrderState extends State<FetchOrder> {

  String uEmail = "";

  final OrderController _orderController = OrderController();

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
      body: StreamBuilder(stream: _orderController.fetchOrder(uEmail), builder: (context, AsyncSnapshot<List<OrderModel>> snapshot) {

        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }

        if(snapshot.hasData){

          var orderLength = snapshot.data!.length;

          return ListView.builder(
            itemCount: orderLength,
            itemBuilder: (context, index) {

              OrderModel orderDetail = snapshot.data![index];

              String orderID = orderDetail.orderID!;
              String totalPrice = orderDetail.totalPrice!;
              String totalStatus = orderDetail.orderStatus!;

              List orderDetails = orderDetail.orderItem!;

            return ExpansionTile(
              title: Text("ID: $orderID"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("\$ $totalPrice"),
                  Text(totalStatus),
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
                  ],
                ),
              )),
            );
          },);
        }

        if(snapshot.hasError){
          return const Center(child: Icon(Icons.error,color: Colors.red,),);
        }

        return Container();
      },),
    );
  }
}
