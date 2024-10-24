class AppInfoStatus {
  final bool updateAvailable;
  final bool isMaintaining;
  final String appVersion;

  AppInfoStatus({
    required this.updateAvailable,
    required this.isMaintaining,
    required this.appVersion,
  });

  factory AppInfoStatus.initial() {
    return AppInfoStatus(
      updateAvailable: false,
      isMaintaining: false,
      appVersion: '1.0.0',
    );
  }

  AppInfoStatus copyWith({
    bool? updateAvailable,
    bool? isMaintaining,
    String? appVersion,
  }) {
    return AppInfoStatus(
      updateAvailable: updateAvailable ?? this.updateAvailable,
      isMaintaining: isMaintaining ?? this.isMaintaining,
      appVersion: appVersion ?? this.appVersion,
    );
  }

  factory AppInfoStatus.fromJson(Map<String, dynamic> json) {
    return AppInfoStatus(
      updateAvailable: json['update_status'] as bool,
      isMaintaining: json['is_maintaining'] as bool,
      appVersion: json['app_version'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'update_available': updateAvailable,
      'is_maintaining' : isMaintaining,
      'app_version' : appVersion,
    };
  }
}
