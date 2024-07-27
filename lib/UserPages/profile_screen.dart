import 'package:eproject/admin/Users/user_controller.dart';
import 'package:eproject/admin/Users/user_model.dart';
import 'package:flutter/material.dart';

import 'update_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  UserRegisterLogin userRegisterLogin = UserRegisterLogin();

  String userEmail = "";

  @override
  void initState() {
    // TODO: implement initState
    UserRegisterLogin.userCredGet().then((value){
      setState(() {
        userEmail = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Center(child: Text('Profile Page',style: TextStyle(color: Colors.white),)), // Custom text for the app bar title
      ),
      body: StreamBuilder(stream: userRegisterLogin.getUser(userEmail), builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {

        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }

        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              UserModel userData = snapshot.data![index];
              String userName = userData.userName!;
              String userImage = userData.getImage!;
              String userEmail = userData.userEmail!;
              String userAddress = userData.userAddress!;
              String userPassword = userData.userPassword!;
              String userAge = userData.userAge!;
              String userID = userData.userID!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Background image container
                  const SizedBox(height: 10,),

                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(''
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            userImage, // Replace with your avatar image URL
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          userName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          userEmail,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Card(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          elevation: 4, // Add elevation for the card shadow
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Optional: add rounded corners to the card
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'About Me',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  userAddress,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 10),
                                const Divider(),
                                const SizedBox(height: 10),
                                const Text(
                                  'Contact Information',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ListTile(
                                  leading: const Icon(Icons.email),
                                  title: Text(userEmail),
                                ),
                                ListTile(
                                  leading: const Icon(Icons.phone),
                                  title: Text(userID),
                                ),
                                ListTile(
                                  leading: const Icon(Icons.web),
                                  title: Text(userAge),
                                ),

                                Row(
                                  children: [
                                    ElevatedButton(onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterUpdate(
                                          userID: userID,
                                          userName: userName,
                                          userImage: userImage,
                                          userAddress: userAddress,
                                          userEmail: userEmail,
                                          userPassword: userPassword,
                                          userAge: userAge),));
                                    }, child: const Icon(Icons.update)),
                                    ElevatedButton(onPressed: (){
                                      userRegisterLogin.userDelete(userID, userImage, context);
                                    }, child: const Icon(Icons.delete, color: Colors.red,)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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

