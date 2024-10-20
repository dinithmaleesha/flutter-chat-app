import 'package:chat_app/core/connectivity_bloc/connectivity_bloc.dart';
import 'package:chat_app/core/user_bloc/user_bloc.dart';
import 'package:chat_app/features/register_screen/views/custom_button.dart';
import 'package:chat_app/features/splash_screen/views/splash_screen.dart';
import 'package:chat_app/screen_distributor.dart';
import 'package:chat_app/services/device_service.dart';
import 'package:chat_app/shared_components/theme/color_pallet.dart';
import 'package:chat_app/shared_components/util/constants.dart';
import 'package:chat_app/shared_components/util/enums.dart';
import 'package:chat_app/shared_components/util/images.dart';
import 'package:chat_app/shared_components/widgets/custom_text_field.dart';
import 'package:chat_app/shared_components/widgets/footer_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _errorMessage;
  late String _fcmToken = '';
  late String _deviceId = '';
  bool hasInternet = true;

  @override
  void initState() {
    super.initState();
    _initializeFCMToken();
  }

  Future<void> _initializeFCMToken() async {
    try {
      _deviceId = await DeviceService().getDeviceId() ?? '';
      _fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
      if (_deviceId.isEmpty || _fcmToken.isEmpty) {
        print('Error retrieving device information. Please try again.');
        setState(() {
          _errorMessage = 'Please try again.';
        });
      }
    } catch (e) {
      print('Error initializing FCM Token. Please try again.');
      setState(() {
        _errorMessage = 'Please try again.';
      });
    }
  }

  void _register() {
    if (!hasInternet) {
      setState(() {
        _errorMessage = 'No internet connection. Please try again.';
      });
      return;
    }
    final name = _nameController.text;

    if (name.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter your name.';
      });
    } else if (name.length < 3) {
      setState(() {
        _errorMessage = 'Name must be at least 3 characters long.';
      });
    } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(name)) {
      setState(() {
        _errorMessage = 'Name can only contain letters and spaces.';
      });
    } else if (_fcmToken.isEmpty || _deviceId.isEmpty) {
      print('Device information is missing. Please try again.');
      setState(() {
        _errorMessage = 'Please try again.';
      });
    } else {
      setState(() {
        _errorMessage = null;
      });
      context.read<UserBloc>().add(
          SetUserData(name: name, deviceId: _deviceId, fcmToken: _fcmToken));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageBase(
      child: MultiBlocListener(
        listeners: [
          BlocListener<UserBloc, UserState>(
            listener: (context, userState) {
              if (userState.userDataSetStatus == DataFetchStatus.done) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SplashScreen()),
                );
              }
            },
          ),
          BlocListener<ConnectivityBloc, ConnectivityState>(
            listener: (context, connectivityState) {
              setState(() {
                hasInternet = connectivityState.hasInternet;
              });
              if (!connectivityState.hasInternet) {
                setState(() {
                  _errorMessage = 'No internet connection.';
                });
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: ColorPallet.backgroundColor,
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      ImageAssets.registerBackground,
                      fit: BoxFit.cover,
                      opacity: const AlwaysStoppedAnimation(.1),
                    ),
                  ],
                ),
              ),
              Container(
                height: 320.h,
                decoration: BoxDecoration(
                  color: ColorPallet.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              Constants.welcome,
                              style: TextStyle(
                                fontSize: 24,
                                color: ColorPallet.blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              Constants.welcomeSubtitle,
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorPallet.grayColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 5.h),
                            const Divider(height: 9),
                            SizedBox(height: 30.h),
                            CustomTextField(
                              controller: _nameController,
                              errorText: _errorMessage,
                            ),
                            SizedBox(height: 20.h),
                            CustomButton(
                              text: Constants.buttonText,
                              onPressed: _register,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    FooterText(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
