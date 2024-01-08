import 'dart:convert';

ResponseRecipeSaved responseRecipeSavedFromJson(String str) =>
    ResponseRecipeSaved.fromJson(json.decode(str));

String responseRecipeSavedToJson(ResponseRecipeSaved data) =>
    json.encode(data.toJson());

class ResponseRecipeSaved {
  ResponseRecipeSaved({
    required this.resp,
    required this.message,
    required this.listSavedRecipe,
  });

  bool resp;
  String message;
  List<ListSavedRecipe> listSavedRecipe;

  factory ResponseRecipeSaved.fromJson(Map<String, dynamic> json) =>
      ResponseRecipeSaved(
        resp: json["resp"],
        message: json["message"],
        listSavedRecipe: List<ListSavedRecipe>.from(
            json["listSavedRecipe"].map((x) => ListSavedRecipe.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "listSavedRecipe":
            List<dynamic>.from(listSavedRecipe.map((x) => x.toJson())),
      };
}

class ListSavedRecipe {
  ListSavedRecipe({
    required this.recipeSaveUid,
    required this.recipeUid,
    required this.personUid,
    required this.dateSave,
    required this.avatar,
    required this.username,
    required this.images,
  });

  String recipeSaveUid;
  String recipeUid;
  String personUid;
  DateTime dateSave;
  String avatar;
  String username;
  String images;

  factory ListSavedRecipe.fromJson(Map<String, dynamic> json) =>
      ListSavedRecipe(
        recipeSaveUid: json["recipe_save_uid"],
        recipeUid: json["recipe_uid"],
        personUid: json["person_uid"],
        dateSave: DateTime.parse(json["date_save"]),
        avatar: json["avatar"],
        username: json["username"],
        images: json["images"],
      );

  Map<String, dynamic> toJson() => {
        "recipe_save_uid": recipeSaveUid,
        "recipe_uid": recipeUid,
        "person_uid": personUid,
        "date_save": dateSave.toIso8601String(),
        "avatar": avatar,
        "username": username,
        "images": images,
      };
}
