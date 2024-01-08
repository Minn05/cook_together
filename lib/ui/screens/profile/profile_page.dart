import 'package:flutter/material.dart';
import 'package:recipes/constants.dart';
import 'package:recipes/data/env/env.dart';
import 'package:recipes/domain/models/response/response_profile.dart';
import 'package:recipes/domain/services/user_services.dart';
import 'package:recipes/ui/screens/home/recipe_detail.dart';
import 'package:recipes/ui/screens/profile/setting_profile_page.dart';

import 'package:recipes/ui/themes/colors_theme.dart';
import 'package:recipes/ui/themes/title_appbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileDetail profile;
  late List<RecipeCreated> recipecreated;
  late List<RecipeSaved> recipesaved;
  late double bmiIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TitleAppbar(
          title: "Thông tin cá nhân",
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(14)),
              child: IconButton(
                  splashRadius: 20,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const SettingProfilePage();
                      },
                    ));
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.black,
                  )),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
          future: userService.getProfile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              profile = snapshot.data!.profile;
              bmiIndex = (profile.weight / (profile.height * profile.height));
              recipecreated = snapshot.data!.recipecreated;
              recipesaved = snapshot.data!.recipeSaved;
              // tripsImage = snapshot.data!.tripsImage;
              // postsImage = snapshot.data!.postsImage;
            }
            return !snapshot.hasData
                ? const Center(child: Text("Loading...."))
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Row(
                            children: [
                              Container(
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                  // shape: BoxShape.circle,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        Environment.baseUrl + profile.avatar),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    profile.fullname,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: kTitle2Style,
                                  ),
                                  Text(
                                    profile.email,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: kSubtitleStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Followers
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 60,
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: ColorsCustom.primary,
                                          width: 2.5),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          profile.countUserFollower.toString(),
                                          style: kSubtitleStyle.copyWith(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          'Followers',
                                          style: kSubtitleStyle.copyWith(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 60,
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: ColorsCustom.primary,
                                            width: 2.5)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          profile.countUserFollowing.toString(),
                                          style: kSubtitleStyle.copyWith(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          'Following',
                                          style: kSubtitleStyle.copyWith(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.09,
                                    width: MediaQuery.of(context).size.width *
                                        0.27,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Chiều cao',
                                          style: kSubtitleStyle.copyWith(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          '${profile.height.toString()} m',
                                          style: kSubtitleStyle.copyWith(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 4,
                                    width: MediaQuery.of(context).size.width *
                                        0.27,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.blue.shade300,
                                          blurRadius: 5,
                                          offset: const Offset(0.0, 2.0),
                                        ),
                                      ],
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.blue.withOpacity(0.2),
                                          Colors.blue.withOpacity(0.7),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.09,
                                    width: MediaQuery.of(context).size.width *
                                        0.27,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Cân nặng',
                                          style: kSubtitleStyle.copyWith(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          '${profile.weight.toString()} kg',
                                          style: kSubtitleStyle.copyWith(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 4,
                                    width: MediaQuery.of(context).size.width *
                                        0.27,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.amber.shade300,
                                          blurRadius: 5,
                                          offset: const Offset(0.0, 2.0),
                                        ),
                                      ],
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.amber.withOpacity(0.2),
                                          Colors.amber.withOpacity(0.7),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.09,
                                    width: MediaQuery.of(context).size.width *
                                        0.27,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Chỉ số BMI ',
                                          style: kSubtitleStyle.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          bmiIndex.toStringAsFixed(2),
                                          style: kSubtitleStyle.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 4,
                                    width: MediaQuery.of(context).size.width *
                                        0.27,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorsCustom.primary
                                              .withOpacity(0.4),
                                          blurRadius: 5,
                                          offset: const Offset(0.0, 2.0),
                                        ),
                                      ],
                                      gradient: LinearGradient(
                                        colors: [
                                          ColorsCustom.primary.withOpacity(0.3),
                                          ColorsCustom.primary,
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bài viết của bạn',
                                style: kTitle2Style,
                              ),
                            ],
                          ),
                        ),
                        _recipeCreated(recipecreated: recipecreated),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bài viết bạn đã lưu',
                                style: kTitle2Style,
                              ),
                            ],
                          ),
                        ),
                        _recipeSaved(recipeSaved: recipesaved),
                      ],
                    ),
                  );
          }),
      // bottomNavigationBar: const BottomNavigation(index: 6),
    );
  }

  // Widget _renderTripCard(TripProfile trip) {
  //   return Padding(
  //     padding: const EdgeInsets.all(10),
  //     child: Container(
  //       width: 200,
  //       constraints: const BoxConstraints(minHeight: 150),
  //       margin: const EdgeInsets.only(right: 8),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         boxShadow: const [
  //           BoxShadow(
  //               color: Colors.black12, offset: Offset(0, -5), blurRadius: 5),
  //           BoxShadow(
  //               color: Colors.black12, offset: Offset(0, 5), blurRadius: 5)
  //         ],
  //         borderRadius: BorderRadius.circular(14),
  //       ),
  //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
  //       child: Column(
  //         children: [
  //           Container(
  //             height: 80,
  //             width: 200,
  //             decoration: BoxDecoration(
  //               // shape: BoxShape.circle,
  //               borderRadius: BorderRadius.circular(10),
  //               image: const DecorationImage(
  //                 fit: BoxFit.fill,
  //                 image:
  //                     NetworkImage(Environment.baseUrl + "cover_default.jpg"),
  //               ),
  //             ),
  //           ),
  //           Container(
  //             padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: <Widget>[
  //                 Text(
  //                   trip.title,
  //                   style: TextStyle(
  //                       overflow: TextOverflow.ellipsis,
  //                       fontSize: 15,
  //                       color: Colors.grey[800],
  //                       fontWeight: FontWeight.w800),
  //                   maxLines: 2,
  //                 ),
  //                 Container(height: 5),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.end,
  //                   children: [
  //                     NumberDetail(
  //                       value: "${trip.memberJoined}",
  //                       modifier: "Thành viên",
  //                     ),
  //                     NumberDetail(
  //                       value: "${trip.totalComment}",
  //                       modifier: "Bình luận",
  //                     ),
  //                     NumberDetail(
  //                       value: "${trip.avgRate}",
  //                       modifier: "Đánh giá",
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

