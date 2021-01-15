import 'package:cargic_ninja/helpers/http_helper.dart';
import 'package:cargic_ninja/keys/google_map_keys.dart';
import 'package:cargic_ninja/models/back_end/address_model.dart';
import 'package:cargic_ninja/providers/app_data.dart';
import 'package:connectivity/connectivity.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class LocationHelper {
  Future<String> findCoordAddress(Position position, context) async {
    //placeAddress|if internet return placeAdress
    String placeAddress = '';
    var _connectivityResult = await (Connectivity().checkConnectivity());
    if (_connectivityResult != ConnectivityResult.mobile &&
        _connectivityResult != ConnectivityResult.wifi) {
      //
      return placeAddress;
    }
    //url from app has (link,lng and lat from findCoord position,api key)
    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$androidMapKey';
    //call http helper getRequest and pass (url) as argument to
    //be expected then pass it to (response) var
    var response = await RequestHelper.getRequest(url);
    // print('my re $response');
    //if getRequest passed to(response) var returns String [NOT]'failed'
    if (response != 'failed') {
      //get the data from the response and pass to (placeAddress) var
      placeAddress = await response['results'][0]['formatted_address'];
      Address userAdress = new Address();
      userAdress.lat = position.latitude;
      userAdress.lng = position.longitude;
      userAdress.placeName = placeAddress;
      Provider.of<AppData>(context, listen: false)
          .updateUserAddress(userAdress);
    }
    return placeAddress;
  }
}
