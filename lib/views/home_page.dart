import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/weather_model.dart';

class WeatherPage extends StatelessWidget {
  final weatherController = Get.put(WeatherController());

  WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController cityController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Weather')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: cityController,
            ),
            Obx(() => weatherController.isLoading.value
                ? const CircularProgressIndicator()
                : Text(
                    '${weatherController.temperature.value}°C\n${weatherController.description.value}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24),
                  )),
            const SizedBox(height: 16),
            Obx(() => Text(
                  weatherController.location.value,
                  style: const TextStyle(fontSize: 20),
                )),
            Obx(() => Text(
                  weatherController.country.value,
                  style: const TextStyle(fontSize: 20),
                )),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                weatherController.cityName = cityController.text.obs;
                weatherController.fetchWeather();
              },
              child: const Text('Refresh'),
            )
          ],
        ),
      ),
    );
  }
}
