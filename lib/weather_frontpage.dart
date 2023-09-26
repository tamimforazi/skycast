import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/additional_info.dart';
import 'package:weather_app/perhour_forecast.dart';
import 'package:http/http.dart' as http;

class weatherApp extends StatefulWidget {
  const weatherApp({super.key});

  @override
  State<weatherApp> createState() => _weatherAppState();
}

class _weatherAppState extends State<weatherApp> {
  @override
  void initState() {
    super.initState();
    getWeather();
  }

  Future getWeather() async {
    try {
      String cityName = 'London';
      final res = await http.get(
        Uri.parse(
            "http:/api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=2e379a76e9e91f115eb5d026373f58cb"),
      );
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SKYCast",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 36,
              color: Color.fromARGB(255, 8, 144, 255)),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          SizedBox(
            width: double.infinity,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "30°C",
                      style: TextStyle(
                          fontSize: 34,
                          color: Colors.cyan,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Icon(
                      Icons.cloud,
                      color: const Color.fromARGB(255, 144, 194, 235),
                      size: 68,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Cloud",
                      style: TextStyle(fontSize: 20, color: Colors.cyan),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            "Weather Forecast",
            style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 87, 184, 111),
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                PerHourForecast(
                  time: "00.00",
                  icon: Icons.cloud,
                  temperature: "25°C",
                ),
                PerHourForecast(
                  time: "04.00",
                  icon: Icons.sunny,
                  temperature: "30°C",
                ),
                PerHourForecast(
                  time: "08.00",
                  icon: Icons.sunny,
                  temperature: "28°C",
                ),
                PerHourForecast(
                  time: "12.00",
                  icon: Icons.cloud,
                  temperature: "25°C",
                ),
                PerHourForecast(
                  time: "16.00",
                  icon: Icons.thunderstorm,
                  temperature: "21°C",
                ),
                PerHourForecast(
                  time: "20.00",
                  icon: Icons.cloud,
                  temperature: "25°C",
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            "Additional Information",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 87, 184, 111),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AdditionalInformation(
                icon: Icons.water_drop,
                firstText: Text("Humadity"),
                secondText: "76%",
              ),
              AdditionalInformation(
                icon: Icons.thunderstorm,
                firstText: Text("Thunderstrom"),
                secondText: "20%",
              ),
              AdditionalInformation(
                icon: Icons.sunny,
                firstText: Text("sunny"),
                secondText: "95%",
              ),
            ],
          )
        ]),
      ),
    );
  }
}
