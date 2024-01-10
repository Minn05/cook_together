import 'dart:convert';

ResponseUserSearch responseUserSearchFromJson(String str) =>
    ResponseUserSearch.fromJson(json.decode(str));

String responseUserSearchToJson(ResponseUserSearch data) =>
    json.encode(data.toJson());

class ResponseUserSearch {
  ResponseUserSearch(
      {required this.resp,
      required this.message,
      required this.anotherUser,
      required this.analytics,
      required this.recipesUser,
      required this.isFriend,
      required this.isPendingFollowers});

  bool resp;
  String message;
  AnotherUser anotherUser;
  Analytics analytics;
  List<RecipesUser> recipesUser;
  int isFriend;
  int isPendingFollowers;

  factory ResponseUserSearch.fromJson(Map<String, dynamic> json) =>
      ResponseUserSearch(
          resp: json["resp"],
          message: json["message"],
          anotherUser: AnotherUser.fromJson(json["anotherUser"]),
          analytics: Analytics.fromJson(json["analytics"]),
          recipesUser: List<RecipesUser>.from(
              json["recipes"].map((x) => RecipesUser.fromJson(x))),
          isFriend: json["is_friend"] ?? 0,
          isPendingFollowers: json["is_pending_follower"] ?? 0);

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "anotherUser": anotherUser.toJson(),
        "analytics": analytics.toJson(),
        "recipes": List<dynamic>.from(recipesUser.map((x) => x.toJson())),
        "is_friend": isFriend,
        "is_pending_follower": isPendingFollowers
      };
}

class Analytics {
  Analytics({
    required this.posters,
    required this.friends,
    required this.followers,
  });

  int posters;
  int friends;
  int followers;

  factory Analytics.fromJson(Map<String, dynamic> json) => Analytics(
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

class AnotherUser {
  AnotherUser({
    required this.uid,
    required this.fullname,
    required this.birthday,
    required this.avatar,
    required this.imagebg,
    // required this.birthdayDate,
    required this.createdAt,
    // required this.username,
    // required this.description,
    // required this.isPrivate,
    required this.email,
  });

  String uid;
  String fullname;
  String birthday;
  String avatar;
  String imagebg;
  // dynamic birthdayDate;
  DateTime createdAt;
  // String username;
  // String description;
  // int isPrivate;
  String email;

  factory AnotherUser.fromJson(Map<String, dynamic> json) => AnotherUser(
        uid: json["uid"] ?? '',
        fullname: json["fullname"] ?? '',
        birthday: json["birthday"] ?? '',
        avatar: json["avatar"] ?? '',
        imagebg: json["cover"] ?? '',
        // birthdayDate:
        //     DateTime.parse(json["birthday"] ?? '2021-10-22T20:17:53'),
        createdAt: DateTime.parse(json["created_at"] ?? '2021-10-22T20:17:53'),
        // username: json["username"],
        // description: json["description"] ?? '',
        // isPrivate: json["is_private"],
        email: json["email"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "fullname": fullname,
        "birthday": birthday,
        "avatar": avatar,
        // "cover": cover,
        // "birthday_date": birthdayDate,
        "created_at": createdAt.toIso8601String(),
        // "username": username,
        // "description": description,
        // "is_private": isPrivate,
        "email": email,
      };
}

class RecipesUser {
  RecipesUser(
      {required this.recipeUid, required this.createdAt, required this.images});

  String recipeUid;

  DateTime createdAt;
  String images;

  factory RecipesUser.fromJson(Map<String, dynamic> json) => RecipesUser(
        recipeUid: json["recipe_uid"] ?? '',
        createdAt: DateTime.parse(json["created_at"]),
        images: json["images"],
      );

  Map<String, dynamic> toJson() => {
        "recipe_uid": recipeUid,
        "created_at": createdAt.toIso8601String(),
        "images": images,
      };
}
