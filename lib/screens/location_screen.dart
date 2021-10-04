import 'package:flutter/material.dart';
import 'package:weather/services/weather.dart';
import 'package:weather/utilities/constants.dart';

import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
  LocationScreen({this.locationweather});
  final locationweather;
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature=0;
  String cityname="",condition="",s="";
  @override
  void initState() {
    super.initState();
    updateui(widget.locationweather);
  }
  void updateui(dynamic weatherData)
  {
    setState(() {
      if(weatherData==null){
        temperature=0;
        condition="Error";
        s="Unable to get weather data ";
        cityname="";
        return;
      }
      WeatherModel weather =WeatherModel();
      temperature=weatherData['main']['temp'].toInt();
      condition=weather.getWeatherIcon(weatherData['weather'][0]['id']);
      cityname=weatherData['name'];
      s=weather.getMessage(temperature);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      WeatherModel weather =WeatherModel();
                      var weatherData=await weather.getWeatherData();
                      updateui(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var value= await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));
                      if(value!=null){
                        WeatherModel weather =WeatherModel();
                        var weatherData=await weather.getWeatherDatabycity(value);
                        updateui(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature',
                      style: kTempTextStyle,
                    ),
                    Text(
                      condition,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  s+" in "+cityname,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
