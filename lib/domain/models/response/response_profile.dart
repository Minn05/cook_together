// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResponseProfile {
  final bool resp;
  final String message;
  final ProfileDetail profile;
  final List<RecipeCreated> recipecreated;
  final List<RecipeSaved> recipeSaved;

  ResponseProfile({
    required this.resp,
    required this.message,
    required this.profile,
    required this.recipecreated,
    required this.recipeSaved,

  });

  factory ResponseProfile.fromJson(Map<String, dynamic> json) =>
      ResponseProfile(
        resp: json["resp"],
        message: json["message"],
        profile: ProfileDetail.fromJson(json['profile'][0]),
        recipecreated: List<RecipeCreated>.from(
            json["recipes"].map((x) => RecipeCreated.fromJson(x))),
        recipeSaved: List<RecipeSaved>.from(
            json["recipeSaved"].map((x) => RecipeSaved.fromJson(x))),
       
      );
}


class ProfileDetail {
  final String fullname;
  final String avatar;
  final DateTime birthday;
  final double height;
  final double weight;
  // final String coverImage;
  final String email;
  // final String username;
  // final String achievement;
  // final int isLeader;
  final int countTripCreated;
  final int countPostCreated;
  // final int countTripJoined;
  final int countUserFollowing;
  final int countUserFollower;
  ProfileDetail({
    required this.fullname,
    required this.avatar,
    required this.birthday,
    required this.height,
    required this.weight,
    required this.email,
    required this.countTripCreated,
    required this.countPostCreated,
    required this.countUserFollowing,
    required this.countUserFollower,
  });

  factory ProfileDetail.fromJson(Map<String, dynamic> json) => ProfileDetail(
      fullname: json['fullname'] ?? "",
      avatar: json['avatar'] ?? "",
      email: json['email'] ?? "",
      birthday: DateTime.parse(json["birthday"]) ,
      height: json['height'] + 0.0 ?? 0.0,
      weight: json['weight'] + 0.0 ?? 0.0,
      countTripCreated: json['countTripCreated'] ?? 0,
      countPostCreated: json['countPostCreated'] ?? 0,
      countUserFollowing: json['countUserFollowing'] ?? 0,
      countUserFollower: json['countUserFollower'] ?? 0);
} //  person.fullname, person.image, person.cover,person.is_leader, person.achievement,users.email, users.username,

class RecipeCreated {
  final String recipeUid;
  final String title;
  final String image;
  RecipeCreated({
    required this.recipeUid,
    required this.title,
    required this.image,
  });

  factory RecipeCreated.fromJson(Map<String, dynamic> json) => RecipeCreated(
      image: json['image'] ?? "",
      recipeUid: json['uid'] ?? "",
      title: json['title'] ?? "");
}

class RecipeSaved {
  final String recipeUid;
  final String title;
  final String image;
  RecipeSaved({
    required this.recipeUid,
    required this.title,
    required this.image,
  });
  factory RecipeSaved.fromJson(Map<String, dynamic> json) => RecipeSaved(
        recipeUid: json['uid'] ?? "",
        title: json['title'] ?? "",
        image: json['image'] ?? "",
      );
}
