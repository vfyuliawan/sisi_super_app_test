// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class HorizontalTimeline extends StatelessWidget {
  final List<TimelineItem> items;

  const HorizontalTimeline({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items.map((item) => _buildTimelineItem(item)).toList(),
      ),
    );
  }

  Widget _buildTimelineItem(TimelineItem item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Circle for the timeline marker
        Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor:
                      item.isCompleted ? Colors.green : Colors.grey,
                  child: Icon(
                    item.isCompleted ? Icons.check : Icons.circle,
                    color: Colors.white,
                  ),
                ),
                // Label for the item
              ],
            ),
            Text(
              item.title,
              style: TextStyle(
                  color: item.isProgress ? Colors.green : Colors.grey,
                  fontWeight:
                      item.isProgress ? FontWeight.bold : FontWeight.normal),
            ),
          ],
        ),
        Container(
          width: 20,
          height: 1,
          color: item.isCompleted ? Colors.green : Colors.grey,
        ),
      ],
    );
  }
}

class TimelineItem {
  final String title;
  final bool isCompleted;
  final bool isProgress;

  TimelineItem({
    required this.title,
    required this.isCompleted,
    required this.isProgress,
  });
}
