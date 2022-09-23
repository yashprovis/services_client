import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:services_client/widgets/dialogs/cancel_booking.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';
import '../../helpers/methods.dart';
import '../../models/booking_model.dart';
import '../sc_button.dart';
import '../sc_text.dart';

class CreatedBooking extends StatelessWidget {
  final Booking nextBooking;
  const CreatedBooking({super.key, required this.nextBooking});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: GestureDetector(
        onTap: () {
          // Navigator.of(context).pushNamed(InvoicePreview.routeName,
          //     arguments: "SW000${index + 1}");
        },
        child: Card(
          elevation: 4,
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
                    ScText("Id: ${nextBooking.id}",
                        size: 14, color: primaryColor),
                    Row(
                      children: [
                        GestureDetector(
                            // onTap: () => downloadPdf(),
                            child: const Icon(Icons.timer_outlined, size: 22)),
                        const SizedBox(width: 4),
                        Text(
                            "${durationToString(nextBooking.bookingDuration)} Hr."),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ScText(
                      "Date: ${DateFormat("MMM dd,yy hh:mm a").format(nextBooking.bookingDate)}",
                      size: 12,
                      color: Colors.grey),
                ),
                ScText("Customer: ${nextBooking.customerName}", size: 14),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child:
                      ScText("Amount: ₹${nextBooking.bookingTotal}", size: 14),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 2),
                  child: ScText("Address: ${nextBooking.address.toString()}",
                      size: 12, color: Colors.grey[600]),
                ),
                const Divider(),
                ScButton(
                    text: "OTP: ${nextBooking.bookingOtp}",
                    func: () {},
                    height: 40,
                    isLoading: false),
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
                            path: nextBooking.workerPhone,
                          );
                          canLaunchUrl(telLaunchUri);
                        },
                        child: const Text(
                          "Contact",
                          style: TextStyle(
                              color: primaryColor, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 20, right: 4),
                          child: GestureDetector(
                            onTap: () {
                              cancelDialog(context, nextBooking, "current");
                            },
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
