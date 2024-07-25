class OrderModel{
  final String? orderID;
  final String? totalPrice;
  final String? orderStatus;
  final String? userEmail;
  final List? orderItem;

  OrderModel({this.orderID,this.orderStatus ,this.totalPrice ,this.userEmail , this.orderItem});
}