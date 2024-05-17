import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/service/weather_service.dart';

class NoDataBody extends StatelessWidget {
   NoDataBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#EDE6CB'),
        elevation: 0,
        systemOverlayStyle:
        SystemUiOverlayStyle(statusBarColor: HexColor('#EDE6CB')),
      ),
      backgroundColor: HexColor('#EDE6CB'),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Sw.png',
                    scale: 1.5,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search, color: HexColor('#FFA957')),
                    ),
                    hintText: 'Search By The City .. ',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor('#FFA957')),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onSubmitted: (value) async {
                    var getWeatherCubit = BlocProvider.of<GetWeatherData>(context);
                    getWeatherCubit.getCurrentWeatherData(cityName: value);

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// #393E5B  dark blue
// #FFA957  yellow
// #FF6053  red
// #EDE6CB beige
