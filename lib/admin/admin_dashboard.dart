import 'package:eproject/admin/Books/book_views/fetch_book_screen.dart';
import 'package:eproject/admin/Order/fetch_order.dart';
import 'package:eproject/admin/Users/fetch_users.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AdminDash extends StatefulWidget {
  const AdminDash({super.key});

  @override
  State<AdminDash> createState() => _AdminDashState();
}

class _AdminDashState extends State<AdminDash> {

  int currentIndex = 0;

  void pageShifter(index){
    setState(() {
      currentIndex = index;
    });
  }

  List adminScreens = <Widget>[
    FetchBook(),
    FetchOrder(),
    FetchUser(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: adminScreens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: pageShifter,
          currentIndex: currentIndex,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          unselectedItemColor: Colors.grey.shade400,
          selectedItemColor: Colors.black,

          items: [
        BottomNavigationBarItem(icon: Icon(Icons.book), label: "Books"),
        BottomNavigationBarItem(icon: Icon(Iconsax.box), label: "Orders"),
        BottomNavigationBarItem(icon: Icon(Iconsax.user), label: "Users"),
      ]),
    );
  }
}
