import 'package:flutter/material.dart';
import 'package:recipes/data/env/env.dart';
import 'package:recipes/domain/models/response/response_recipe.dart';
import 'package:recipes/domain/services/recipe_services.dart';
import 'package:recipes/ui/themes/button.dart';
import 'package:recipes/ui/themes/colors_theme.dart';
import 'package:recipes/ui/widgets/widgets.dart';
import 'package:timeago/timeago.dart' as timeago;

class RecipeDetailPage extends StatefulWidget {
  const RecipeDetailPage({super.key, required this.recipeId});
  final String recipeId;
  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage>
    with TickerProviderStateMixin {
  // late TabController _tabController;
  RecipeDetail? recipeDetail;
  List<RecipeImage>? recipeImages;
  List<Ingredient>? ingredientList;
  List<StepRecipe>? steps;
  @override
  void initState() {
    super.initState();
    // _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    // _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const TextCustom(
          text: 'Chi tiết',
          fontWeight: FontWeight.w600,
          fontSize: 22,
          color: ColorsCustom.primary,
          isTitle: true,
        ),
        elevation: 0,
        leading: Button(
          height: 40,
          width: 40,
          bg: Colors.transparent,
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.black),
          onPress: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: FutureBuilder(
              future: recipeService.getDetailRecipeById(widget.recipeId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // if (snapshot.data!.recipe.isNotEmpty) {
                  recipeDetail = snapshot.data!.recipe[0];
                  // }

                  // if (snapshot.data!.steps.isNotEmpty) {
                  steps = snapshot.data!.steps;
                  // }
                  // if (snapshot.data!.ingredients.isNotEmpty) {
                  ingredientList = snapshot.data!.ingredients;
                  // }
                  // if (snapshot.data!.images.isNotEmpty) {
                  recipeImages = snapshot.data!.images;
                  // }
                }
                // final time =
                //     timeago.format(recipeDetail!.createdAt, locale: 'vi');

                return !snapshot.hasData
                    ? const Center(child: Text("Loading..."))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //image
                          SizedBox(
                            height: 250,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: recipeImages!.length,
                              itemBuilder: (context, index) {
                                return ImageContainer(
                                    imgUrl: recipeImages![index].recipeImgUrl);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.network(
                                        Environment.baseUrl +
                                            recipeDetail!.avatar,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                    //fullname
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            recipeDetail!.fullname,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          Text(timeago.format(
                                              recipeDetail!.createdAt,
                                              locale: 'vi'))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    '${recipeDetail!.calories.toString()} Calo',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   children: [
                                //     InkWell(
                                //       child: Container(
                                //         padding: const EdgeInsets.all(10),
                                //         decoration: BoxDecoration(
                                //           borderRadius: const BorderRadius.all(
                                //               Radius.circular(30)),
                                //           // gradient: LinearGradient(
                                //           //   colors: [
                                //           //     ColorsCustom.primary,
                                //           //     ColorsCustom.primary
                                //           //         .withOpacity(0.5),
                                //           //   ],
                                //           // ),
                                //         ),
                                //         child: const Icon(
                                //           Icons.bookmark_add_outlined,
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                recipeDetail!.title,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    // color: kPrimaryLabelColor,
                                    color: Colors.black,
                                    fontFamily: 'SF Pro Text',
                                    overflow: TextOverflow.ellipsis),
                                maxLines: 3,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(recipeDetail!.time),
                              )
                            ],
                          ),

                          Column(
                            children: [
                              Text(
                                recipeDetail!.description,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Divider(thickness: 1),
                          ),
                          //Nguyên liệu
                          const Text(
                            "Nguyên liệu ",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                // color: kPrimaryLabelColor,
                                color: Colors.black,
                                fontFamily: 'SF Pro Text',
                                overflow: TextOverflow.ellipsis),
                            maxLines: 3,
                          ),
                          _renderIngredients(),
                          const Text(
                            "Bước làm",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                // color: kPrimaryLabelColor,
                                color: Colors.black,
                                fontFamily: 'SF Pro Text',
                                overflow: TextOverflow.ellipsis),
                            maxLines: 3,
                          ),
                          _renderSteps(),

                          const SizedBox(height: 60),
                        ],
                      );
              }),
        ),
      ),
    );
  }

  Widget _renderIngredients() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ingredientList!
          .map((e) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  "${e.sort + 1}. ${formatSringCaitalize(e.name)}",
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      // color: kPrimaryLabelColor,
                      fontFamily: 'SF Pro Text',
                      overflow: TextOverflow.ellipsis),
                  maxLines: 3,
                ),
              ))
          .toList(),
    );
  }

  Widget _renderSteps() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: steps!
          .map((e) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bước ${e.sort + 1}. ",
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        // color: kPrimaryLabelColor,
                        fontFamily: 'SF Pro Text',
                        overflow: TextOverflow.ellipsis),
                    maxLines: 3,
                  ),
                  Text(
                    formatSringCaitalize(e.name),
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        // color: kPrimaryLabelColor,
                        fontFamily: 'SF Pro Text',
                        overflow: TextOverflow.ellipsis),
                    maxLines: 3,
                  ),
                ],
              ))
          .toList(),
    );
  }

  String formatSringCaitalize(String str) {
    return str[0].toUpperCase() + str.substring(1, str.length);
  }
}

// class BtnRecipeDetail extends StatelessWidget {
//   const BtnRecipeDetail({
//     super.key,
//     required this.child,
//     this.onTap,
//   });

//   final void Function()? onTap;
//   final Widget? child;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(30.0),
//           gradient: LinearGradient(
//             colors: [
//               ColorsCustom.primary,
//               ColorsCustom.primary.withOpacity(0.5),
//             ],
//           ),
//         ),
//         child: child,
//       ),
//     );
//   }
// }

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    // required this.size,
    required this.imgUrl,
  });

  // final Size size;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 400,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(Environment.baseUrl + imgUrl))),
    );
  }
}

// ignore: must_be_immutable
class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  late Color color;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);

    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
