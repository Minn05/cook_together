import 'dart:convert';

ResponseRecipeByUser responseRecipeByUserFromJson(String str) => ResponseRecipeByUser.fromJson(json.decode(str));

String responseRecipeByUserToJson(ResponseRecipeByUser data) => json.encode(data.toJson());

class ResponseRecipeByUser {

    ResponseRecipeByUser({
        required this.resp,
        required this.message,
        required this.recipeUser,
    });

    bool resp;
    String message;
    List<RecipeUser> recipeUser;

    factory ResponseRecipeByUser.fromJson(Map<String, dynamic> json) => ResponseRecipeByUser(
        resp: json["resp"],
        message: json["message"],
        recipeUser: List<RecipeUser>.from(json["recipeUser"].map((x) => RecipeUser.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "recipeUser": List<dynamic>.from(recipeUser.map((x) => x.toJson())),
    };
}

class RecipeUser {

    RecipeUser({
        required this.recipeUid,
        required this.isComment,
        required this.typePrivacy,
        required this.createdAt,
        required this.personUid,
        required this.username,
        required this.avatar,
        required this.images,
        required this.countComment,
        required this.countLikes,
        required this.isLike,
    });

    String recipeUid;
    int isComment;
    String typePrivacy;
    DateTime createdAt;
    String personUid;
    String username;
    String avatar;
    String images;
    int countComment;
    int countLikes;
    int isLike;

    factory RecipeUser.fromJson(Map<String, dynamic> json) => RecipeUser(
        recipeUid: json["recipe_uid"],
        isComment: json["is_comment"],
        typePrivacy: json["type_privacy"],
        createdAt: DateTime.parse(json["created_at"]),
        personUid: json["person_uid"],
        username: json["username"],
        avatar: json["avatar"],
        images: json["images"],
        countComment: json["count_comment"],
        countLikes: json["count_likes"],
        isLike: json["is_like"],
    );

    Map<String, dynamic> toJson() => {
        "recipe_uid": recipeUid,
        "is_comment": isComment,
        "type_privacy": typePrivacy,
        "created_at": createdAt.toIso8601String(),
        "person_uid": personUid,
        "username": username,
        "avatar": avatar,
        "images": images,
        "count_comment": countComment,
        "count_likes": countLikes,
        "is_like": isLike,
    };
}
