part of 'user_bloc.dart';

@immutable
class UserState {

  final User? user;
  final RecipesUser? recipesUser;
  final bool isPhotos;


  const UserState({
    this.user,
    this.isPhotos = true,
    this.recipesUser
  });

  UserState copyWith({ User? user, bool? isPhotos, RecipesUser? recipesUser })
    => UserState(
      user: user ?? this.user,
      isPhotos: isPhotos ?? this.isPhotos,
      recipesUser: recipesUser ?? this.recipesUser
    );


}



class LoadingUserState extends UserState {}

class LoadingEditUserState extends UserState {}

class SuccessUserState extends UserState {}

class FailureUserState extends UserState {
  final String error;

  const FailureUserState(this.error);
}

class LoadingChangeAccount extends UserState {}

class LoadingFollowingUser extends UserState {}

class SuccessFollowingUser extends UserState {}

class LoadingFollowersUser extends UserState {}

class SuccessFollowersUser extends UserState {}