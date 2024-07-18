class BookModel{

  String? bookID;
  String? bookName;
  String? bookImage;
  String? bookPrice;
  String? bookDescription;
  String? bookISBN;
  String? bookAuthor;
  String? bookCategory;
  String? userRating;
  String? userID;
  String? userReview;

  BookModel(
      {
        this.bookID,
        this.bookName,
        this.bookImage,
      this.bookPrice,
      this.bookDescription,
      this.bookISBN,
      this.bookAuthor,
      this.bookCategory,
      this.userRating,
      this.userID,
      this.userReview});
}