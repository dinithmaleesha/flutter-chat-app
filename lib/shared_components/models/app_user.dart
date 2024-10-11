class AppUser {
  final String deviceId;
  final String fcmToken;
  final String name;
  final bool isOnline;

  AppUser(
      {required this.deviceId,
      required this.fcmToken,
      required this.name,
      required this.isOnline});

  factory AppUser.initial() {
    return AppUser(deviceId: '', fcmToken: '', name: '', isOnline: false);
  }

  AppUser copyWith({
    String? deviceId,
    String? fcmToken,
    String? name,
    bool? isOnline,
  }) {
    return AppUser(
      deviceId: deviceId ?? this.deviceId,
      fcmToken: fcmToken ?? this.fcmToken,
      name: name ?? this.name,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      deviceId: json['deviceId'],
      fcmToken: json['fcmToken'],
      name: json['name'],
      isOnline: json['isOnline']
    );
  }

  Map<String, dynamic> toJson() {
    return {'deviceId': deviceId, 'fcmToken': fcmToken, 'name': name, 'isOnline': isOnline};
  }
}
