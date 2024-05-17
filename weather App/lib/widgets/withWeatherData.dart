import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/models/weather_model.dart';



class WithDataBody extends StatelessWidget {
  const WithDataBody({Key? key}) : super(key: key);

  @override
  Widget build (BuildContext context) {
     WeatherModel weatherModel =BlocProvider.of<GetWeatherData>(context).weatherModel!;
    return Scaffold(
      backgroundColor: HexColor('#EDE6CB'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: (){
                      BlocProvider.of<GetWeatherData>(context).clearState();

                },
                    icon: Icon(Icons.search_outlined,size: 30,
                        color: HexColor('#a69e83')))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on_outlined, size: 40,color: HexColor('#FF6053')),
                const SizedBox(width: 5,),
                  Text(weatherModel.location,
                style: const TextStyle(fontSize: 40,fontWeight: FontWeight.w100 ),)
              ],
            ),
           const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:   [
                Text('${weatherModel.date.hour}:${weatherModel.date.minute} ',
                  style: const TextStyle(fontSize: 30,
                      fontWeight: FontWeight.w300),)
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Image.network('http:${weatherModel.icon.toString()}',scale: .4,)
              ],),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Text('${weatherModel.avgTemp.round().toString()}°C',
                  style: const TextStyle(fontSize: 65,
                      fontWeight: FontWeight.w100),)
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Text(weatherModel.condition,
                  style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.w100,
                  color: HexColor('#4f4933')),)
              ],
            ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(Icons.wb_cloudy_outlined,size: 30,
                        color: HexColor('#a69e83')),
                  Text('${weatherModel.minTemp.round().toString()}°C',
                    style: TextStyle(
                      fontSize: 25,
                      color: HexColor('#a69e83')),)
                ],),
                Column(
                  children: [
                    Icon(Icons.sunny,size: 30,color: HexColor('#a69e83')),
                    Text('${weatherModel.maxTemp.round().toString()}°C',
                      style: TextStyle(
                        fontSize: 25,
                          color: HexColor('#a69e83')),)
                  ],),
              ],
            )
          ],
        ),
      ),
    );
  }
}

