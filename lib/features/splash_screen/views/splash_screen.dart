import 'package:chat_app/core/chat_user_bloc/chat_user_bloc.dart';
import 'package:chat_app/features/home_screen/views/home_screen.dart';
import 'package:chat_app/features/register_screen/views/user_register_screen.dart';
import 'package:chat_app/shared_components/util/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/core/user_bloc/user_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    context.read<UserBloc>().add(FetchUserData());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserBloc, UserState>(
          listener: (context, userState) {
            if (userState.userDataFetchStatus == DataFetchStatus.done) {
              if (userState.userAvailable == UserAvailable.notAvailable) {
                print('===== Open Register Page');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationPage()),
                );
              } else if (userState.userAvailable == UserAvailable.available) {
                context.read<ChatUserBloc>().add(
                    FetchChatUserData(deviceId: userState.userData.deviceId));
              }
            } else if (userState.userDataFetchStatus ==
                DataFetchStatus.corrupted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to fetch user data')),
              );
            }
          },
        ),
        BlocListener<ChatUserBloc, ChatUserState>(
            listener: (context, chatUserState) {
              if(chatUserState.dataFetchStatus == DataFetchStatus.done) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              }
        })
      ],
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
