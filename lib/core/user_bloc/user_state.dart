part of 'user_bloc.dart';

@immutable
class UserState extends Equatable {
  final AppUser userData;
  final DataFetchStatus userDataFetchStatus;
  final DataFetchStatus userDataSetStatus;
  final UserAvailable userAvailable;
  final String splashText;

  UserState({
    required this.userData,
    required this.userDataFetchStatus,
    required this.userDataSetStatus,
    required this.userAvailable,
    required this.splashText});

  factory UserState.initial() {
    return UserState(
      userData: AppUser.initial(),
      userDataFetchStatus:DataFetchStatus.initial,
      userDataSetStatus: DataFetchStatus.initial,
      userAvailable: UserAvailable.notAvailable,
      splashText: 'Launching...',
    );
  }

  UserState copyWith({
    AppUser? userData,
    DataFetchStatus? userDataFetchStatus,
    DataFetchStatus? userDataSetStatus,
    UserAvailable? userAvailable,
    String? splashText,
  }) {
    return UserState(
      userData: userData ?? this.userData,
      userDataFetchStatus: userDataFetchStatus ?? this.userDataFetchStatus,
      userDataSetStatus: userDataSetStatus ?? this.userDataSetStatus,
      userAvailable: userAvailable ?? this.userAvailable,
      splashText: splashText ?? this.splashText,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    userData,
    userDataFetchStatus,
    userDataSetStatus,
    userAvailable,
    splashText
  ];
}