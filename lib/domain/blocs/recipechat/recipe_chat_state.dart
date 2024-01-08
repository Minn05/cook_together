part of 'recipe_chat_bloc.dart';

@immutable
abstract class ChatRecipeState {
  final bool isWritting;

  final String? uidSource;
  final String? uidTarget;
  final String? message;

  const ChatRecipeState(
      {this.isWritting = false, this.uidSource, this.uidTarget, this.message});
}

class ChatRecipeInitial extends ChatRecipeState {
  const ChatRecipeInitial() : super(isWritting: false);
}

class ChatSetIsWrittingRecipeState extends ChatRecipeState {
  final bool writting;
  const ChatSetIsWrittingRecipeState({required this.writting})
      : super(isWritting: writting);
}

class ChatListengMessageRecipeState extends ChatRecipeState {
  final String uidFrom;
  final String uidTo;
  final String messages;

  const ChatListengMessageRecipeState(
      {required this.uidFrom, required this.uidTo, required this.messages})
      : super(uidSource: uidFrom, uidTarget: uidTo, message: messages);
}