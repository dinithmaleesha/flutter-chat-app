import 'package:flutter/material.dart';
import 'package:chat_app/features/chat_screen/views/chat_screen.dart';

class ChatUserCard extends StatelessWidget {
  final String name;
  final String deviceId;
  final String currentUserId; // The ID of the current user (sender)

  const ChatUserCard({
    Key? key,
    required this.name,
    required this.deviceId,
    required this.currentUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(
          name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          deviceId,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        trailing: Icon(Icons.chat_bubble_outline, color: Colors.blueAccent),
        onTap: () {
          // Navigate to ChatScreen with senderId and receiverId
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                senderId: currentUserId,
                receiverId: deviceId, // Pass the selected user's deviceId
              ),
            ),
          );
        },
      ),
    );
  }
}
