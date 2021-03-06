
import 'package:weather/services/location.dart';
import 'package:weather/services/networking.dart';
const apikey= "816f0eb20b9d99b57b10eebdd94bb221";
class WeatherModel {
  Future getWeatherDatabycity(String city) async
  {
    Location location=Location();
    String s="https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apikey&units=metric";
    Uri url=Uri.parse(s);
    NetworkHelper networkHelper=NetworkHelper(url);
    var weatherData= await networkHelper.getData();
    return weatherData;
  }
  Future getWeatherData() async
  {
    Location location=Location();
    await location.getcurrentlocation();
    String s="https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apikey&units=metric";
    Uri url=Uri.parse(s);
    NetworkHelper networkHelper=NetworkHelper(url);
    var weatherData= await networkHelper.getData();
    return weatherData;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
