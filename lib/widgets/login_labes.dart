import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String route;
  final String subtitle;
  final String title;
  const Labels({
    Key? key,
    required this.route,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            subtitle,
            style: const TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => Navigator.pushReplacementNamed(context, route),
            child: Text(
              title,
              style: TextStyle(color: Colors.blue.shade600, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
