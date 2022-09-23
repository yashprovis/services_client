import 'package:flutter/material.dart';
import 'package:services_client/constants.dart';
import 'package:services_client/widgets/tabs/completed_tab.dart';

import '../../models/booking_model.dart';
import '../../services/booking_service.dart';
import '../../widgets/sc_text.dart';
import '../../widgets/tabs/upcoming_tab.dart';

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({Key? key}) : super(key: key);

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  List<Booking>? allBooking;
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    allBooking = await BookingService().fetchAllUserBookings();
    setState(() {});
  }

  changeBooking() {
    allBooking = null;
    setState(() {});
    init();
  }

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
                child: TabBar(
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
              allBooking == null
                  ? const SizedBox()
                  : Expanded(
                      child: TabBarView(
                        children: [
                          UpcomingBookingTab(
                              bookingList: allBooking ?? [],
                              func: changeBooking),
                          CompletedBookingTab(bookingList: allBooking ?? [])
                        ],
                      ),
                    ),
            ],
          ),
        )));
  }
}
