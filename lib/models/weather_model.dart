import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WeatherController extends GetxController {
  var isLoading = true.obs;
  var temperature = ''.obs;
  var description = ''.obs;
  var location = ''.obs;
  var country = ''.obs;
  var cityName = "istanbul".obs;

  Future<void> fetchWeather() async {
    var apiKey = '8fe320e393bc67139f0c3068cb3ce872';

    var url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        temperature.value =
            (result['main']['temp'] - 273.15).toStringAsFixed(1);
        description.value = result['weather'][0]['description'];
        location.value = result['name'];
        country.value = result["sys"]["country"];
      }
    } finally {
      isLoading.value = false;
    }
  }
}
