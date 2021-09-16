class usermodels {
  String name;

  String email;

  String phone;

  bool isverifation;

  usermodels( Map json) {

    email =json["email"] ;




  }
}
