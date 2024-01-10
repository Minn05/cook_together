import 'dart:convert';

ResponseUser responseUserFromJson(String str) =>
    ResponseUser.fromJson(json.decode(str));

String responseUserToJson(ResponseUser data) => json.encode(data.toJson());

class ResponseUser {
  bool resp;
  String message;
  User user;
  RecipesUser recipesUser;

  ResponseUser({
    required this.resp,
    required this.message,
    required this.user,
    required this.recipesUser,
  });

  factory ResponseUser.fromJson(Map<String, dynamic> json) => ResponseUser(
        resp: json["resp"],
        message: json["message"],
        user: User.fromJson(json["user"]),
        recipesUser: RecipesUser.fromJson(json["recipes"]),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "user": user.toJson(),
        "recipes": recipesUser.toJson(),
      };
}

class RecipesUser {
  int posters;
  int friends;
  int followers;

  RecipesUser({
    required this.posters,
    required this.friends,
    required this.followers,
  });

  factory RecipesUser.fromJson(Map<String, dynamic> json) => RecipesUser(
        posters: json["posters"] ?? 0,
        friends: json["friends"] ?? 0,
        followers: json["followers"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "posters": posters,
        "friends": friends,
        "followers": followers,
      };
}

class User {
  String uid;
  String username;
  String fullname;
  String image;
  String cover;
  DateTime birthdayDate;
  String height;
  String weight;
  DateTime createdAt;
  int isPrivate;
  int isOnline;
  String email;

  User({
    required this.uid,
    required this.fullname,
    required this.image,
    required this.cover,
    required this.birthdayDate,
    required this.height,
    required this.weight,
    required this.createdAt,
    required this.username,
    required this.isPrivate,
    required this.isOnline,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json["uid"] ?? '',
        fullname: json["fullname"] ?? '',
        image: json["image"] ?? '',
        cover: json["cover"] ?? '',
        birthdayDate: DateTime.parse(json["birthday"] ?? '2021-10-22T20:17:53'),
        createdAt: DateTime.parse(json["created_at"] ?? '2021-10-22T20:17:53'),
        username: json["user"] ?? '',
        height: json["height"] ?? "",
        weight: json["weight"] ?? "",
        isPrivate: json["is_private"] ?? -0,
        isOnline: json["is_online"] ?? -0,
        email: json["email"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "fullname": fullname,
        "image": image,
        "cover": cover,
        "birthday_date": birthdayDate,
        "created_at": createdAt.toIso8601String(),
        "user": username,
        "height": height,
        "weight": weight,
        "is_private": isPrivate,
        "is_online": isOnline,
        "email": email,
      };
}
