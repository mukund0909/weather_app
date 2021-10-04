import 'package:geolocator/geolocator.dart';
import 'package:weather/main.dart';
class Location
{
  double latitude=0.0,longitude=0.0;
  Future <void> getcurrentlocation() async
  {
      try{
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
        latitude=position.latitude;
        longitude=position.longitude;
      }
      catch(e){
        print(e);
      }
  }
}