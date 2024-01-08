import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipes/domain/models/response/response_recipe.dart';
import 'package:recipes/ui/screens/comments/comments_post_page.dart';
import 'package:recipes/ui/screens/home/recipe_detail.dart';
import 'package:recipes/ui/screens/profile/profile_another_user_page.dart';
import 'package:recipes/ui/themes/button.dart';
import 'package:recipes/ui/themes/logo.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:recipes/ui/helpers/helpers.dart';
import 'package:recipes/ui/screens/notifications/notifications_page.dart';
import 'package:recipes/domain/services/post_services.dart';
import 'package:recipes/data/env/env.dart';
import 'package:recipes/ui/widgets/widgets.dart';
import 'package:recipes/domain/blocs/post/post_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

Future<void> _refresh() {
  return Future.delayed(Duration(milliseconds: 100));
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state is LoadingSavePost || state is LoadingPost) {
          modalLoadingShort(context);
        } else if (state is FailurePost) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessPost) {
          Navigator.pop(context);
          setState(() {});
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Logo(),
          elevation: 0,
          actions: [
            Button(
              height: 40,
              width: 40,
              icon: const Icon(
                Icons.notifications_none_outlined,
                color: Colors.black,
              ),
              onPress: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationsPage()),
              ),
              bg: Colors.transparent,
            ),
          ],
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                // const _ListHistories(),
                const SizedBox(height: 5.0),
                FutureBuilder(
                  future: postService.getAllPostHome(),
                  builder: (_, snapshot) {
                    if (snapshot.data != null && snapshot.data!.isEmpty) {
                      return _ListWithoutPosts();
                    }
                    return !snapshot.hasData
                        ? const Column(
                            children: [
                              ShimmerCustom(),
                              SizedBox(height: 10.0),
                              ShimmerCustom(),
                              SizedBox(height: 10.0),
                              ShimmerCustom(),
                            ],
                          )
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, i) =>
                                _ListViewPosts(recipes: snapshot.data![i]),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
        // bottomNavigationBar: const BottomNavigation(index: 1)
      ),
    );
  }
}

class _ListViewPosts extends StatelessWidget {
  final Recipe recipes;

  const _ListViewPosts({Key? key, required this.recipes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postBloc = BlocProvider.of<PostBloc>(context);
    // final recipeBloc = BlocProvider.of<RecipeBloc>(context);

    // final List<String> listImages = recipes.image.split(',');
    final time = timeago.format(recipes.created_at, locale: 'vi');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileAnotherUserPage(
                                idUser: recipes.personUid,
                              ))),
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: NetworkImage(
                                Environment.baseUrl + recipes.avatar),
                            fit: BoxFit.cover)),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipes.fullName,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      time,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  ],
                ),
                const Spacer(),
                const SizedBox(width: 5),
                IconButton(
                    onPressed: () {
                      if (recipes.isSave == 0) {
                        postBloc.add(OnSavePostByUser(recipes.uId, 'save'));
                      } else {
                        postBloc.add(OnSavePostByUser(recipes.uId, 'unsave'));
                      }
                    },
                    icon: recipes.isSave != 0
                        ? const Icon(Icons.bookmark_rounded)
                        : const Icon(Icons.bookmark_outline)),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                width: double.infinity,
                child: Text(recipes.title),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(15),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RecipeDetailPage(recipeId: recipes.uId),
                    ),
                  );
                },
                child: Image.network(
                  recipes.image != ""
                      ? Environment.baseUrl + recipes.image
                      : "${Environment.baseUrl}default-image.png",
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    print('click like');
                    if (recipes.isLike == 0) {
                      postBloc.add(OnLikeOrUnLikePost(recipes.uId, 'like'));
                    } else {
                      postBloc.add(OnLikeOrUnLikePost(recipes.uId, 'unlike'));
                    }
                  },
                  icon: Icon(
                    recipes.isLike != 0
                        ? FluentSystemIcons.ic_fluent_heart_filled
                        : FluentSystemIcons.ic_fluent_heart_regular,
                  ),
                ),
                const SizedBox(width: 8.0),
                InkWell(
                    onTap: () {},
                    child: TextCustom(
                        text: recipes.countLike.toString(),
                        fontSize: 16,
                        color: Colors.black)),
                const SizedBox(width: 10.0),
                TextButton(
                  onPressed: () => Navigator.push(context,
                      routeFade(page: CommentsPostPage(uidPost: recipes.uId))),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/svg/message-icon.svg'),
                      const SizedBox(width: 5.0),
                      TextCustom(
                          text: recipes.countComment.toString(),
                          fontSize: 16,
                          color: Colors.black)
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ListWithoutPosts extends StatelessWidget {
  // final List<String> svgPosts = [
  //   'assets/svg/without-posts-home.svg',
  //   'assets/svg/without-posts-home.svg',
  //   'assets/svg/mobile-new-posts.svg',
  // ];

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return const Center(
      child: Text("Không có bài viết nào."),
    );
  }
}
