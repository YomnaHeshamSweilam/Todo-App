

class WeatherModel{
final String location;
final DateTime date;
final String? icon;
final String condition;
final double avgTemp;
final double minTemp;
final double maxTemp;

  WeatherModel(
    {
      required this.location,
      required this.date,
      required this.condition,
      required this.avgTemp,
      required this.minTemp,
      required this.maxTemp,
      required this.icon});

   factory WeatherModel.fromJson(json){
     return WeatherModel(
         location: json['location']['name'] ,
         date: DateTime.parse(json['current']['last_updated']),
         condition: json['forecast']['forecastday'][0]['day']['condition']['text'],
         avgTemp: json['forecast']['forecastday'][0]['day']['avgtemp_c'],
         minTemp: json['forecast']['forecastday'][0]['day']['mintemp_c'],
         maxTemp: json['forecast']['forecastday'][0]['day']['maxtemp_c'],
         icon: json['current']['condition']['icon']);
   }
}

