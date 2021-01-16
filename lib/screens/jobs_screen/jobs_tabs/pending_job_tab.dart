import 'package:cargic_ninja/widgets/pending_job_card.dart';
import 'package:flutter/material.dart';

class PendingJobs extends StatelessWidget {
  const PendingJobs({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 15),
        itemBuilder: (context, index) {
          return PendingJobsCard(
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
