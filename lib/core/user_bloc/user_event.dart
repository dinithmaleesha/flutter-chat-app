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
class UpdateOnlineStatus extends UserEvent {
  final bool isOnline;
  UpdateOnlineStatus({
    required this.isOnline,
});
}

class ChangeSplashText extends UserEvent {
  final String splashText;
  ChangeSplashText({required this.splashText});
}

class SetCurrentAppVersion extends UserEvent {
  SetCurrentAppVersion();
}
