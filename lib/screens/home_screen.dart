import 'package:cargic_ninja/providers/app_data.dart';
import 'package:cargic_ninja/screens/change_location_screen.dart';
import 'package:cargic_ninja/widgets/brand_name.dart';
import 'package:cargic_ninja/widgets/job_card.dart';
import 'package:cargic_ninja/widgets/location_card.dart';
import 'package:cargic_ninja/widgets/ninja_card.dart';
import 'package:cargic_ninja/widgets/online_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NinjaHome extends StatefulWidget {
  static const String id = 'NinjaHome';
  @override
  _NinjaHomeState createState() => _NinjaHomeState();
}

class _NinjaHomeState extends State<NinjaHome> {
  bool isOnline = false;
  String title = 'Go Online';
  @override
  Widget build(BuildContext context) {
    if (isOnline) {
      title = 'Go Offline';
    } else {
      title = 'Go Online';
    }
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: CargicBrandName(width: 20, height: 20),
        titleSpacing: -3,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              LocationCard(
                location: Provider.of<AppData>(context).userAdress.placeName,
                onTap: () {
                  Navigator.of(context).pushNamed(ChangeLocationScreen.id);
                },
              ),
              NinjaCard(
                ninjaImage: '',
                ninjaName: 'Yusuf Damu',
                onRefreshPress: () {},
              ),
              OnlineCard(
                title: title,
                onChanged: (val) {
                  setState(() {
                    isOnline = val;
                  });
                },
                value: isOnline,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: JobsCard(
                      count: 0,
                      title: 'Pending Jobs',
                    ),
                  ),
                  Flexible(
                    child: JobsCard(
                      count: 1,
                      title: 'Upcoming Jobs',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
