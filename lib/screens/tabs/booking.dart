import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:services_client/widgets/sc_button.dart';

import 'package:services_client/widgets/sc_text.dart';

import '../../constants.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: ListView(padding: const EdgeInsets.only(top: 10), children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: ScText(
                  "Next Booking",
                  size: 20,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: GestureDetector(
                  onTap: () {
                    // Navigator.of(context).pushNamed(InvoicePreview.routeName,
                    //     arguments: "SW000${index + 1}");
                  },
                  child: Card(
                    elevation: 4,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const ScText("Booking No: SW000${0 + 1}",
                                  size: 14, color: primaryColor),
                              Row(
                                children: [
                                  GestureDetector(
                                      // onTap: () => downloadPdf(),
                                      child: const Icon(Icons.timer_outlined,
                                          size: 22)),
                                  const SizedBox(width: 6),
                                  const Text(
                                      //   onTap: () => sharePdf(),
                                      "1.5 hrs"),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: ScText(
                                "Date: ${DateFormat("MMM dd,yy hh:mm a").format(DateTime.now().add(const Duration(minutes: (0 + 1) * 2000)))}",
                                size: 12,
                                color: Colors.grey),
                          ),
                          const ScText("Customer: Ravi Provis", size: 14),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: ScText("Amount: ₹4,000.00", size: 14),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2, bottom: 2),
                            child: ScText(
                                "Address: 503, Signature Tower, Tonk Phatak, Jaipur - 302006",
                                size: 12,
                                color: Colors.grey[600]),
                          ),
                          const Divider(),
                          ScButton(
                              text: "OTP: 5678",
                              func: () {},
                              height: 40,
                              isLoading: false),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  "Contact",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 20, right: 4),
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ])));
  }
}
