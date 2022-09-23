import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:services_client/provider/user_provider.dart';

import '../../helpers/methods.dart';
import '../../models/booking_model.dart';
import '../../services/user_service.dart';
import '../sc_textfield.dart';

class AddRatingTile extends StatefulWidget {
  final Booking booking;
  final int? index;
  final void Function(Map rating, int index)? func;
  const AddRatingTile(
      {super.key,
      required this.booking,
      required this.func,
      required this.index});

  @override
  State<AddRatingTile> createState() => _AddRatingTileState();
}

class _AddRatingTileState extends State<AddRatingTile> {
  TextEditingController reviewController = TextEditingController();
  Map rating = {};

  @override
  void initState() {
    UserProvider provider = Provider.of<UserProvider>(context, listen: false);
    rating = {
      "desc": "",
      "stars": 1.0,
      "userId": widget.booking.customerId,
      "userImage": provider.getUser.image,
      "userName": provider.getUser.name,
      "ratingDate": DateTime.now().toIso8601String(),
      "workerId": widget.booking.workerId,
      "bookingId": widget.booking.id
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RatingBar(
                  initialRating: rating["stars"],
                  minRating: 1,
                  glow: false,
                  direction: Axis.horizontal,
                  itemSize: widget.index == null ? 34 : 28,
                  unratedColor: const Color(0xFF9FA8B0),
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                      empty: const Icon(
                        Icons.star_border_outlined,
                        color: Colors.amber,
                      ),
                      half: const Icon(
                        Icons.star_half_outlined,
                        color: Colors.amber,
                      ),
                      full: const Icon(
                        Icons.star,
                        color: Colors.amber,
                      )),
                  itemPadding: const EdgeInsets.symmetric(horizontal: 1),
                  onRatingUpdate: (r) {
                    rating["stars"] = r;
                    setState(() {});
                  }),
              Padding(
                  padding: EdgeInsets.only(right: 5.0),
                  child: GestureDetector(
                      onTap: () async {
                        if (reviewController.text.trim().isNotEmpty) {
                          rating["desc"] = reviewController.text;
                          dynamic data =
                              await UserService().rateProduct(rating: rating);
                          if (data == true) {
                            if (widget.index != null) {
                              widget.func!(rating, widget.index!);
                            } else {
                              widget.func!(rating, 0);
                            }
                          } else {
                            showSnack(
                                context: context,
                                message:
                                    "Adding review failed. Try again later");
                          }
                        }
                      },
                      child: Icon(Icons.done,
                          color: Colors.black,
                          size: widget.index == null ? 30 : null))),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: ScTextField(
                  controller: reviewController,
                  maxLines: 3,
                  hintText: "Review ",
                  isPassword: false))
        ]);
  }
}
