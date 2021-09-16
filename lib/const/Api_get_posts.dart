class getposts_API {
  String get_profile_image;

 String get_username;

String get_date;

String get_text_post;

  getposts_API.fromJson(Map<String, dynamic> json) {
    get_text_post = json["text_post"];
    get_username = json["user_name"];
    get_profile_image = json["profile_image"];
    get_date = json["date"];
  }
}
