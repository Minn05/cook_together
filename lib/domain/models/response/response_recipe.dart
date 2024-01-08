class ResponseRecipe {
  final bool resp;
  final String message;
  final List<Recipe> recipes;

  ResponseRecipe({
    required this.resp,
    required this.message,
    required this.recipes,
  });

  factory ResponseRecipe.fromJson(Map<String, dynamic> json) => ResponseRecipe(
        resp: json["resp"],
        message: json["message"],
        recipes:
            List<Recipe>.from(json["recipes"].map((x) => Recipe.fromJson(x))),
      );
}

class Recipe {
  final String title;
  final String image;
  final String fullName;
  final String uId;
  final String avatar;
  final String personUid;
  final DateTime created_at;
  final DateTime update_at;
  final int countLike;
  final int countComment;
  final int isLike;
  final int isSave;

  Recipe({
    required this.title,
    required this.image,
    required this.fullName,
    required this.uId,
    required this.avatar,
    required this.personUid,
    required this.created_at,
    required this.update_at,
    required this.countLike,
    required this.countComment,
    required this.isLike,
    required this.isSave,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        title: json["title"] ?? "",
        image: json["image_url"] ?? "",
        fullName: json["fullname"] ?? "",
        uId: json["uid"] ?? "",
        avatar: json["avatar"] ?? "",
        personUid: json["personUid"] ?? "",
        created_at: DateTime.parse(json["created_at"]),
        update_at: DateTime.parse(json["update_at"]),
        countComment: json["countComment"] ?? 0,
        countLike: json["countLike"] ?? 0,
        isLike: json["isLike"] ?? 0,
        isSave: json["isSave"] ?? 0,
      );
}

class ResponseRecipeDetail {
  final bool resp;
  final String message;
  final List<RecipeDetail> recipe;
  final List<RecipeImage> images;
  final List<Ingredient> ingredients;
  final List<StepRecipe> steps;

  ResponseRecipeDetail({
    required this.resp,
    required this.message,
    required this.recipe,
    required this.images,
    required this.ingredients,
    required this.steps,
  });

  factory ResponseRecipeDetail.fromJson(Map<String, dynamic> json) =>
      ResponseRecipeDetail(
        resp: json["resp"],
        message: json["message"],
        recipe: List<RecipeDetail>.from(
            json["recipes"].map((x) => RecipeDetail.fromJson(x))),
        images: List<RecipeImage>.from(
            json["images"].map((x) => RecipeImage.fromJson(x))),
        ingredients: List<Ingredient>.from(
            json["ingredients"].map((x) => Ingredient.fromJson(x))),
        steps: List<StepRecipe>.from(
            json["steps"].map((x) => StepRecipe.fromJson(x))),
      );
}

class Ingredient {
// `uid`, `recipe_uid`, `name`, `unit`, `sort`
  final String uid;
  final String recipeUid;
  final String name;
  final String unit;
  final int sort;

  Ingredient({
    required this.uid,
    required this.recipeUid,
    required this.name,
    required this.unit,
    required this.sort,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
      uid: json['uid'] ?? "",
      recipeUid: json['recipe_uid'] ?? "",
      name: json['name'] ?? "",
      sort: json['sort'] ?? 0,
      unit: json['unit'] ?? "");
}

class StepRecipe {
  final String uid;
  final String recipeUid;
  final String name;
  final int sort;

  StepRecipe({
    required this.uid,
    required this.recipeUid,
    required this.name,
    required this.sort,
  });

  factory StepRecipe.fromJson(Map<String, dynamic> json) => StepRecipe(
      uid: json['uid'] ?? "",
      recipeUid: json['recipe_uid'] ?? "",
      name: json['name'] ?? "",
      sort: json['sort'] ?? 0);
}

class RecipeImage {
  // /`uid`, `recipe_uid`, `image_url`
  final String uid;
  final String recipeImgUrl;

  RecipeImage({required this.uid, required this.recipeImgUrl});

  factory RecipeImage.fromJson(Map<String, dynamic> json) => RecipeImage(
      uid: json["uid"] ?? "", recipeImgUrl: json["image_url"] ?? "");
}

class RecipeDetail {
  final String uid;
  final String description;
  final String title;
  final String category;
  final String time;
  final int totalPeople;
  final int calories;
  final DateTime createdAt;
  final DateTime updateAt;
  final String recipeUid;
  final String fullname;
  final String userUid;
  final String avatar;

  RecipeDetail({
    required this.recipeUid,
    required this.uid,
    required this.description,
    required this.title,
    required this.category,
    required this.time,
    required this.totalPeople,
    required this.calories,
    required this.createdAt,
    required this.updateAt,
    required this.fullname,
    required this.userUid,
    required this.avatar,
  });

  // person.fullname, person.uid as userUid, person.image as avatar
  // `uid`, `title`, `description`, `category`, `totalPeople`,
  // `time`, `calories`, `person_uid`, `created_at`, `update_at`
  factory RecipeDetail.fromJson(Map<String, dynamic> json) => RecipeDetail(
      recipeUid: json["uid"] ?? '',
      title: json["title"] ?? '',
      description: json["description"] ?? "",
      avatar: json["avatar"] ?? "",
      calories: json["calories"] ?? 0,
      category: json["category"] ?? "",
      totalPeople: json["totalPeople"] ?? 0,
      fullname: json["fullname"] ?? "",
      time: json["time"] ?? "",
      uid: json["uid"] ?? "",
      userUid: json["userUid"] ?? "",
      createdAt: DateTime.parse(json["created_at"]),
      updateAt: DateTime.parse(json["update_at"]));
}
