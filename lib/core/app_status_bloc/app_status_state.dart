part of 'app_status_bloc.dart';

class AppStatusState extends Equatable {
  final AppInfoStatus appInfoStatus;
  final DataFetchStatus dataFetchStatus;

  AppStatusState({required this.appInfoStatus, required this.dataFetchStatus});

  factory AppStatusState.initial() {
    return AppStatusState(
      appInfoStatus: AppInfoStatus.initial(),
      dataFetchStatus: DataFetchStatus.initial,
    );
  }

  AppStatusState copyWith({
    AppInfoStatus? appInfoStatus,
    DataFetchStatus? dataFetchStatus,
  }) {
    return AppStatusState(
      appInfoStatus: appInfoStatus ?? this.appInfoStatus,
      dataFetchStatus:  dataFetchStatus ?? this.dataFetchStatus,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    appInfoStatus,
    dataFetchStatus,
  ];
}
