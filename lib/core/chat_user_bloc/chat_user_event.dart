part of 'chat_user_bloc.dart';

@immutable
abstract class ChatUserEvent {}

class FetchChatUserData extends ChatUserEvent {
  final String deviceId;
  FetchChatUserData({required this.deviceId});
}
