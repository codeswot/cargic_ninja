import 'package:cargic_ninja/widgets/past_job_card.dart';
import 'package:flutter/material.dart';

class PastJobs extends StatelessWidget {
  const PastJobs({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 15),
        itemBuilder: (context, index) {
          return PastJobsCard(
            orderID: '#234rrf',
            serviceType: 'Car Wash',
            dateTime: '06 November at 02:00pm',
            location: 'U/Rimi, Kaduna',
            rating: 2.4,
          );
        },
        itemCount: 5,
      ),
    );
  }
}
