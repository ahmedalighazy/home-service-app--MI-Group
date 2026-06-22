import 'package:flutter/material.dart';

class SectionContent extends StatelessWidget {
  final String title;
  final String description;
  final bool showCheckIcon;

  const SectionContent({
    super.key,
    required this.title,
    required this.description,
    this.showCheckIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    final items = description.split('\n').where((e) => e.trim().isNotEmpty);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xff1E2A5A),
          ),
        ),
        const SizedBox(height: 12),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showCheckIcon)
                  const Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: CircleAvatar(
                      radius: 9,
                      backgroundColor: Color(0xff149954),
                      child: Icon(Icons.check, color: Colors.white, size: 13),
                    ),
                  )
                else
                  const Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: Text(
                      '•',
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                  ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
