import 'dart:io';

import 'package:cargic_ninja/helpers/http_helper.dart';
import 'package:cargic_ninja/helpers/location_helper.dart';
import 'package:cargic_ninja/keys/google_map_keys.dart';
import 'package:cargic_ninja/models/back_end/address_model.dart';
import 'package:cargic_ninja/models/back_end/prediction_search_model.dart';
import 'package:cargic_ninja/providers/app_data.dart';
import 'package:cargic_ninja/utils/colors.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class ChangeLocationScreen extends StatefulWidget {
  static const String id = 'ChangeLocationScreen';

  @override
  _ChangeLocationScreenState createState() => _ChangeLocationScreenState();
}

class _ChangeLocationScreenState extends State<ChangeLocationScreen> {
  FocusNode focusDestination = FocusNode();
  TextEditingController changeAddressController = TextEditingController();
  LocationHelper _locationHelper = LocationHelper();

  Geolocator _geolocator = Geolocator();
  Position currentPosition;
  bool focused = false;
  void getFocus() {
    if (!focused) {
      FocusScope.of(context).requestFocus(focusDestination);
      focused = true;
    }
  }

  List<PredictionSearchModel> predictedDestiList = [];
  void searchPlaces(String placeName) async {
    final apiKey = Platform.isAndroid ? androidMapKey : iosMapKey;
    //
    print(apiKey);
    if (placeName.length > 1) {
      String url =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$apiKey&sessiontoken=123254251&components=country:ng';
      var response = await RequestHelper.getRequest(url);
      if (response == 'failed') {
        return;
      }
      print('This is result :: $response');

      if (response['status'] == 'OK') {
        var predictionsJson = response['predictions'];
        var thisList = (predictionsJson as List)
            .map((e) => PredictionSearchModel.fromJson(e))
            .toList();
        setState(() {
          predictedDestiList = thisList;
        });
      } else {
        print('ERROORR!!');
      }
    }
  }

  void updatePlaceAddress(String placeID, context) async {
    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (context) {
    //       return ProgressDialoger(
    //         message: 'Please wait...',
    //       );
    //     });
    final apiKey = Platform.isAndroid ? androidMapKey : iosMapKey;

    String url =
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeID&key=$apiKey';
    var response = await RequestHelper.getRequest(url);
    if (response == 'failed') {
      return;
    }
    if (response['status'] == 'OK') {
      Address thisPlace = Address();
      thisPlace.placeID = placeID;
      thisPlace.placeName = response['result']['name'];
      thisPlace.lat = response['result']['geometry']['location']['lat'];
      thisPlace.lng = response['result']['geometry']['location']['lng'];
      Provider.of<AppData>(context, listen: false).updateUserAddress(thisPlace);
      print(thisPlace.placeName);
      Navigator.pop(context);
    }
  }

  getUserPosition() async {
    Position position = await _geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;
    // confirm location
    await _locationHelper.findCoordAddress(currentPosition, context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    getFocus();
    // String address =
    //     Provider.of<AppData>(context, listen: false).userAdress.placeName ?? '';
    // changeAddressController.text = address;
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: CargicColors.plainWhite,
            boxShadow: [
              BoxShadow(
                color: CargicColors.cosmicShadow,
                blurRadius: 6.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 22),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: changeAddressController,
                      focusNode: focusDestination,
                      onChanged: (placeVal) {
                        searchPlaces(placeVal);
                      },
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: Icon(Icons.close),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 17),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ),
          ),
        ),
        preferredSize: Size.fromHeight(100),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            // AddFromMapButton(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.location_on,
                      color: CargicColors.fairGrey,
                    ),
                    onPressed: () {
                      getUserPosition();
                    })
              ],
            ),
            Flexible(
              child: (predictedDestiList.length > 0)
                  ? ListView.separated(
                      itemBuilder: (context, index) {
                        return Container(
                          child: ListTile(
                            onTap: () {
                              updatePlaceAddress(
                                  predictedDestiList[index].placeId, context);
                            },
                            title: Text(predictedDestiList[index].mainText),
                            subtitle:
                                Text(predictedDestiList[index].secondaryText),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(color: CargicColors.fairGrey);
                      },
                      itemCount: predictedDestiList.length,
                      shrinkWrap: true,
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}

class AddFromMapButton extends StatelessWidget {
  const AddFromMapButton({
    Key key,
    this.onTap,
  }) : super(key: key);
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: CargicColors.plainWhite,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: CargicColors.cosmicShadow,
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_location,
                  color: CargicColors.fairGrey,
                  size: 18,
                ),
                SizedBox(width: 11),
                Text(
                  'Set Location on Map',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            Icon(Icons.chevron_right, color: CargicColors.fairGrey)
          ],
        ),
      ),
    );
  }
}
