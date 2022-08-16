import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart' as intl;
import 'package:services_client/widgets/sc_text.dart';
import '../models/review_model.dart';

class RatingsScreen extends StatelessWidget {
  static const routeName = "/ratings";
  RatingsScreen({Key? key}) : super(key: key);
  List<Reviews> reviews = [
    Reviews(
        id: "R001",
        title: "Great Booking, loved it",
        description:
            "I really enjoyed my experience, Thank you so much. OK bye.",
        date: DateTime.now(),
        rating: 4.5),
    Reviews(
        id: "R002",
        title: "Great Booking, loved it",
        description:
            "I really enjoyed my experience, Thank you so much. OK bye.",
        date: DateTime.now(),
        rating: 4.5),
    Reviews(
        id: "R003",
        title: "Great Booking, loved it",
        description:
            "I really enjoyed my experience, Thank you so much. OK bye.",
        date: DateTime.now(),
        rating: 4.5),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 24,
                      //color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const ScText(
                    "Reviews",
                    // color: Colors.white,
                    size: 20,
                    //   weight: FontWeight.w500,
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 2),
              height: MediaQuery.of(context).size.height - 70,
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 16),
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: const BorderSide(
                                color: Color(0xFFABB2BA), width: .4),
                            top: index == 0
                                ? const BorderSide(
                                    color: Color(0xFFABB2BA), width: .3)
                                : const BorderSide(
                                    width: 0.1, color: Colors.white))),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(top: 2.0, bottom: 2),
                            child: CircleAvatar(
                              radius: 30,
                              child: Text(
                                "YA",
                                // args['reviews'][index]['node']['user']
                                //             ['name']
                                //         .substring(0, 1) +
                                //     args['reviews'][index]['node']['user']
                                //             ['name']
                                //         .substring(
                                //             args['reviews'][index]['node']
                                //                     ['user']['name']
                                //                 .indexOf(' '),
                                //             args['reviews'][index]['node']
                                //                         ['user']['name']
                                //                     .indexOf(' ') +
                                //                 2),
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    letterSpacing: -.8,
                                    color: Colors.white),
                              ),
                            )
                            // : CircleAvatar(
                            //     radius: 30,
                            //     backgroundImage: NetworkImage(
                            //         args['reviews'][index]['node']['user']
                            //                             ['userProfiles']
                            //                         ['edges']
                            //                     [0]['node']
                            //                 ['profileImagesByProfileId']
                            //             ['edges'][0]['node']['url']),
                            //   ),
                            ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 105,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Yash",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    intl.DateFormat.yMMMd()
                                        .format(reviews[index].date),
                                    style: const TextStyle(
                                        color: Color(0xFF9FA8B0), fontSize: 14),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 3.0),
                              child: RatingBar(
                                initialRating: reviews[index].rating,
                                minRating: 0,
                                glow: false,
                                ignoreGestures: true,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemSize: 18,
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
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: .0),
                                onRatingUpdate: (rating) {},
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 2),
                              padding: const EdgeInsets.only(right: 10),
                              width: MediaQuery.of(context).size.width - 115,
                              child: Text(
                                reviews[index].description,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Color(0xFF707070), fontSize: 14),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
