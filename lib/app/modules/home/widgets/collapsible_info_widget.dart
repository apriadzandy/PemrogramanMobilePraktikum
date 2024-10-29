// lib/modules/detail/collapsible_info_widget.dart
import 'package:flutter/material.dart';

class CollapsibleInfoWidget extends StatefulWidget {
  final String title;
  final String content;

  const CollapsibleInfoWidget({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  _CollapsibleInfoWidgetState createState() => _CollapsibleInfoWidgetState();
}

class _CollapsibleInfoWidgetState extends State<CollapsibleInfoWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Icon(
                _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                size: 20,
              ),
            ],
          ),
        ),
        if (_isExpanded)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              widget.content,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        const SizedBox(height: 10),
      ],
    );
  }
}
