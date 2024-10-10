import 'package:flutter/material.dart';

class UpdateAvailableScreen extends StatelessWidget {
  const UpdateAvailableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.update,
                color: Colors.blueAccent,
                size: 80,
              ),
              SizedBox(height: 20),
              Text(
                'Update Available!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'A new version of the app is available with exciting features and improvements. Please update to continue using the app with the best experience.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
