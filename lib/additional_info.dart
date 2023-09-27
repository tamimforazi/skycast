import 'package:flutter/material.dart';

class AdditionalInformation extends StatelessWidget {
  final IconData icon;
  final Widget lebel;
  final String secondText;
  const AdditionalInformation({
    super.key,
    required this.icon,
    required this.lebel,
    required this.secondText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 30,
        ),
        const SizedBox(height: 8),
        lebel,
        const SizedBox(height: 8),
        Text(
          secondText,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
