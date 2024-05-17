import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_model.dart';


class WeatherService{

   final Dio dio = Dio() ;
   final String baseUrl = 'http://api.weatherapi.com/v1';
   final String apiKey ='4d0e196d8c6b499d8ae125638230410';

  WeatherService(Dio dio);
  Future<WeatherModel?> getCurrentWeather({required String cityName}) async {
     try {
       Response response = await dio.get(
           '$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=1');
       WeatherModel weatherModel = WeatherModel.fromJson(response.data);
       return weatherModel;

     } on DioException catch(e){
    final String errorMessage = e.response?.data['error']['message'] ??
        'Oops There is a problem, Try Later';
    throw Exception(errorMessage);
     }
     catch(e){
       log(e.toString());
       throw Exception('Oops There is a problem, Maybe Try Later');
     }
  }
}

// http://api.weatherapi.com/v1/forecast.json?key=4d0e196d8c6b499d8ae125638230410&q=Cairo&days=1