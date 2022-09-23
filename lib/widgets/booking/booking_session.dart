import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:services_client/constants.dart';
import 'package:services_client/widgets/dialogs/cancel_booking.dart';

import '../../helpers/methods.dart';
import '../../models/booking_model.dart';
import '../../provider/booking_provider.dart';
import '../../services/booking_service.dart';
import '../sc_button.dart';
import '../sc_text.dart';

class BookingSession extends StatefulWidget {
  final Booking booking;
  const BookingSession({super.key, required this.booking});

  @override
  State<BookingSession> createState() => _BookingSessionState();
}

class _BookingSessionState extends State<BookingSession> {
  @override
  Widget build(BuildContext context) {
    BookingProvider bookingProvider = Provider.of<BookingProvider>(context);

    return SizedBox(
      height: MediaQuery.of(context).size.height - 150,
      child: Stack(
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // SizedBox(height: 40),
            Container(
              color: primaryColor,
              margin: const EdgeInsets.only(bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: const ScText(
                "Enjoy the service, you will be notified when our professionals are done.",
                align: TextAlign.center,
                color: Colors.white,
                height: 1.5,
                spacing: 1,
                size: 20,
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(CupertinoIcons.info,
                            color: primaryColor, size: 20),
                        const SizedBox(width: 10),
                        ScText(
                          "Booking Id: ${widget.booking.id}",
                          align: TextAlign.center,
                          color: Colors.black87,
                          height: 1.5,
                          spacing: 1,
                          size: 17,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          const Icon(CupertinoIcons.person,
                              color: primaryColor, size: 20),
                          const SizedBox(width: 10),
                          ScText(
                            "Professional: ${widget.booking.workerName}",
                            align: TextAlign.center,
                            color: Colors.black87,
                            height: 1.5,
                            spacing: 1,
                            size: 17,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(CupertinoIcons.phone,
                            color: primaryColor, size: 20),
                        const SizedBox(width: 10),
                        ScText(
                          "Phone: ${widget.booking.workerPhone}",
                          align: TextAlign.center,
                          color: Colors.black87,
                          height: 1.5,
                          spacing: 1,
                          size: 17,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          const Icon(CupertinoIcons.time,
                              color: primaryColor, size: 20),
                          const SizedBox(width: 10),
                          ScText(
                            "Duration:${durationToString(widget.booking.bookingDuration)} hr.",
                            align: TextAlign.center,
                            color: Colors.black87,
                            height: 1.5,
                            spacing: 1,
                            size: 17,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(CupertinoIcons.doc_plaintext,
                            color: primaryColor, size: 20),
                        const SizedBox(width: 10),
                        ScText(
                          "Total: ₹${widget.booking.bookingTotal}.00",
                          align: TextAlign.center,
                          color: primaryColor,
                          height: 1.5,
                          size: 18,
                        ),
                      ],
                    )
                  ],
                )),
          ]),
          Positioned(
              bottom: 0,
              right: 20,
              child: FloatingActionButton(
                onPressed: () {
                  cancelDialog(context, widget.booking, "current");
                },
                backgroundColor: Colors.red[300],
                child: const Icon(Icons.close),
              ))
        ],
      ),
    );
  }
}
