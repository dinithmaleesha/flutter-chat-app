import 'package:flutter/material.dart';

class UnderMaintenanceScreen extends StatelessWidget {
  const UnderMaintenanceScreen({super.key});

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
                Icons.build,
                color: Colors.orangeAccent,
                size: 80,
              ),
              SizedBox(height: 20),
              Text(
                'Under Maintenance',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We are currently performing some updates to improve your experience. '
                    'Please check back later. We appreciate your patience!',
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
