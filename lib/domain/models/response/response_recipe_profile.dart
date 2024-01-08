import 'dart:convert';

ResponseRecipeProfile responseRecipeProfileFromJson(String str) => ResponseRecipeProfile.fromJson(json.decode(str));

String responseRecipeProfileToJson(ResponseRecipeProfile data) => json.encode(data.toJson());

class ResponseRecipeProfile {

    ResponseRecipeProfile({
        required this.resp,
        required this.message,
        required this.recipe,
    });

    bool resp;
    String message;
    List<RecipeProfile> recipe;

    factory ResponseRecipeProfile.fromJson(Map<String, dynamic> json) => ResponseRecipeProfile(
        resp: json["resp"],
        message: json["message"],
        recipe: List<RecipeProfile>.from(json["recipe"].map((x) => RecipeProfile.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "recipe": List<dynamic>.from(recipe.map((x) => x.toJson())),
    };
}

class RecipeProfile {

    RecipeProfile({
        required this.uid,
        required this.isComment,
        required this.typePrivacy,
        required this.createdAt,
        required this.images,
    });

    String uid;
    int isComment;
    String typePrivacy;
    DateTime createdAt;
    String images;

    factory RecipeProfile.fromJson(Map<String, dynamic> json) => RecipeProfile(
        uid: json["uid"] ?? '',
        isComment: json["is_comment"] ?? -0,
        typePrivacy: json["type_privacy"] ?? '',
        createdAt: DateTime.parse(json["created_at"] ?? json['']),
        images: json["images"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "is_comment": isComment,
        "type_privacy": typePrivacy,
        "created_at": createdAt.toIso8601String(),
        "images": images,
    };
}
