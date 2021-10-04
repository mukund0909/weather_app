import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather/services/weather.dart';
import 'location_screen.dart';
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}
class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getlocationData();
  }
  void getlocationData()async
  {
    WeatherModel weather=WeatherModel();
    var weatherData=await weather.getWeatherData();
    Navigator.push(context, MaterialPageRoute(builder: (context) { return LocationScreen(locationweather: weatherData,);}));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
