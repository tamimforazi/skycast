import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/additional_info.dart';
import 'package:weather_app/perhour_forecast.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrete_key.dart';

class weatherApp extends StatefulWidget {
  const weatherApp({super.key});

  @override
  State<weatherApp> createState() => weatherAppState();
}

class weatherAppState extends State<weatherApp> {
  late Future<Map<String, dynamic>> weather;

  Future<Map<String, dynamic>> getWeather() async {
    try {
      // String cityName = 'London';
      final res = await http.get(
        Uri.parse(
            "http://api.openweathermap.org/data/2.5/forecast?q=London&APPID=2e379a76e9e91f115eb5d026373f58cb"),
      );

      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    weather = getWeather();
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
            onPressed: () {
              setState(() {
                weather = getWeather();
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
          future: getWeather(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            final data = snapshot.data!;
            final currentWeatherData = data['list'][0];

            final currentSky = currentWeatherData['weather'][0]['main'];
            final currentTemp = currentWeatherData['main']['temp'];
            final currentPressure = currentWeatherData['main']['pressure'];
            final currentWindSpeed = currentWeatherData['wind']['speed'];
            final currentHumidity = currentWeatherData['main']['humidity'];
            return Padding(
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
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            '$currentTemp k',
                            style: const TextStyle(
                                fontSize: 34,
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          Icon(
                            currentSky == 'Clouds' || currentSky == 'Rain'
                                ? Icons.cloud
                                : Icons.sunny,
                            color: const Color.fromARGB(255, 144, 194, 235),
                            size: 68,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            currentSky,
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
                const SizedBox(height: 8),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final hourlyForecast = data['list'][index + 1];
                      final hourlySky =
                          data['list'][index + 1]['weather'][0]['main'];
                      final hourlyTemp =
                          hourlyForecast['main']['temp'].toString();
                      final time = DateTime.parse(hourlyForecast['dt_txt']);
                      return PerHourForecast(
                        time: DateFormat.j().format(time),
                        temperature: hourlyTemp,
                        icon: hourlySky == 'Clouds' || hourlySky == 'Rain'
                            ? Icons.cloud
                            : Icons.sunny,
                      );
                    },
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
                      lebel: Text('Humidity'),
                      secondText: currentHumidity.toString(),
                    ),
                    AdditionalInformation(
                      icon: Icons.thunderstorm,
                      lebel: Text('Wind Speed'),
                      secondText: currentWindSpeed.toString(),
                    ),
                    AdditionalInformation(
                      icon: Icons.sunny,
                      lebel: Text('Pressure'),
                      secondText: currentPressure.toString(),
                    ),
                  ],
                )
              ]),
            );
          }),
    );
  }
}
