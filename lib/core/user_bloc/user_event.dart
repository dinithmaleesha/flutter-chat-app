part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class FetchUserData extends UserEvent {
  FetchUserData();
}
class SetUserData extends UserEvent {
  final String fcmToken;
  final String deviceId;
  final String name;
  SetUserData({
    required this.name,
    required this.deviceId,
    required this.fcmToken
  });
}

class SetErrorMsg extends UserEvent {
  final String error;
  SetErrorMsg({required this.error});
}
