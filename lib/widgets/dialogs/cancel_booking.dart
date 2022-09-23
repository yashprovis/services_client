import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:services_client/provider/booking_provider.dart';
import 'package:services_client/services/booking_service.dart';

import '../../models/booking_model.dart';
import '../sc_text.dart';

Future cancelDialog(BuildContext context, Booking booking, String type) async {
  Booking? newBooking;
  await showDialog(
      context: context,
      builder: (builder) {
        BookingProvider bookingProvider = Provider.of<BookingProvider>(context);
        return Dialog(
            child: SizedBox(
          width: 340,
          height: 195,
          child: Stack(
            children: [
              Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ScText(
                        "Are you Sure?",
                        size: 21,
                      ),
                      ScText(
                          "Cancel actions cannot be reversed. Do you wish to cancel the booking?",
                          size: 15,
                          color: Colors.grey[800]),
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                            onPressed: () async {
                              await BookingService()
                                  .updateBooking(
                                      booking.id,
                                      "cancelled",
                                      booking.workerId,
                                      booking.customerId,
                                      type == "current"
                                          ? bookingProvider.socket
                                          : null)
                                  .then((value) {
                                if (value != null) {
                                  newBooking = value;
                                  if (type == "current") {
                                    bookingProvider.setBooking(null);
                                    bookingProvider.resetBooking();
                                  }
                                  Navigator.of(context).pop();
                                }
                              });
                            },
                            child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 0),
                                child: ScText(
                                  "Cancel",
                                  color: Colors.white,
                                  size: 15,
                                  //   weight: FontWeight.w100,
                                ))),
                      )
                    ],
                  )),
              Positioned(
                  right: 16,
                  top: 12,
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.close)))
            ],
          ),
        ));
      });
  return newBooking;
}
