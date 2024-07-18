import 'package:carousel_slider/carousel_slider.dart';
import 'package:eproject/MVC/register_screen/register_controller.dart';
import 'package:eproject/addtocart.dart';
import 'package:eproject/contact_screen.dart';
import 'package:eproject/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'description_screen.dart';


class UserDashBoard extends StatefulWidget {
  const UserDashBoard({super.key});

  @override
  State<UserDashBoard> createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {

  String uEmail = "";

  List bookImages = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_XwlgWBADdk6Esq0AEERt3tcZ1M7V8NrPXA&s',
    'data:image/jpeg;base64,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',
    'data:image/jpeg;base64,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',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoXeIzI57sO_WsfP5Fjpy7fhT8WaroCmts9A&s'
  ];

  List bookCate = ["Adventure", "Adventure","Adventure","Adventure" ];
  // Book Name
  List bookName = ["Harry Potter", "Rich dad poor dad"];
  // Book Price
  List bookPrice = ["\$49", "\$100"];
  // Book Rating
  List bookRating = [4.5, 5];

  UserRegisterLogin userRegisterLogin = UserRegisterLogin();

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
    timeDilation =2.0;
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.black87,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage("logo.png"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(child: Text(uEmail,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),)),
            const Center(
              child: SizedBox(
                width: 40,
                child: Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
              ),
            ),

            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const WishListScreen(),));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const ListTile(
                  leading: Icon(Iconsax.heart,color: Colors.white,),
                  title: Text("Your WishList",style: TextStyle(color: Colors.white),),
                ),
              ),
            ),

            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen(),));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const ListTile(
                  leading: Icon(Iconsax.shopping_bag,color: Colors.white,),
                  title: Text("Your Cart",style: TextStyle(color: Colors.white),),
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const ListTile(
                leading: Icon(Iconsax.user,color: Colors.white,),
                title: Text("Your Profile",style: TextStyle(color: Colors.white),),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const ListTile(
                leading: Icon(Iconsax.user,color: Colors.white,),
                title: Text("Our Blog",style: TextStyle(color: Colors.white),),
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const ListTile(
                leading: Icon(Iconsax.call,color: Colors.white,),
                title: Text("Contact Us",style: TextStyle(color: Colors.white),),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const ListTile(
                leading: Icon(Iconsax.user,color: Colors.white,),
                title: Text("About Us",style: TextStyle(color: Colors.white),),
              ),
            ),
            GestureDetector(
              onTap: (){
                userRegisterLogin.userLogout(context);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const ListTile(
                  leading: Icon(Iconsax.logout_1, color: Colors.red,),
                  title: Text("Logout", style: TextStyle(color: Colors.red),),
                ),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                decoration: BoxDecoration(
                  color: Colors.black87,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                width: double.infinity,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Builder(builder: (context) => IconButton(
                      // style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.white)),
                      onPressed: (){
                      Scaffold.of(context).openDrawer();
                    }, icon: const Icon(Iconsax.textalign_justifyright,
                      color: Colors.white,
                      ),),),

                    const Text("Book App", style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),

                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      backgroundImage: const AssetImage('images/logo.png'),
                    )
                  ],
                ),
              ),
              // const SizedBox(
              //   height: 16,
              // ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     SizedBox(
              //       width: 80,
              //       child: Divider(
              //         color: Colors.grey.shade400,
              //         thickness: 1,
              //       ),
              //     ),
              //
              //     // const SizedBox(
              //     //   width: 6,
              //     // ),
              //
              //     // const Text("Categories We Deal", style: TextStyle(color: Colors.black ,fontSize: 14,fontWeight: FontWeight.w600),),
              //
              //     // const SizedBox(
              //     //   width: 6,
              //     // ),
              //
              //     SizedBox(
              //       width: 80,
              //       child: Divider(
              //         color: Colors.grey.shade400,
              //         thickness: 1,
              //       ),
              //     )
              //   ],
              // ),

              // const SizedBox(
              //   height: 16,
              // ),

              CarouselSlider.builder(
                  itemCount: bookImages.length,
                  itemBuilder:  (context, index, realIndex) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                            image: NetworkImage(bookImages[index]))
                      ),
                      child:  Container(
                          margin: const EdgeInsets.only(left: 14,top: 120),
                          child:  Text(bookCate[index], style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),)),
                    );
                  },
                  options: CarouselOptions(
                    autoPlay: true,
                    height: 180,
                    viewportFraction: 1,
                    autoPlayInterval: const Duration(milliseconds: 2000),
                    scrollDirection: Axis.vertical
                  )),

              const SizedBox(
                height: 16,
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

                  const Text("Categories We Deal", style: TextStyle(color: Colors.black ,fontSize: 14,fontWeight: FontWeight.w600),),

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
                height: 16,
              ),

              SizedBox(
                width: double.infinity,
                height: 240,
                child: Hero(
                  tag: "bookImage",
                  child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                    return index != 3 ? GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BookDescription( bookImage: bookImages[index]),));
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
                                image: NetworkImage(bookImages[index])),
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
                                const Text("Islamic Book", style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),
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
                    ) : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: 160,
                      height: 220,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),

                        ),
                        alignment: Alignment.center,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("View All", style: TextStyle(color: Colors.red ,fontSize: 14,fontWeight: FontWeight.w600),),
                          SizedBox(width: 4,),
                          Icon(Icons.chevron_right_sharp, color: Colors.red,)
                        ],
                      )
                    );
                  },),
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

                  const Text("New To Shell", style: TextStyle(color: Colors.black ,fontSize: 14,fontWeight: FontWeight.w600),),

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
                height: 20,
              ),

              SizedBox(
                width: double.infinity,
                height: 240,
                child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return index != 3 ? GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BookDescription(bookImage: bookImages[index]),));
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
                                image: NetworkImage(bookImages[index])),
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
                                const Text("Mystery Book", style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),
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
                    ) : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        width: 160,
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),

                        ),
                        alignment: Alignment.center,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("View All", style: TextStyle(color: Colors.red ,fontSize: 14,fontWeight: FontWeight.w600),),
                            SizedBox(width: 4,),
                            Icon(Icons.chevron_right_sharp, color: Colors.red,)
                          ],
                        )
                    );
                  },),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
