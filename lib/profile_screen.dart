import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // Background color of the app bar
        title: Center(child: Text('Profile Page',style: TextStyle(color: Colors.white),)), // Custom text for the app bar title
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Background image container
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://example.com/background.jpg', // Replace with your image URL
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
                    'https://cdn.pixabay.com/photo/2024/06/24/04/05/woman-8849047_1280.jpg', // Replace with your avatar image URL
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Your Name',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Job Title | Company',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  elevation: 4, // Add elevation for the card shadow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Optional: add rounded corners to the card
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'About Me',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                              'Fusce quis nisi quis augue vehicula vestibulum ut id ipsum.',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Divider(),
                        SizedBox(height: 10),
                        Text(
                          'Contact Information',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        ListTile(
                          leading: Icon(Icons.email),
                          title: Text('youremail@example.com'),
                        ),
                        ListTile(
                          leading: Icon(Icons.phone),
                          title: Text('+1234567890'),
                        ),
                        ListTile(
                          leading: Icon(Icons.web),
                          title: Text('yourwebsite.com'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

