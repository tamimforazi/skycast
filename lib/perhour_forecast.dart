import 'package:flutter/material.dart';

class PerHourForecast extends StatelessWidget {
  const PerHourForecast({super.key});

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
              "3.00 AM",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 7),
            Icon(
              Icons.cloud,
              color: const Color.fromARGB(255, 144, 194, 235),
              size: 30,
            ),
            const SizedBox(height: 8),
            Text(
              "24°C",
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
