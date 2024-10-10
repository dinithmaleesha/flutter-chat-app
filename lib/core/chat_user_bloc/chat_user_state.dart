part of 'chat_user_bloc.dart';

@immutable
class ChatUserState extends Equatable {
  final List<AppUser> appUsers;
  final DataFetchStatus dataFetchStatus;

  ChatUserState({
    required this.appUsers,
    required this.dataFetchStatus,
  });

  factory ChatUserState.initial() {
    return ChatUserState(
        appUsers: [],
        dataFetchStatus: DataFetchStatus.initial
    );
  }

  ChatUserState copyWith({
    List<AppUser>? appUsers,
    DataFetchStatus? dataFetchStatus,
   }) {
    return ChatUserState(
        appUsers: appUsers ?? this.appUsers,
        dataFetchStatus: dataFetchStatus ?? this.dataFetchStatus
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    appUsers,
    dataFetchStatus
  ];
}

