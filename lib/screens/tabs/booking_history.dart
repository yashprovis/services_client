import 'package:flutter/material.dart';
import 'package:services_client/constants.dart';
import 'package:services_client/widgets/tabs/completed_tab.dart';

import '../../widgets/sc_text.dart';
import '../../widgets/tabs/upcoming_tab.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            body: Padding(
          padding: const EdgeInsets.only(top: 40, left: 12, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8, top: 10, bottom: 10),
                child: ScText(
                  "Booking History",
                  size: 20,
                ),
              ),
              const SizedBox(
                height: 50,
                child: const TabBar(
                  labelColor: primaryColor,
                  tabs: [
                    Tab(
                      text: "Upcoming",
                    ),
                    Tab(
                      text: "Completed",
                    ),
                  ],
                ),
              ),

              // create widgets for each tab bar here
              const Expanded(
                child: const TabBarView(
                  children: [
                    // first tab bar view widget
                    UpcomingBookingTab(),

                    // second tab bar viiew widget
                    const CompletedBookingTab()
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}
