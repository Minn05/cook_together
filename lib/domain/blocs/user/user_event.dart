// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class OnGetUserAuthenticationEvent extends UserEvent {}

class OnRegisterUserEvent extends UserEvent {
  final String fullname;
  final String username;
  final String email;
  final String password;
  final String birthday;
  final String height;
  final String weight;
  // final String uidPerson;
  // final String uidUser;
  // final String temp;

  OnRegisterUserEvent(
    this.fullname,
    this.username,
    this.email,
    this.password,
    this.birthday,
    this.height,
    this.weight,
    // this.uidPerson,
    // this.uidUser,
    // this.temp,
  );
}

class OnVerifyEmailEvent extends UserEvent {
  final String email;
  final String code;

  OnVerifyEmailEvent(this.email, this.code);
}

class OnUpdatePictureCover extends UserEvent {
  final String pathCover;

  OnUpdatePictureCover(this.pathCover);
}

class OnUpdatePictureProfile extends UserEvent {
  final String pathProfile;

  OnUpdatePictureProfile(this.pathProfile);
}

class OnUpdateProfileEvent extends UserEvent {
  final String user;
  final String fullname;
  final String height;
  final String weight;

  OnUpdateProfileEvent(this.user, this.fullname, this.height, this.weight);
}

class OnChangePasswordEvent extends UserEvent {
  final String currentPassword;
  final String newPassword;

  OnChangePasswordEvent(this.currentPassword, this.newPassword);
}

class OnToggleButtonProfile extends UserEvent {
  final bool isPhotos;

  OnToggleButtonProfile(this.isPhotos);
}

class OnChangeAccountToPrivacy extends UserEvent {}

class OnLogOutUser extends UserEvent {}

class OnAddNewFollowingEvent extends UserEvent {
  final String uidFriend;

  OnAddNewFollowingEvent(this.uidFriend);
}

class OnAcceptFollowerRequestEvent extends UserEvent {
  final String uidFriend;
  final String uidNotification;

  OnAcceptFollowerRequestEvent(this.uidFriend, this.uidNotification);
}

class OnDeletefollowingEvent extends UserEvent {
  final String uidUser;

  OnDeletefollowingEvent(this.uidUser);
}

class OnDeletefollowersEvent extends UserEvent {
  final String uidUser;

  OnDeletefollowersEvent(this.uidUser);
}
