import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 20),
            _buildIntroText(),
            SizedBox(height: 30),
            _buildMissionVision(),
            SizedBox(height: 30),
            _buildTeamSection(),
            SizedBox(height: 30),
            _buildContactInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 70,
            backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-dBwIn_u757gH_8cakmqRrXYlwGuBp_JRbYmtf6TgCLW2kBxdpF2yHS8Bv-ZyhB72ql4&usqp=CAU"),
          ),
          SizedBox(height: 20),
          Text(
            'Welcome to Our Bookstore',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'Explore, Discover, Enjoy!',
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildIntroText() {
    return Text(
      'At Our Bookstore, we are dedicated to providing a curated selection of books that inspire and entertain. Since our inception, we have been committed to fostering a love for reading within our community.',
      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
    );
  }

  Widget _buildMissionVision() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Our Mission & Vision',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          'Our mission is to promote literacy and lifelong learning by offering a diverse range of books that cater to different interests and age groups. We envision becoming a cultural hub where people gather to explore new ideas and stories.',
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    );
  }

  Widget _buildTeamSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Meet Our Team',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          'Our team consists of passionate book enthusiasts who are eager to assist you in finding the perfect book. We are dedicated to creating a welcoming environment where readers of all ages can indulge in their love for books.',
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Us',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          'For inquiries, recommendations, or feedback, feel free to reach out to us:',
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
        SizedBox(height: 10),
        InkWell(
          onTap: () {
            // Implement contact form or email link
          },
          child: Text(
            'contact@ourbookstore.com',
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        SizedBox(height: 10),
        InkWell(
          onTap: () {
            // Implement phone number dialing or linking
          },
          child: Text(
            '+1234567890',
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
