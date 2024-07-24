class CartModel{

  final String? cartID;
  final String? bookID;
  final String? bookName;
  final String? bookImage;
  final String? bookQuantity;
  final String? bookPrice;
  final String? totalPrice;
  final String? userEmail;

  CartModel(
      {this.cartID,
      this.bookID,
      this.bookName,
      this.bookImage,
      this.bookQuantity,
      this.bookPrice,
        this.totalPrice,
      this.userEmail});
}