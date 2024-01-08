part of 'recipe_chat_bloc.dart';

@immutable
abstract class ChatRecipeEvent {}

class OnIsWrittingRecipeEvent extends ChatRecipeEvent {
  final bool isWritting;

  OnIsWrittingRecipeEvent(this.isWritting);
}

class OnEmitMessageRecipeEvent extends ChatRecipeEvent {
  final String userId;
  final String recipeId;
  final String message;

  OnEmitMessageRecipeEvent(this.userId, this.recipeId, this.message);
}

class OnListenMessageRecipeEvent extends ChatRecipeEvent {
  final String userId;
  final String recipeId;
  final String messages;

  OnListenMessageRecipeEvent(this.userId, this.recipeId, this.messages);
}