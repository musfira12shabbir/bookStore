

import 'package:eproject/admin/Users/user_controller.dart';
import 'package:eproject/admin/Users/user_model.dart';
import 'package:flutter/material.dart';


class FetchUser extends StatefulWidget {
  const FetchUser({super.key});

  @override
  State<FetchUser> createState() => _FetchUserState();
}

class _FetchUserState extends State<FetchUser> {
  UserRegisterLogin userRegisterLogin = UserRegisterLogin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'User List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: userRegisterLogin.getAllUser(),
        builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          }

          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                UserModel user = snapshot.data![index];
                String userID = user.userID!;
                String userEmail = user.userEmail!;
                String userName = user.userName!;
                String userImage = user.getImage!;
                String userAge = user.userAge!;
// File to String conversion
                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(backgroundImage: NetworkImage(userImage),),
                    title: Text(
                      userName,
                      style: const TextStyle(color: Colors.black),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price: $userEmail',
                          style: const TextStyle(color: Colors.black),
                        ), Text(
                          'Price: $userAge',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),

                  ),
                );
              },
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Icon(
                Icons.error,
                color: Colors.red,
              ),
            );
          }

          return const Center(
            child: Text(
              "No User Available",
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
