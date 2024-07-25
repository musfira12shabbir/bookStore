import 'package:eproject/admin/UserBillings/billing_controller.dart';
import 'package:eproject/admin/UserBillings/billing_model.dart';
import 'package:eproject/admin/Users/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:uuid/uuid.dart';


class FetchBillings extends StatefulWidget {
  const FetchBillings({super.key});

  @override
  State<FetchBillings> createState() => _FetchBillingsState();
}

class _FetchBillingsState extends State<FetchBillings> {
  
  final BillingController _billingController = BillingController();
  String uEmail = "";

  final TextEditingController updateReceiverName = TextEditingController();
  final TextEditingController updateReceiverPhone = TextEditingController();
  final TextEditingController updateReceiverAddress = TextEditingController();

  final TextEditingController receiverName = TextEditingController();
  final TextEditingController receiverPhone = TextEditingController();
  final TextEditingController receiverAddress = TextEditingController();

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
  void dispose() {
    // TODO: implement dispose
    updateReceiverName.dispose();
    updateReceiverAddress.dispose();
    updateReceiverPhone.dispose();
    receiverName.dispose();
    receiverAddress.dispose();
    receiverPhone.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Billings"),
      ),
      body: StreamBuilder(
          stream: _billingController.fetchBillings(uEmail),
          builder: (BuildContext context, AsyncSnapshot<List<BillingModel>> snapshot) {
            if (snapshot.hasData) {
              var billingLength = snapshot.data!.length;
              debugPrint("$billingLength");
              return billingLength != 0 ? ListView.builder(
                itemCount: billingLength,
                itemBuilder: (context, index) {

                  BillingModel billingData = snapshot.data![index];

                  String billingID = billingData.billingID!;
                  String receiverN = billingData.receiverName!;
                  String receiverA = billingData.receiverAddress!;
                  String receiverP = billingData.receiverPhone!;
                  String userEmail = billingData.userEmail!;

                  return ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Iconsax.location),
                    ),
                    title: Text(receiverN),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Registerer: $userEmail" ),
                        Text("Address: $receiverA" ),
                        Text("Phone: $receiverP"),
                      ],
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(onPressed: (){
                            showModalBottomSheet(context: context, builder: (context) => StatefulBuilder(builder: (context, setState) {

                              setState(() {
                                updateReceiverName.text = receiverN;
                                updateReceiverAddress.text = receiverA;
                                updateReceiverPhone.text = receiverP;
                              });

                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                child: Column(
                                  children: [

                                    TextFormField(
                                      controller: updateReceiverName,
                                      style: const TextStyle(color: Colors.black), // Set text color to white
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Iconsax.message, color: Colors.white),
                                        hintText: "Update Your Name",
                                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 12), // Set hint text color to white with opacity
                                        border: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black, width: 2),
                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                        ),
                                        focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black, width: 2),
                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 10,
                                    ),

                                    TextFormField(
                                      controller: updateReceiverAddress,
                                      style: const TextStyle(color: Colors.black), // Set text color to white
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Iconsax.message, color: Colors.white),
                                        hintText: "Update Your Address",
                                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 12), // Set hint text color to white with opacity
                                        border: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black, width: 2),
                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                        ),
                                        focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black, width: 2),
                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 10,
                                    ),

                                    TextFormField(
                                      controller: updateReceiverPhone,
                                      style: const TextStyle(color: Colors.black), // Set text color to white
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Iconsax.message, color: Colors.white),
                                        hintText: "Update Your Phone Number",
                                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 12), // Set hint text color to white with opacity
                                        border: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black, width: 2),
                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                        ),
                                        focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black, width: 2),
                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 10,),

                                    ElevatedButton(
                                      onPressed: () {
                                        _billingController.updateBillings(BillingModel(
                                            billingID: billingID,
                                            receiverName: updateReceiverName.text,
                                            receiverAddress: updateReceiverAddress.text,
                                            receiverPhone: updateReceiverPhone.text
                                        ), context);
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                            return states.contains(MaterialState.disabled) ? Colors.grey : Colors.white;
                                          },
                                        ),
                                      ),
                                      child: const Text(
                                        "Update Billing",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),

                                  ],
                                ),
                              );
                            },)
                              ,);
                          }, icon: const Icon(Iconsax.edit1)),
                          IconButton(onPressed: (){
                            _billingController.deleteBillings(billingID, context);
                          }, icon: const Icon(Iconsax.trash, color: Colors.red,)),
                        ],
                      ),
                    ),
                  );
                },): const Center(child: Text("No Data Available"),);
            } else if (snapshot.hasError) {
              return const Icon(Icons.error, color: Colors.red,);
            } else {
              return const CircularProgressIndicator();
            }
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade100,
        onPressed: (){
          showModalBottomSheet(context: context, builder: (context) => Builder(builder: (context) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [

                  TextFormField(
                    controller: receiverName,
                    style: const TextStyle(color: Colors.black), // Set text color to white
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.message, color: Colors.white),
                      hintText: "Enter Your Name",
                      hintStyle: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 12), // Set hint text color to white with opacity
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  TextFormField(
                    controller: receiverAddress,
                    style: const TextStyle(color: Colors.black), // Set text color to white
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.message, color: Colors.white),
                      hintText: "Enter Your Address",
                      hintStyle: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 12), // Set hint text color to white with opacity
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  TextFormField(
                    controller: receiverPhone,
                    style: const TextStyle(color: Colors.black), // Set text color to white
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.message, color: Colors.white),
                      hintText: "Enter Your Phone Number",
                      hintStyle: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 12), // Set hint text color to white with opacity
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10,),

                  ElevatedButton(
                    onPressed: () {
                      _billingController.addBillings(BillingModel(
                        billingID: const Uuid().v1(),
                        receiverName: receiverName.text,
                        receiverPhone: receiverPhone.text,
                        receiverAddress: receiverAddress.text,
                        userEmail: uEmail
                      ), context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          return states.contains(MaterialState.disabled) ? Colors.grey : Colors.white;
                        },
                      ),
                    ),
                    child: const Text(
                      "Add Billing",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),

                ],
              ),
            );
          },)
            ,);
          },child: const Icon(Iconsax.add,color: Colors.green,),),
    );
  }
}
