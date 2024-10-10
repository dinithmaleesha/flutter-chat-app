part of 'app_status_bloc.dart';

@immutable
abstract  class AppStatusEvent {}

class ListenAppInfoData extends AppStatusEvent {
  ListenAppInfoData();
}

class UpdateAppInfoData extends AppStatusEvent {
  final AppInfoStatus appInfoStatus;
  UpdateAppInfoData(this.appInfoStatus);
}