import 'package:flutter/material.dart';

class PerHourForecast extends StatelessWidget {
  final String time;
  final String temperature;
  final IconData icon;
  const PerHourForecast(
      {super.key,
      required this.time,
      required this.temperature,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          children: [
            Text(
              time,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 7),
            Icon(
              icon,
              color: const Color.fromARGB(255, 144, 194, 235),
              size: 30,
            ),
            const SizedBox(height: 8),
            Text(
              temperature,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
