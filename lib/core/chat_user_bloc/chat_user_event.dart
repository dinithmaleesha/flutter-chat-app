part of 'chat_user_bloc.dart';

@immutable
abstract class ChatUserEvent {}

class FetchChatUserData extends ChatUserEvent {
  final String deviceId;

  FetchChatUserData({required this.deviceId});
}

class ListenIsOnline extends ChatUserEvent {
  final String deviceId;

  ListenIsOnline(this.deviceId);
}

class ListenToUserStatus extends ChatUserEvent {
  final String deviceId;
  ListenToUserStatus(this.deviceId);
}

class UpdateChatUser extends ChatUserEvent {
  final List<AppUser> appUser;
  UpdateChatUser({required this.appUser});
}
