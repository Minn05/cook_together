import 'dart:convert';

ResponseNotifications responseNotificationsFromJson(String str) =>
    ResponseNotifications.fromJson(json.decode(str));

String responseNotificationsToJson(ResponseNotifications data) =>
    json.encode(data.toJson());

class ResponseNotifications {
  ResponseNotifications({
    required this.resp,
    required this.message,
    required this.notificationsdb,
  });

  bool resp;
  String message;
  List<Notificationsdb> notificationsdb;

  factory ResponseNotifications.fromJson(Map<String, dynamic> json) =>
      ResponseNotifications(
        resp: json["resp"],
        message: json["message"],
        notificationsdb: List<Notificationsdb>.from(
            json["notificationsdb"].map((x) => Notificationsdb.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "notificationsdb":
            List<dynamic>.from(notificationsdb.map((x) => x.toJson())),
      };
}

class Notificationsdb {
  Notificationsdb({
    required this.uidNotification,
    required this.typeNotification,
    required this.createdAt,
    required this.personUid,
    required this.username,
    required this.followersUid,
    required this.follower,
    required this.avatar,
    // required this.recipUid,
  });

  String uidNotification;
  String typeNotification;
  DateTime createdAt;
  String personUid;
  String username;
  String followersUid;
  String follower;
  String avatar;
  // String recipUid;

  factory Notificationsdb.fromJson(Map<String, dynamic> json) =>
      Notificationsdb(
        uidNotification: json["uid_notification"],
        typeNotification: json["type_notification"],
        createdAt: DateTime.parse(json["created_at"]),
        personUid: json["person_uid"],
        username: json["username"],
        followersUid: json["followers_uid"],
        follower: json["follower"],
        avatar: json["avatar"],
        // recipUid: json["recipe_uid"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "uid_notification": uidNotification,
        "type_notification": typeNotification,
        "created_at": createdAt.toIso8601String(),
        "person_uid": personUid,
        "username": username,
        "followers_uid": followersUid,
        "follower": follower,
        "avatar": avatar,
        // "recipe_uid": recipUid,
      };
}
