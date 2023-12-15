import 'package:flutter/material.dart';

class ReuseableCard extends StatelessWidget {
  const ReuseableCard({
    super.key, required this.count, required this.title,
  });
  final String count, title;


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
        child: Column(
          children: [
            Text(count, style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
            Text(title)
          ],
        ),
      ),
    );
  }
}