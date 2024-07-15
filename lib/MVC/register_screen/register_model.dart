class RegisterModel{
  final String? userID;
  final String? userName;
  final String? userAge;
  final String? userAddress;
  final String? userEmail;
  final String? userPassword;

  RegisterModel(
      {
        this.userID,
        this.userName,
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