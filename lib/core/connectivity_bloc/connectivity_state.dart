part of 'connectivity_bloc.dart';

class ConnectivityState extends Equatable {
  const ConnectivityState({
    required this.isBluetoothOn,
    required this.hasInternet,
    required this.connection,
    required this.isWifiOn,
    required this.initialized
  });

  final bool isBluetoothOn;
  final bool hasInternet;
  final bool isWifiOn;
  final ConnectivityResult connection;
  final bool initialized;

  factory ConnectivityState.initial() {
    return ConnectivityState(
        isBluetoothOn: false,
        isWifiOn: false,
        hasInternet: true,
        connection: ConnectivityResult.none,
        initialized: false
    );
  }

  ConnectivityState copyWith({
    bool? isBluetoothOn,
    bool? hasInternet,
    bool? isWifiOn,
    ConnectivityResult? connection,
    bool? initialized
  }) {
    return ConnectivityState(
        isBluetoothOn: isBluetoothOn ?? this.isBluetoothOn,
        isWifiOn: isWifiOn ?? this.isWifiOn,
        hasInternet: hasInternet ?? this.hasInternet,
        connection: connection ?? this.connection,
        initialized: initialized ?? this.initialized
    );
  }

  @override
  List<Object?> get props => [
    isBluetoothOn,
    isWifiOn,
    hasInternet,
    connection,
    initialized
  ];
}