class _recipeCreated extends StatelessWidget {
  const _recipeCreated({
    super.key,
    required this.recipecreated,
  });

  final List<RecipeCreated> recipecreated;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: recipecreated.length == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      'assets/asset/images/sad.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Có vẻ bạn chưa tạo bài viết nào',
                    style: kHeadlineLabelStyle.copyWith(
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recipecreated.length,
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 246, 249, 249),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              recipecreated[i].title,
                              style: kTitle2Style,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecipeDetailPage(
                                    recipeId: recipecreated[i].recipeUid),
                              ),
                            );
                          },
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: NetworkImage(
                                recipecreated[i].image != ""
                                    ? Environment.baseUrl +
                                        recipecreated[i].image
                                    : "${Environment.baseUrl}default-image.png",
                              ),
                              fit: BoxFit.cover,
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // genderRecipeCreated(
              //     recipeCreated: recipecreated[i]),
            ),
    );
  }
}

class _recipeSaved extends StatelessWidget {
  const _recipeSaved({super.key, required this.recipeSaved});
  final List<RecipeSaved> recipeSaved;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: recipeSaved.length == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      'assets/asset/images/sad.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Bạn chưa lưu bài viết nào ',
                    style: kHeadlineLabelStyle.copyWith(
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recipeSaved.length,
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 246, 249, 249),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              recipeSaved[i].title,
                              style: kTitle2Style,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecipeDetailPage(
                                    recipeId: recipeSaved[i].recipeUid),
                              ),
                            );
                          },
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: NetworkImage(
                                recipeSaved[i].image != ""
                                    ? Environment.baseUrl + recipeSaved[i].image
                                    : "${Environment.baseUrl}default-image.png",
                              ),
                              fit: BoxFit.cover,
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // genderRecipeCreated(
              //     recipeCreated: recipecreated[i]),
            ),
    );
  }
}
