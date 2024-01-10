import 'dart:convert';

ResponseSearch responseSearchFromJson(String str) =>
    ResponseSearch.fromJson(json.decode(str));

String responseSearchToJson(ResponseSearch data) => json.encode(data.toJson());

class ResponseSearch {
  ResponseSearch({
    required this.resp,
    required this.message,
    required this.userFind,
  });

  bool resp;
  String message;
  List<UserFind> userFind;

  factory ResponseSearch.fromJson(Map<String, dynamic> json) => ResponseSearch(
        resp: json["resp"],
        message: json["message"],
        userFind: List<UserFind>.from(
            json["userFind"].map((x) => UserFind.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "userFind": List<dynamic>.from(userFind.map((x) => x.toJson())),
      };
}

class UserFind {
  UserFind({
    required this.uid,
    required this.fullname,
    required this.avatar,
    required this.username,
  });

  String uid;
  String fullname;
  String avatar;
  String username;

  factory UserFind.fromJson(Map<String, dynamic> json) => UserFind(
        uid: json["uid"],
        fullname: json["fullname"],
        avatar: json["avatar"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "fullname": fullname,
        "avatar": avatar,
        "username": username,
      };
}

class ResponseSearchByKeyWord {
  ResponseSearchByKeyWord({
    required this.resp,
    required this.message,
    required this.user,
  });

  bool resp;
  String message;
  List<ResponseSearchByKeyWordItem> user;

  factory ResponseSearchByKeyWord.fromJson(Map<String, dynamic> json) =>
      ResponseSearchByKeyWord(
        resp: json["resp"] ?? '',
        message: json["message"] ?? '',
        user: List<ResponseSearchByKeyWordItem>.from(
            json["user"].map((x) => ResponseSearchByKeyWordItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "user": List<dynamic>.from(user.map((x) => x.toJson())),
      };
}

class ResponseSearchByKeyWordItem {
  ResponseSearchByKeyWordItem({
    required this.uid,
    required this.fullname,
    required this.avatar,
    required this.username,

    // required this.title,
    // required this.category,
    // required this.image
  });

  String uid;
  String fullname;
  String avatar;
  String username;
  // String title;
  // String category;
  // String image;

  factory ResponseSearchByKeyWordItem.fromJson(Map<String, dynamic> json) =>
      ResponseSearchByKeyWordItem(
        uid: json["uid"] ?? "",
        fullname: json["fullname"] ?? "",
        avatar: json["avatar"] ?? "",
        username: json["username"] ?? "",
        // category: json["category"] ?? "",
        // image: json["image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "fullname": fullname,
        "avatar": avatar,
        "username": username,
        // "category": category,
        // "image": image,
      };
}
