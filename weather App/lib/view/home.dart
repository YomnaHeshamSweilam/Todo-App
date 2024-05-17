import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/widgets/withWeatherData.dart';


import '../widgets/noWeatherData.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetWeatherData, WeatherStates>(
          builder: (BuildContext context, state) {
            if(state is InitialState )
              {
                return NoDataBody();
              }
            else if(state is LoadedWeatherData)
              {
                return WithDataBody();
              }
            else if(state is ClearState)
            {
              return NoDataBody();
            }
            else {
              return const Text('Oops there is a problem');
            }
          },
      );

  }
}

// #393E5B  dark blue
// #FFA957  yellow
// #FF6053  red
// #EDE6CB beige
