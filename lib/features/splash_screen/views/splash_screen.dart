import 'package:chat_app/core/chat_user_bloc/chat_user_bloc.dart';
import 'package:chat_app/core/connectivity_bloc/connectivity_bloc.dart';
import 'package:chat_app/features/home_screen/views/home_screen.dart';
import 'package:chat_app/features/register_screen/views/custom_button.dart';
import 'package:chat_app/features/register_screen/views/user_register_screen.dart';
import 'package:chat_app/services/device_service.dart';
import 'package:chat_app/shared_components/theme/color_pallet.dart';
import 'package:chat_app/shared_components/util/constants.dart';
import 'package:chat_app/shared_components/util/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/core/user_bloc/user_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PackageInfo? packageInfo;
  DeviceService deviceService = DeviceService();
  String appVersion = '';

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ConnectivityBloc, ConnectivityState>(
          listener: (context, connectivityState) {
            if (connectivityState.hasInternet) {
              context.read<UserBloc>().add(FetchUserData());
            } else {
              context.read<UserBloc>().add(
                  ChangeSplashText(splashText: 'No internet...'));
            }
          },
        ),
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
                  FetchChatUserData(deviceId: userState.userData.deviceId),
                );
                context.read<ChatUserBloc>().add(
                  ListenToUserStatus(userState.userData.deviceId),
                );
              }
            } else
            if (userState.userDataFetchStatus == DataFetchStatus.corrupted) {
              context.read<UserBloc>().add(
                  ChangeSplashText(splashText: 'Failed to fetch user data'));
            }
          },
        ),
        BlocListener<ChatUserBloc, ChatUserState>(
          listener: (context, chatUserState) {
            if (chatUserState.dataFetchStatus == DataFetchStatus.done) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ColorPallet.mainColor, ColorPallet.secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, userState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        Constants.appName,
                        style: TextStyle(
                          fontSize: 28,
                          color: ColorPallet.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        userState.splashText,
                        style: TextStyle(
                            fontSize: 16,
                            color: ColorPallet.white,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        appVersion,
                        style: TextStyle(
                            fontSize: 12,
                            color: ColorPallet.grayColor,
                        ),
                      ),
                      SizedBox(height: 5.h),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}