import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonChatBubble extends StatelessWidget {
  SkeletonChatBubble({Key? key}) : super(key: key);

  final List<double> bubbleWidths = [
    180.0,
    140.0,
    220.0,
    120.0,
    160.0,
    190.0,
    140.0,
    150.0,
    130.0,
    200.0,
    170.0,
  ];

  Widget _buildBubble({
    required Alignment alignment,
    required double width,
  }) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(50),
        ),
        height: 40,
        width: width,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[200]!,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildBubble(alignment: Alignment.centerLeft, width: bubbleWidths[0]),
                _buildBubble(alignment: Alignment.centerLeft, width: bubbleWidths[1]),
                _buildBubble(alignment: Alignment.centerRight, width: bubbleWidths[2]),
                _buildBubble(alignment: Alignment.centerRight, width: bubbleWidths[3]),
                _buildBubble(alignment: Alignment.centerLeft, width: bubbleWidths[4]),
                _buildBubble(alignment: Alignment.centerLeft, width: bubbleWidths[5]),
                _buildBubble(alignment: Alignment.centerRight, width: bubbleWidths[6]),
                _buildBubble(alignment: Alignment.centerRight, width: bubbleWidths[7]),
                _buildBubble(alignment: Alignment.centerLeft, width: bubbleWidths[8]),
                _buildBubble(alignment: Alignment.centerRight, width: bubbleWidths[9]),
                _buildBubble(alignment: Alignment.centerLeft, width: bubbleWidths[10]),
                _buildBubble(alignment: Alignment.centerLeft, width: bubbleWidths[3]),
                _buildBubble(alignment: Alignment.centerRight, width: bubbleWidths[6]),
                _buildBubble(alignment: Alignment.centerLeft, width: bubbleWidths[2]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
