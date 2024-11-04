import 'package:chat_app/core/chat_user_bloc/chat_user_bloc.dart';
import 'package:chat_app/core/connectivity_bloc/connectivity_bloc.dart';
import 'package:chat_app/core/user_bloc/user_bloc.dart';
import 'package:chat_app/features/home_screen/widgets/app_bar.dart';
import 'package:chat_app/features/home_screen/widgets/chat_user_card.dart';
import 'package:chat_app/features/home_screen/widgets/error_display.dart';
import 'package:chat_app/screen_distributor.dart';
import 'package:chat_app/shared_components/theme/color_pallet.dart';
import 'package:chat_app/shared_components/util/constants.dart';
import 'package:chat_app/shared_components/util/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageBase(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPallet.mainColor,
          title: Center(
            child: CustomAppBar(title: Constants.appName),
          ),
        ),
        backgroundColor: ColorPallet.backgroundColor,
        body: BlocBuilder<ConnectivityBloc, ConnectivityState>(
          builder: (context, connectivityState) {
            return BlocBuilder<UserBloc, UserState>(
              builder: (context, userState) {
                if (connectivityState.initialized &&
                    !connectivityState.hasInternet) {
                  return Center(
                    child: ErrorDisplay(
                      message: Constants.noInternet,
                      icon: Icons.wifi_off_rounded,
                    ),
                  );
                }

                if (userState.userDataFetchStatus == DataFetchStatus.done &&
                    userState.userAvailable == UserAvailable.available &&
                    connectivityState.hasInternet) {
                  final currentUser = userState.userData;

                  return BlocBuilder<ChatUserBloc, ChatUserState>(
                    builder: (context, chatUserState) {
                      if (chatUserState.dataFetchStatus !=
                          DataFetchStatus.done) {
                        return Center(
                          child: ErrorDisplay(
                            message: Constants.noUserAvailable,
                            icon: Icons.person_off,
                          ),
                        );
                      } else if (chatUserState.dataFetchStatus ==
                          DataFetchStatus.done) {
                        final users = chatUserState.appUsers;
                        if (users.isEmpty) {
                          return Center(
                            child: ErrorDisplay(
                              message: Constants.firstUser,
                              icon: Icons.emoji_events,
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            return ChatUserCard(
                              name: user.name,
                              deviceId: user.deviceId,
                              currentUserId: currentUser.deviceId,
                              isOnline: user.isOnline,
                            );
                          },
                        );
                      } else if (chatUserState.dataFetchStatus ==
                          DataFetchStatus.corrupted) {
                        return Center(
                          child: ErrorDisplay(
                            message: Constants.failedToLoadFriend,
                            icon: Icons.group_off,
                          ),
                        );
                      } else {
                        return Center(
                          child: ErrorDisplay(
                            message: Constants.noFriendFound,
                            icon: Icons.person_search,
                          ),
                        );
                      }
                    },
                  );
                } else if (userState.userDataFetchStatus ==
                    DataFetchStatus.corrupted) {
                  return Center(
                    child: ErrorDisplay(
                      message: Constants.failedToLoadData,
                      icon: Icons.cloud_off,
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            );
          },
        ),
      ),
    );
  }
}
