import 'package:chat_app/core/connectivity_bloc/connectivity_bloc.dart';
import 'package:chat_app/features/chat_screen/widgets/chat_app_bar.dart';
import 'package:chat_app/features/chat_screen/widgets/chat_bubble.dart';
import 'package:chat_app/features/chat_screen/widgets/chat_screen_skeleton.dart';
import 'package:chat_app/features/chat_screen/widgets/send_text_field.dart';
import 'package:chat_app/screen_distributor.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/shared_components/models/chat_model.dart';
import 'package:chat_app/shared_components/theme/color_pallet.dart';
import 'package:chat_app/shared_components/util/constants.dart';
import 'package:chat_app/shared_components/util/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String senderId;
  final String receiverId;
  final ChatService chatService = ChatService();
  final TextEditingController messageController = TextEditingController();

  ChatScreen({
    required this.name,
    required this.senderId,
    required this.receiverId,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    widget.messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (widget.messageController.text.isNotEmpty) {
      final message = ChatMessage(
        senderId: widget.senderId,
        receiverId: widget.receiverId,
        message: widget.messageController.text,
        timestamp: DateTime.now(),
      );
      widget.chatService.sendMessage(message);
      widget.messageController.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageBase(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPallet.mainColor,
          title: ChatAppBar(name: widget.name),
          iconTheme: IconThemeData(
            color: ColorPallet.white,
          ),
        ),
        backgroundColor: ColorPallet.backgroundColor,
        body: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.05,
                child: Image.asset(
                  ImageAssets.registerBackground,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Main content over the background
            Column(
              children: [
                BlocBuilder<ConnectivityBloc, ConnectivityState>(
                  builder: (context, connectivityState) {
                    final bool hasInternet = connectivityState.initialized && connectivityState.hasInternet;
                    return FittedBox(
                      fit: BoxFit.contain,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: ColorPallet.gray,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            hasInternet
                                ? Icon(
                              Icons.info_outline,
                              color: ColorPallet.grayColor,
                              size: 10,
                            )
                                : SizedBox(
                              width: 15.0,
                              height: 15.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(ColorPallet.grayColor),
                                strokeWidth: 2.0,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              hasInternet ? Constants.privacy : Constants.reconnect,
                              style: TextStyle(fontSize: 11, color: ColorPallet.grayColor),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Expanded(
                  child: BlocBuilder<ConnectivityBloc, ConnectivityState>(
                    builder: (context, connectivityState) {
                      final bool hasInternet = connectivityState.initialized && connectivityState.hasInternet;

                      if (!hasInternet) {
                        return Center(
                          child: Container(
                            width: 250.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              color: ColorPallet.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  ImageAssets.ghost,
                                  scale: 8,
                                  color: ColorPallet.grayColor,
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  Constants.noInternet,
                                  style: TextStyle(color: ColorPallet.grayColor, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return StreamBuilder<List<ChatMessage>>(
                        stream: widget.chatService.getMessages(widget.senderId, widget.receiverId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          final messages = snapshot.data ?? [];

                          if (messages.isEmpty) {
                            return Center(
                              child: Container(
                                width: 250.w,
                                height: 100.h,
                                decoration: BoxDecoration(
                                  color: ColorPallet.white,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      ImageAssets.ghost,
                                      scale: 8,
                                      color: ColorPallet.grayColor,
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      Constants.noMessages,
                                      style: TextStyle(color: ColorPallet.grayColor, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          if (messages.isNotEmpty) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              _scrollToBottom();
                            });
                          }
                          return ListView.builder(
                            controller: _scrollController,
                            padding: EdgeInsets.only(bottom: 10),
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final message = messages[index];
                              final isMe = message.senderId == widget.senderId;

                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                                child: Align(
                                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                                  child: ChatBubble(
                                    message: message.message,
                                    time: message.timestamp,
                                    isMe: isMe,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(10),
                  color: ColorPallet.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: SendTextField(
                          controller: widget.messageController,
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: ColorPallet.mainGradient,
                        ),
                        alignment: Alignment.center,
                        child: IconButton(
                          icon: Icon(Icons.send, color: ColorPallet.white),
                          onPressed: _sendMessage,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}

