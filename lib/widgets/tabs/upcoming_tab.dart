import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:services_client/widgets/sc_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';
import '../../helpers/methods.dart';
import '../../models/booking_model.dart';
import '../dialogs/cancel_booking.dart';

class UpcomingBookingTab extends StatefulWidget {
  final List<Booking> bookingList;
  final void Function()? func;
  const UpcomingBookingTab({Key? key, required this.bookingList, this.func})
      : super(key: key);

  @override
  State<UpcomingBookingTab> createState() => _UpcomingBookingTabState();
}

class _UpcomingBookingTabState extends State<UpcomingBookingTab> {
  List<Booking> upcomingBookings = [];

  @override
  void initState() {
    upcomingBookings = widget.bookingList.where((element) {
      return (element.bookingStatus == "created" &&
          element.bookingDate
                  .add(const Duration(minutes: 180))
                  .millisecondsSinceEpoch >
              DateTime.now().millisecondsSinceEpoch);
    }).toList();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 2),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 4),
        shrinkWrap: true,
        itemCount: upcomingBookings.length,
        //  physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ScText("Id: ${upcomingBookings[index].id}",
                            size: 14, color: primaryColor),
                        Row(
                          children: [
                            GestureDetector(
                                // onTap: () => downloadPdf(),
                                child:
                                    const Icon(Icons.timer_outlined, size: 22)),
                            const SizedBox(width: 4),
                            Text(
                                "${durationToString(upcomingBookings[index].bookingDuration)} Hr."),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: ScText(
                          "Date: ${DateFormat("MMM dd,yy hh:mm a").format(upcomingBookings[index].bookingDate)}",
                          size: 12,
                          color: Colors.grey),
                    ),
                    ScText("Customer: ${upcomingBookings[index].customerName}",
                        size: 14),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: ScText(
                          "Amount: ₹${upcomingBookings[index].bookingTotal}",
                          size: 14),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2, bottom: 2),
                      child: ScText(
                          "Address: ${upcomingBookings[index].address.toString()}",
                          size: 12,
                          color: Colors.grey[600]),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              final Uri telLaunchUri = Uri(
                                scheme: 'tel',
                                path: upcomingBookings[index].workerPhone,
                              );
                              canLaunchUrl(telLaunchUri);
                            },
                            child: const Text(
                              "Contact",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 4),
                            child: GestureDetector(
                              onTap: () {
                                cancelDialog(context, upcomingBookings[index],
                                        "current")
                                    .then((value) {
                                  if (value != null) {
                                    widget.func!();
                                  }
                                });
                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
