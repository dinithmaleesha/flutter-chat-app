import 'package:chat_app/core/chat_user_bloc/chat_user_bloc.dart';
import 'package:chat_app/core/user_bloc/user_bloc.dart';
import 'package:chat_app/features/home_screen/widgets/app_bar.dart';
import 'package:chat_app/features/home_screen/widgets/chat_user_card.dart';
import 'package:chat_app/features/home_screen/widgets/no_user_available.dart';
import 'package:chat_app/screen_distributor.dart';
import 'package:chat_app/shared_components/theme/color_pallet.dart';
import 'package:chat_app/shared_components/util/constants.dart';
import 'package:chat_app/shared_components/util/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
            )),
        backgroundColor: ColorPallet.backgroundColor,
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, userState) {
            if (userState.userDataFetchStatus == DataFetchStatus.done &&
                userState.userAvailable == UserAvailable.available) {
              final currentUser = userState.userData;

              return BlocBuilder<ChatUserBloc, ChatUserState>(
                builder: (context, chatUserState) {
                  if (chatUserState.dataFetchStatus != DataFetchStatus.done) {
                    return Center(child: NoUserAvailable());
                  } else if (chatUserState.dataFetchStatus ==
                      DataFetchStatus.done) {
                    final users = chatUserState.appUsers;
                    // final users = usersList;
                    if (users.isEmpty) {
                      return Center(
                          child: NoUserAvailable(
                        text: "You're the first user",
                        icon: Icons.emoji_events,
                      ));
                    }
                    return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];

                        return ChatUserCard(
                          name: user.name,
                          deviceId: user.deviceId,
                          currentUserId: currentUser.deviceId,
                        );
                      },
                    );
                  } else if (chatUserState.dataFetchStatus ==
                      DataFetchStatus.corrupted) {
                    return Center(
                        child: NoUserAvailable(
                      text: 'Failed to load friends',
                    ));
                  } else {
                    return Center(
                        child: NoUserAvailable(
                      text: 'No friends found',
                    ));
                  }
                },
              );
            } else if (userState.userDataFetchStatus ==
                DataFetchStatus.corrupted) {
              return Center(
                  child: NoUserAvailable(
                text: 'Failed to load friends data',
              ));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  List<User> usersList = [
    User(name: 'Alice', deviceId: 'device123', currentUserId: 'currentUser1'),
    User(name: 'Bob', deviceId: 'device456', currentUserId: 'currentUser2'),
    User(name: 'Charlie', deviceId: 'device789', currentUserId: 'currentUser3'),
    User(name: 'Charlie', deviceId: 'device789', currentUserId: 'currentUser3'),
    User(name: 'Charlie', deviceId: 'device789', currentUserId: 'currentUser3'),
    User(name: 'Charlie', deviceId: 'device789', currentUserId: 'currentUser3'),
    User(name: 'Charlie', deviceId: 'device789', currentUserId: 'currentUser3'),
    User(name: 'Charlie', deviceId: 'device789', currentUserId: 'currentUser3'),
    User(name: 'Charlie', deviceId: 'device789', currentUserId: 'currentUser3'),
    User(name: 'Charlie', deviceId: 'device789', currentUserId: 'currentUser3'),
    User(name: 'Charlie', deviceId: 'device789', currentUserId: 'currentUser3'),
    User(name: 'Charlie', deviceId: 'device789', currentUserId: 'currentUser3'),
    User(name: 'Charlie', deviceId: 'device789', currentUserId: 'currentUser3'),
    User(name: 'Charlie', deviceId: 'device789', currentUserId: 'currentUser3'),
  ];
}

class User {
  final String name;
  final String deviceId;
  final String currentUserId;

  User(
      {required this.name,
      required this.deviceId,
      required this.currentUserId});
}
