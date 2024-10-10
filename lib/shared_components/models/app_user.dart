class AppUser {
  final String deviceId;
  final String fcmToken;
  final String name;

  AppUser({required this.deviceId, required this.fcmToken, required this.name});

  factory AppUser.initial() {
    return AppUser(deviceId: '', fcmToken: '', name: '');
  }

  AppUser copyWith({
    String? deviceId,
    String? fcmToken,
    String? name,
  }) {
    return AppUser(
        deviceId: deviceId ?? this.deviceId,
        fcmToken: fcmToken ?? this.fcmToken,
        name: name ?? this.name,
    );
  }

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
        deviceId: json['deviceId'],
        fcmToken: json['fcmToken'],
        name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'fcmToken': fcmToken,
      'name': name
    };
  }
}