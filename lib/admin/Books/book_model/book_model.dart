import 'dart:io';

import 'package:flutter/foundation.dart';

class BookModel{

  String? bookID;
  String? bookName;
  String? bookPrice;
  String? bookDescription;
  String? bookISBN;
  String? bookAuthor;
  String? bookCategory;
  String? userRating;
  String? userID;
  String? userReview;
  String? getImage;
  final File? bookImage;
  final Uint8List? bookImageWeb;

  BookModel(
      {
        this.bookID,
        this.bookName,
        this.bookImage,
        this.getImage,
        this.bookImageWeb,
      this.bookPrice,
      this.bookDescription,
      this.bookISBN,
      this.bookAuthor,
      this.bookCategory,
      this.userRating,
      this.userID,
      this.userReview});
}