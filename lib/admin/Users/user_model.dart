import 'dart:io';

import 'package:flutter/foundation.dart';

class UserModel{
  final String? userID;
  final String? userName;
  final String? getImage;
  final String? userAge;
  final String? userAddress;
  final String? userEmail;
  final String? userPassword;
  final File? userImage;
  final Uint8List? userImageWeb;

  UserModel(
      {
        this.userID,
        this.userName,
        this.getImage,
        this.userImage,
        this.userImageWeb,
      this.userAge,
      this.userAddress,
      this.userEmail,
      this.userPassword});
}



class LoginModel{
  final String? userEmail;
  final String? userPassword;

  LoginModel({this.userEmail, this.userPassword});
}