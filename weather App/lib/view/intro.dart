import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/view/home.dart';

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/11.png',
                scale: 1.2,
              ),
            ],
          ),
          SizedBox(
            width: 180,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(HexColor('#393E5B'))),
              child: Text(
                'get started'.toUpperCase(),
                style: const TextStyle(fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// #393E5B  dark blue
// #FFA957  yellow
// #FF6053  red
// #EDE6CB beige
