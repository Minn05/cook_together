part of 'recipe_bloc.dart';

@immutable
abstract class RecipeEvent {}

class OnSelectedImageEventRecipe extends RecipeEvent {
  final File imageSelected;

  OnSelectedImageEventRecipe(this.imageSelected);
}

class OnClearSelectedImageEventRecipe extends RecipeEvent {
  final int indexImage;

  OnClearSelectedImageEventRecipe(this.indexImage);
}

class OnAddNewRecipeEvent extends RecipeEvent {
  final String recipeTitle;
  final String recipeDescription;
  final String recipeCategory;
  final String recipeTotalPeople;
  final String recipeTime;
  final String recipeCalories;
  final List<TextEditingController> recipeIngredients;
  final List<TextEditingController> recipeSteps;

  OnAddNewRecipeEvent(
      this.recipeTitle,
      this.recipeDescription,
      this.recipeCategory,
      this.recipeTotalPeople,
      this.recipeTime,
      this.recipeCalories,
      this.recipeIngredients,
      this.recipeSteps);
}

class OnSaveRecipeByUser extends RecipeEvent {
  final String idRecipe;
  final String type;
  OnSaveRecipeByUser(this.idRecipe, this.type);
}

class OnJoinRecipe extends RecipeEvent {
  final String recipeId;
  final String type;

  OnJoinRecipe(this.recipeId, this.type);
}

class OnIsSearchRecipeEvent extends RecipeEvent {
  final bool isSearchFriend;

  OnIsSearchRecipeEvent(this.isSearchFriend);
}

class OnNewStoryEvent extends RecipeEvent {}

class OnLikeOrUnLikeRecipe extends RecipeEvent {
  final String uidRecipe;
  final String type;
  

  OnLikeOrUnLikeRecipe(this.uidRecipe, this.type);
}

class OnAddNewCommentEvent extends RecipeEvent {
  final String uidRecipe;
  final String comment;

  OnAddNewCommentEvent(this.uidRecipe, this.comment);
}

class OnLikeOrUnlikeComment extends RecipeEvent {
  final String uidComment;

  OnLikeOrUnlikeComment(this.uidComment);
}
