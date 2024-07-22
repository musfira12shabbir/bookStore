import 'package:eproject/description_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:iconsax/iconsax.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  List bookImages = ['https://img.freepik.com/free-photo/free-photo-ramadan-kareem-eid-mubarak-royal-elegant-lamp-with-mosque-holy-gate-with-fireworks_1340-23600.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3zGBjq4noT3fDsPJh5rcDuva6M4zI3YtZFQ&usqp=CAU',
    'https://images.gr-assets.com/misc/1687810621-1687810621_goodreads_misc.png',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGpR-ADg8E3M_p6k5QGiUCg2Klh78_lr05Mw&usqp=CAU',
    'https://assets.penguinrandomhouse.com/wp-content/uploads/2021/10/07211143/PRH_xmas-romance_HP_4-BOOKS_1200x628-839x439.jpg'];

  List bookCate = ["Islamic Books", "Motivational", "Adventure","poetry","Magic"];

  List bookName = [ "Tafseel", "Rich dad poor dad", "The beauti of the beast","John alia","Kala Jadu"];

  List bookprice= ["\$78", "\$90", "\$80","\$90",'\$79'];

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Your Cart",style: TextStyle(color: Colors.black),),
      ),
      body: ListView.builder(
        itemCount: bookImages.length,
        itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
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
                          image: NetworkImage(bookImages[index])),
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
                      Text(bookCate[index],style: TextStyle(color: Colors.black,fontSize: 14, fontWeight: FontWeight.w600),),
                      const SizedBox(
                        height: 8,
                      ),
                      Text("Book Price:",style: TextStyle(color: Colors.grey.shade400,fontSize: 12, fontWeight: FontWeight.w400),),
                      Text("Book Price Here",style: TextStyle(color: Colors.black,fontSize: 14, fontWeight: FontWeight.w600),),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text("x2",style: TextStyle(color: Colors.grey.shade400,fontSize: 12, fontWeight: FontWeight.w400),),
                          const SizedBox(
                            width: 6,
                          ),
                          Text("1,0000",style: TextStyle(color: Colors.black45,fontSize: 12, fontWeight: FontWeight.w400),),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
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
                Text("Total Price:",style: TextStyle(color: Colors.black54,fontSize: 14, fontWeight: FontWeight.w800),),
                Text("16,000/=",style: TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.w800),),
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
                  child: Text("Buy Now",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w400),) ),
                  Text("*T & C Applied*",style: TextStyle(color: Colors.black54,fontSize: 12, fontWeight: FontWeight.w800),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
