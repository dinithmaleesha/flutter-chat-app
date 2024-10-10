import 'package:bloc/bloc.dart';
import 'package:chat_app/services/firebase_service.dart';
import 'package:chat_app/shared_components/models/app_user.dart';
import 'package:chat_app/shared_components/util/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FirebaseService _firebaseService;

  UserBloc(this._firebaseService) : super(UserState.initial()) {
    on<FetchUserData>(_onFetchUserData);
    on<SetUserData>(_onSetUserData);
  }
  Future<void> _onFetchUserData(
      FetchUserData event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(userDataFetchStatus: DataFetchStatus.started));

      final AppUser? user = await _firebaseService.fetchUserByDeviceId();

      if (user != null) {
        print("User Found...");
        emit(state.copyWith(
          userData: user,
          userDataFetchStatus: DataFetchStatus.done,
            userAvailable: UserAvailable.available
        ));
      } else {
        print("User Not Found...");
        emit(state.copyWith(
          userDataFetchStatus: DataFetchStatus.done,
          userAvailable: UserAvailable.notAvailable
        ));
      }
    } catch (e) {
      print("An error occur while fetching user data: ${e}");
      emit(state.copyWith(userDataFetchStatus: DataFetchStatus.corrupted));
    }
  }

  Future<void> _onSetUserData(
      SetUserData event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(userDataSetStatus: DataFetchStatus.started));

      final bool isSuccess = await _firebaseService.setUserData(
        deviceId: event.deviceId,
        name: event.name,
        fcmToken: event.fcmToken,
      );

      if (isSuccess) {
        print('User Registered');
        emit(state.copyWith(userDataSetStatus: DataFetchStatus.done));
      } else {
        print('User NOT Registered');
        emit(state.copyWith(userDataSetStatus: DataFetchStatus.corrupted));
      }
    } catch (e) {
      print('User NOT Registered');
      emit(state.copyWith(userDataSetStatus: DataFetchStatus.corrupted));
    }
  }
}