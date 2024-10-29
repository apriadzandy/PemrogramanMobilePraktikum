import 'package:http/http.dart' as http;
import 'package:laund/app/data/models/weather_model.dart';
import 'dart:convert';

class WeatherService {
  final String apiUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey = '0d5247d3f342b0102098fdb0aa409384'; 

  Future<WeatherResponse?> fetchWeather() async {
    final url = Uri.parse('$apiUrl?q=Malang&units=metric&appid=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return WeatherResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal mengambil data cuaca');
    }
  }
}






