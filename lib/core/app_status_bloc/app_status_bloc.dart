import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/services/firebase_service.dart';
import 'package:chat_app/shared_components/models/app_info_status.dart';
import 'package:chat_app/shared_components/util/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'app_status_event.dart';
part 'app_status_state.dart';

class AppStatusBloc extends Bloc<AppStatusEvent, AppStatusState> {
  AppStatusBloc(this.firebaseService) : super(AppStatusState.initial()) {
    on<ListenAppInfoData>(_onListenAppInfoData);
    on<UpdateAppInfoData>(_onUpdateAppInfoData);
    add(ListenAppInfoData());
  }
  final FirebaseService firebaseService;
  StreamSubscription<AppInfoStatus?>? _appInfoSubscription;

  Future<void> _onListenAppInfoData(
      ListenAppInfoData event,
      emit,
      ) async {
    // Start listening to the stream
    _appInfoSubscription = firebaseService.getAppInfoDataStream().listen(
          (appInfoStatus) {
        if(appInfoStatus!=null){
          add(UpdateAppInfoData(appInfoStatus));
        }
      },
      onError: (error) {
        print('AppInfoStatus data stream has error');
      },
    );
  }

  Future<void> _onUpdateAppInfoData(
      UpdateAppInfoData event,
      emit,
      ) async {
    print('App Update: ${event.appInfoStatus.updateAvailable}');
    print('App Maintaining: ${event.appInfoStatus.isMaintaining}');
    emit(state.copyWith(appInfoStatus: event.appInfoStatus));
  }
}
