part of 'recipe_bloc.dart';

@immutable
class RecipeState {

  // final int privacyRecipe;
  final List<File>? imageFileSelectedRecipe;
  final bool isSearchFriend;

  const RecipeState({
    // this.privacyRecipe = 1,
    this.imageFileSelectedRecipe,
    this.isSearchFriend = false,
  });

  RecipeState copyWith({ List<File>? imageFileSelectedRecipe, bool? isSearchFriend,})
    => RecipeState(
        // privacyRecipe: privacyRecipe ?? this.privacyRecipe,
        imageFileSelectedRecipe: imageFileSelectedRecipe ?? this.imageFileSelectedRecipe,
        isSearchFriend: isSearchFriend ?? this.isSearchFriend,
      );


}


class LoadingRecipe extends RecipeState {}
class LoadingSaveRecipe extends RecipeState {}

class FailureRecipe extends RecipeState {
  final String error;

  const FailureRecipe(this.error);
}

class SuccessRecipe extends RecipeState {}

// class LoadingRecipe extends RecipeState {}
// class SuccessRecipe extends RecipeState {}
