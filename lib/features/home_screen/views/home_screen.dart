import 'package:chat_app/core/chat_user_bloc/chat_user_bloc.dart';
import 'package:chat_app/core/user_bloc/user_bloc.dart';
import 'package:chat_app/features/home_screen/widgets/chat_user_card.dart';
import 'package:chat_app/shared_components/util/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          if (userState.userDataFetchStatus == DataFetchStatus.done &&
              userState.userAvailable == UserAvailable.available) {
            final currentUser = userState.userData;

            return BlocBuilder<ChatUserBloc, ChatUserState>(
              builder: (context, chatUserState) {
                if (chatUserState.dataFetchStatus != DataFetchStatus.done) {
                  return Center(child: CircularProgressIndicator());
                } else if (chatUserState.dataFetchStatus == DataFetchStatus.done) {
                  final users = chatUserState.appUsers;

                  if (users.isEmpty) {
                    return Center(child: Text('No registered users available'));
                  }

                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];


                      // if (user.deviceId == currentUser.deviceId) {
                      //   return SizedBox.shrink(); // Skip the current user
                      // }

                      return ChatUserCard(
                        name: user.name,
                        deviceId: user.deviceId,
                        currentUserId: currentUser.deviceId,
                      );
                    },
                  );
                } else if (chatUserState.dataFetchStatus == DataFetchStatus.corrupted) {
                  return Center(child: Text('Failed to load users'));
                } else {
                  return Center(child: Text('No data available'));
                }
              },
            );
          } else if (userState.userDataFetchStatus == DataFetchStatus.corrupted) {
            return Center(child: Text('Failed to load user data'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
