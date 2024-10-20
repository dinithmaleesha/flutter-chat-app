import 'package:chat_app/core/chat_user_bloc/chat_user_bloc.dart';
import 'package:chat_app/core/connectivity_bloc/connectivity_bloc.dart';
import 'package:chat_app/core/user_bloc/user_bloc.dart';
import 'package:chat_app/features/splash_screen/views/splash_screen.dart';
import 'package:chat_app/screen_distributor.dart';
import 'package:chat_app/services/device_service.dart';
import 'package:chat_app/services/firebase_service.dart';
import 'package:chat_app/core/app_status_bloc/app_status_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    runApp(MyApp());
  } catch (e) {
    runApp(ErrorApp(e.toString()));
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final FirebaseService _firebaseService = FirebaseService();
  final DeviceService _deviceService = DeviceService();
  String version = '';
  final ConnectivityBloc connectivityBloc = ConnectivityBloc();

  late String deviceId;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeDevice();
  }

  @override
  void dispose() {
    _firebaseService.updateUserStatus(deviceId: deviceId, isOnline: false);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  Future<void> _initializeDevice() async {
    deviceId = await _deviceService.getDeviceId();
    _firebaseService.updateUserStatus(deviceId: deviceId, isOnline: true);
    connectivityBloc.add(ListenToConnectivityStatus());
    connectivityBloc.add(CheckInternetConnectivity());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      print('App is in the background - isOnline: false');
      _firebaseService.updateUserStatus(deviceId: deviceId, isOnline: false);
    } else if (state == AppLifecycleState.resumed) {
      print('App is resumed - isOnline: true');
      _firebaseService.updateUserStatus(deviceId: deviceId, isOnline: true);
    } else if (state == AppLifecycleState.detached) {
      print('App is being detached - isOnline: false');
      _firebaseService.updateUserStatus(deviceId: deviceId, isOnline: false);
    }
  }


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityBloc>(
          create: (context) => ConnectivityBloc(),
        ),
        BlocProvider<AppStatusBloc>(
          create: (context) => AppStatusBloc(FirebaseService.instance),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(FirebaseService.instance),
        ),
        BlocProvider<ChatUserBloc>(
          create: (context) => ChatUserBloc(FirebaseService.instance),
        )
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            home: Scaffold(
              body: SafeArea(
                child: PageBase(
                  child: SplashScreen(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ErrorApp extends StatelessWidget {
  final String errorMessage;

  const ErrorApp(this.errorMessage);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            'Failed to initialize Firebase: $errorMessage',
            style: TextStyle(
              fontSize: 18,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
