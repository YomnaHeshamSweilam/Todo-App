
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/models/weather_model.dart';
import '../../service/weather_service.dart';

class GetWeatherData extends Cubit<WeatherStates>
{
  GetWeatherData() : super (InitialState());
    WeatherModel? weatherModel ;

  getCurrentWeatherData({required String cityName})
  async {
    try{
       weatherModel = (await WeatherService(Dio())
          .getCurrentWeather(cityName: cityName))!;
      emit(LoadedWeatherData());

    }  catch(e)
    {
      emit(FailedWeatherData());
    }




  }


  clearState(){
    emit(ClearState());
  }

}
