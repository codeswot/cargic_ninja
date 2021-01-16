import 'package:cargic_ninja/widgets/upcoming_job_card.dart';
import 'package:flutter/material.dart';

class UpcomingJobs extends StatelessWidget {
  const UpcomingJobs({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 15),
        itemBuilder: (context, index) {
          return UpComingJobsCard(
            orderID: '#234rrf',
            serviceType: 'Car Wash',
            dateTime: '06 November at 02:00pm',
            location: 'U/Rimi, Kaduna',
          );
        },
        itemCount: 5,
      ),
    );
  }
}
