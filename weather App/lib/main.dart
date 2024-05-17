import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:weather_app/view/home.dart';
import 'package:weather_app/view/intro.dart';
import 'package:weather_app/widgets/noWeatherData.dart';
import 'package:weather_app/widgets/withWeatherData.dart';

import 'cubits/get_weather_cubit/get_weather_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => GetWeatherData(),
      child: Builder(
        builder: (BuildContext context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const Intro(),
        ),
      ),
    );
  }
}



Color getWeatherColor(String? weatherCondition) {
  if (weatherCondition == null )
    {
      return HexColor('#EDE6CB');
    }
  switch (weatherCondition) {
    case 'Clear':
      return HexColor('#EDE6CB');
    case 'Partly cloudy':
    case 'Sunny':
      return HexColor('#fff1bd');
    case 'Cloudy':
    case 'Overcast':
      return HexColor('#7d796b');
    case 'Patchy rain possible':
    case 'Patchy snow possible':
    case 'Mist':
    case 'Patchy sleet possible':
    case 'Patchy freezing drizzle possible':
    case 'Thundery outbreaks possible':
    case 'Blowing snow':
    case 'Blizzard':
    case 'Fog':
    case 'Freezing fog':
    case 'Patchy light drizzle':
    case 'Light drizzle':
    case 'Freezing drizzle':
    case 'Heavy freezing drizzle':
    case 'Patchy light rain':
    case 'Light rain':
    case 'Moderate rain at times':
    case 'Moderate rain':
    case 'Heavy rain at times':
    case 'Heavy rain':
    case 'Light freezing rain':
    case 'Moderate or heavy freezing rain':
    case 'Light sleet':
    case 'Moderate or heavy sleet':
    case 'Patchy light snow':
    case 'Light snow':
    case 'Patchy moderate snow':
    case 'Moderate snow':
    case 'Patchy heavy snow':
    case 'Heavy snow':
    case 'Ice pellets':
    case 'Light rain shower':
    case 'Moderate or heavy rain shower':
    case 'Torrential rain shower':
    case 'Light sleet showers':
    case 'Moderate or heavy sleet showers':
    case 'Light snow showers':
    case 'Moderate or heavy snow showers':
    case 'Light showers of ice pellets':
    case 'Moderate or heavy showers of ice pellets':
    case 'Patchy light rain with thunder':
    case 'Moderate or heavy rain with thunder':
    case 'Patchy light snow with thunder':
    case 'Moderate or heavy snow with thunder':
      return HexColor('#6e6d6a');
    default:
      return HexColor('#6b7c96');
  }
}
