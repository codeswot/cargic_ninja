import 'package:cargic_ninja/screens/jobs_screen/jobs_tabs/past_job_tab.dart';
import 'package:cargic_ninja/screens/jobs_screen/jobs_tabs/pending_job_tab.dart';
import 'package:cargic_ninja/screens/jobs_screen/jobs_tabs/upcoming_job_tab.dart';
import 'package:cargic_ninja/utils/colors.dart';
import 'package:flutter/material.dart';

class JobScreen extends StatefulWidget {
  JobScreen({Key key, this.index}) : super(key: key);
  final int index;
  @override
  _JobScreenState createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> with TickerProviderStateMixin {
  TabController tabController;
  // int index = 0;
  List<Widget> jobTabs = [
    PendingJobs(),
    UpcomingJobs(),
    PastJobs(),
  ];
  @override
  void initState() {
    tabController = TabController(
        length: jobTabs.length, initialIndex: widget.index, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Your Job'),
        bottom: PreferredSize(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // height: 10,
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: TabBar(
                  controller: tabController,
                  labelColor: CargicColors.pitchBlack,
                  unselectedLabelColor: CargicColors.fairGrey,
                  indicatorSize: TabBarIndicatorSize.tab,
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: CargicColors.plainWhite,
                    boxShadow: [
                      BoxShadow(
                        color: CargicColors.cosmicShadow,
                        blurRadius: 6,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  tabs: [
                    Tab(
                      child: Container(
                        child: Text('Pending'),
                      ),
                    ),
                    Tab(
                      child: Container(
                        child: Text('Upcoming'),
                      ),
                    ),
                    Tab(
                      child: Container(
                        child: Text('Past'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
            ],
          ),
          preferredSize: Size.fromHeight(90),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: jobTabs,
      ),
    );
  }
}
