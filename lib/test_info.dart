import 'package:chat_app/services/firebase_service.dart';
import 'package:flutter/material.dart';
import '../shared_components/models/app_info_status.dart';

class TestAppInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test App Info')),
      body: StreamBuilder<AppInfoStatus?>(
        stream: FirebaseService().getAppInfoDataStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            final appInfo = snapshot.data!;
            return Center(
              child: Text(
                'Update Available: ${appInfo.updateAvailable}',
                textAlign: TextAlign.center,
              ),
            );
          }
        },
      ),
    );
  }
}
