class AppInfoStatus {
  final bool updateAvailable;
  final bool isMaintaining;

  AppInfoStatus({
    required this.updateAvailable,
    required this.isMaintaining,
  });

  factory AppInfoStatus.initial() {
    return AppInfoStatus(
      updateAvailable: false,
      isMaintaining: false
    );
  }

  AppInfoStatus copyWith({
    bool? updateAvailable,
    bool? isMaintaining,
  }) {
    return AppInfoStatus(
      updateAvailable: updateAvailable ?? this.updateAvailable,
      isMaintaining: isMaintaining ?? this.isMaintaining,
    );
  }

  factory AppInfoStatus.fromJson(Map<String, dynamic> json) {
    return AppInfoStatus(
      updateAvailable: json['update_status'] as bool,
      isMaintaining: json['is_maintaining'] as bool
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'update_available': updateAvailable,
      'is_maintaining' : isMaintaining,
    };
  }
}
