import 'package:chat_app/shared_components/widgets/no_internet_connection.dart';
import 'package:flutter/material.dart';

class PopupHandler {
  static void showNoInternetConnectivityDialog(BuildContext context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const NoInternetConnection();
        },
      );
    });
  }
}
