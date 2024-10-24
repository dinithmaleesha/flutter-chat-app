part of 'user_bloc.dart';

@immutable
class UserState extends Equatable {
  final AppUser userData;
  final DataFetchStatus userDataFetchStatus;
  final DataFetchStatus userDataSetStatus;
  final UserAvailable userAvailable;
  final String splashText;
  final String currentAppVersion;

  UserState({
    required this.userData,
    required this.userDataFetchStatus,
    required this.userDataSetStatus,
    required this.userAvailable,
    required this.splashText,
    required this.currentAppVersion});

  factory UserState.initial() {
    return UserState(
      userData: AppUser.initial(),
      userDataFetchStatus:DataFetchStatus.initial,
      userDataSetStatus: DataFetchStatus.initial,
      userAvailable: UserAvailable.notAvailable,
      splashText: 'Launching...',
      currentAppVersion: '',
    );
  }

  UserState copyWith({
    AppUser? userData,
    DataFetchStatus? userDataFetchStatus,
    DataFetchStatus? userDataSetStatus,
    UserAvailable? userAvailable,
    String? splashText,
    String? currentAppVersion,
  }) {
    return UserState(
      userData: userData ?? this.userData,
      userDataFetchStatus: userDataFetchStatus ?? this.userDataFetchStatus,
      userDataSetStatus: userDataSetStatus ?? this.userDataSetStatus,
      userAvailable: userAvailable ?? this.userAvailable,
      splashText: splashText ?? this.splashText,
      currentAppVersion: currentAppVersion ?? this.currentAppVersion,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    userData,
    userDataFetchStatus,
    userDataSetStatus,
    userAvailable,
    splashText,
    currentAppVersion
  ];
}