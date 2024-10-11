import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';

class DeviceService {
  Future<String> getDeviceId() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    String deviceId = '';

    try {
      if (Platform.isAndroid) {
        final AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        deviceId = androidInfo.id;
      } else if (Platform.isIOS) {
        final IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        deviceId = iosInfo.name;
      }
    } catch (e) {
      print('Error getting device ID: $e');
    }

    return deviceId;
  }

  Future<String> getAppVersion() async {
    print('run getAppVersion');
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}