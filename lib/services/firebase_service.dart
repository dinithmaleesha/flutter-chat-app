import 'dart:async';
import 'package:chat_app/services/device_service.dart';
import 'package:chat_app/shared_components/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../shared_components/models/app_info_status.dart';

class FirebaseService {
  static final FirebaseService instance = FirebaseService._internal();

  factory FirebaseService() => instance;

  FirebaseService._internal();

  final FirebaseFirestore firestoreDB = FirebaseFirestore.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  DeviceService deviceService = DeviceService();

  Stream<AppInfoStatus?> getAppInfoDataStream() {
    return firestoreDB.collection('app_config').doc('app_config').snapshots().map((snapshot) {
      if (snapshot.exists) {
        print('Document found');
        return AppInfoStatus.fromJson({
          'documentId': snapshot.id,
          ...snapshot.data()!,
        });
      } else {
        print('No document found');
        return null;
      }
    }).handleError((error) {
      print('Failed to listen to app info data: $error');
      throw Exception('Failed to listen to app info data: $error');
    });
  }

  Future<AppUser?> fetchUserByDeviceId() async {
    print('========fetchUserByDeviceId()');
    try {
      String deviceId = await deviceService.getDeviceId();

      final DocumentSnapshot userDoc = await firestoreDB
          .collection('users')
          .doc(deviceId)
          .get();

      if (userDoc.exists) {
        return AppUser.fromJson(userDoc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching user by device ID: $e');
      return null;
    }
  }

  Future<bool> setUserData({
    required String deviceId,
    required String name,
    String? fcmToken,
  }) async {
    try {
      final Map<String, dynamic> userData = {
        'deviceId': deviceId,
        'name': name,
        'fcmToken': fcmToken ?? await _firebaseMessaging.getToken(),
      };

      await firestoreDB.collection('users').doc(deviceId).set(userData);

      return true;
    } catch (e) {
      print('Error setting user data: $e');
      return false;
    }
  }

  Future<List<AppUser>> fetchAllUsers() async {
    try {
      final QuerySnapshot usersSnapshot = await firestoreDB.collection('users').get();

      final List<AppUser> users = usersSnapshot.docs
          .map((doc) => AppUser.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return users;
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }

  Future<List<AppUser>> fetchChatUsers(String currentDeviceId) async {
    print("===== Fetching Chat user Data, Device ID: ${currentDeviceId}");
    try {
      final QuerySnapshot usersSnapshot = await firestoreDB.collection('users').get();

      final List<AppUser> users = usersSnapshot.docs
          .map((doc) => AppUser.fromJson(doc.data() as Map<String, dynamic>))
          .where((user) => user.deviceId != currentDeviceId)
          .toList();

      return users;
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }
}
