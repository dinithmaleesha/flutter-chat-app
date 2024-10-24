import 'package:chat_app/core/app_status_bloc/app_status_bloc.dart';
import 'package:chat_app/core/user_bloc/user_bloc.dart';
import 'package:chat_app/features/splash_screen/views/splash_screen.dart';
import 'package:chat_app/shared_components/util/constants.dart';
import 'package:chat_app/shared_components/widgets/under_maintenance_screen.dart';
import 'package:chat_app/shared_components/widgets/update_available_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageBase extends StatelessWidget {
  final Widget child;

  const PageBase({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        return BlocBuilder<AppStatusBloc, AppStatusState>(
          builder: (context, appStatus) {
            if (appStatus.appInfoStatus.updateAvailable &&
                !appStatus.appInfoStatus.isMaintaining) {
              return UpdateAvailableScreen();
            } else if (appStatus.appInfoStatus.isMaintaining) {
              return UnderMaintenanceScreen();
            } else if (appStatus.appInfoStatus.appVersion != userState.currentAppVersion) {
              return UpdateAvailableScreen(
                updateMessage: Constants.newUpdate,
                updateSubtitle: Constants.newUpdateSubtitle,
              );
            } else {
              return child;
            }
          },
        );
      },
    );
  }
}
