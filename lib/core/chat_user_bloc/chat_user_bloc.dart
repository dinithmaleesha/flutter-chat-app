import 'package:bloc/bloc.dart';
import 'package:chat_app/services/firebase_service.dart';
import 'package:chat_app/shared_components/models/app_user.dart';
import 'package:chat_app/shared_components/util/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'chat_user_event.dart';
part 'chat_user_state.dart';

class ChatUserBloc extends Bloc<ChatUserEvent, ChatUserState> {
  final FirebaseService _firebaseService;
  ChatUserBloc(this._firebaseService) : super(ChatUserState.initial()) {
    on<FetchChatUserData>(_onFetchChatUserData);
  }

  Future<void> _onFetchChatUserData(FetchChatUserData event, emit) async {
    try {
      emit(state.copyWith(dataFetchStatus: DataFetchStatus.started));

      final List<AppUser> users = await _firebaseService.fetchChatUsers(event.deviceId);
      if(users != null) {
        print('User List Found');
        emit(state.copyWith(appUsers: users, dataFetchStatus: DataFetchStatus.done));
      } else {
        print('User List not Found');
        emit(state.copyWith(appUsers: [], dataFetchStatus: DataFetchStatus.done));
      }
    } catch (e) {
      print("An error occur while fetching user data: ${e}");
      emit(state.copyWith(dataFetchStatus: DataFetchStatus.corrupted));
    }
  }
}
