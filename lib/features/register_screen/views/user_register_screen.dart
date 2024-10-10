import 'package:chat_app/features/splash_screen/views/splash_screen.dart';
import 'package:chat_app/screen_distributor.dart';
import 'package:chat_app/services/device_service.dart';
import 'package:chat_app/shared_components/util/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/core/user_bloc/user_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  DeviceService deviceService = DeviceService();
  final TextEditingController _nameController = TextEditingController();
  late String _fcmToken;
  late String _deviceId;

  @override
  void initState() {
    super.initState();
    _initializeFCMToken();
  }

  Future<void> _initializeFCMToken() async {
    _deviceId = await deviceService.getDeviceId() ?? '';
    _fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
    print("Device ID in Register page: $_deviceId");
    print("FCM in Register page: $_fcmToken");
  }

  void _register() {
    final name = _nameController.text;
    if (name.isNotEmpty && _fcmToken != '' && _deviceId != ''
        && _fcmToken.isNotEmpty && _deviceId.isNotEmpty) {
      context.read<UserBloc>().add(
          SetUserData(name: name, deviceId: _deviceId, fcmToken: _fcmToken)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageBase(
      child: BlocListener<UserBloc, UserState>(
        listener: (context, userState) {
          if (userState.userDataSetStatus == DataFetchStatus.done) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SplashScreen()),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Register'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Enter your name'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _register,
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
