import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:services_client/screens/worker_details.dart';

import '../constants.dart';
import '../dummt.dart';
import '../widgets/sc_button.dart';
import '../widgets/sc_text.dart';

class WorkerList extends StatefulWidget {
  static const routeName = "/workerList";
  final String caetgoryId;
  const WorkerList({Key? key, required this.caetgoryId}) : super(key: key);

  @override
  State<WorkerList> createState() => _WorkerListState();
}

class _WorkerListState extends State<WorkerList> {
  List sortItems = ['Lowest Price', 'Highest Price'];
  String? selectedSortItem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.only(top: 56),
            child: ListView(padding: EdgeInsets.zero, children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
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
                      "Top Professionals",
                      // color: Colors.white,
                      size: 20,
                      //   weight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                                customButton: Container(
                                  height: 40,
                                  width:
                                      MediaQuery.of(context).size.width * .5 -
                                          30,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      // border: Border.all(),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        selectedSortItem ?? 'Sort ',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: Colors.white),
                                      ),
                                      const Icon(
                                          CupertinoIcons.arrow_up_arrow_down,
                                          color: Colors.white,
                                          size: 20)
                                    ],
                                  ),
                                ),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                value: selectedSortItem,
                                onChanged: (value) {
                                  // setState(() {
                                  //   products = null;
                                  // });
                                  // if (value == "Highest Price") {
                                  //   fetchProducts(true);
                                  // } else {
                                  //   fetchProducts(false);
                                  // }
                                  // selectedSortItem = value as String;
                                  // setState(() {});
                                },
                                // dropdownPadding:
                                //     EdgeInsets.only(left: 20),

                                items: sortItems
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList()),
                          )),
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * .5 - 30,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 15),
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: primaryColor),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            ScText(
                              'Filter ',
                              size: 14,
                              color: primaryColor,
                              weight: FontWeight.w500,
                            ),
                            Icon(CupertinoIcons.slider_horizontal_3,
                                color: primaryColor)
                          ],
                        ),
                      ),
                    ],
                  )),
              ListView.builder(
                  padding: const EdgeInsets.all(20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (ctx, i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                WorkerDetails.routeName,
                                arguments: i.toString());
                          },
                          tileColor: Colors.grey[200],
                          leading: Container(
                            width: 78,
                            height: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage(servicesList[i]["image"]!))),
                          ),
                          title: const ScText("Elon Musk", size: 14),
                          trailing: ScButton(
                              text: "Book",
                              func: () {
                                Navigator.of(context).pushNamed(
                                    WorkerList.routeName,
                                    arguments: "id");
                              },
                              textSize: 14,
                              isLoading: false,
                              width: 60,
                              height: 30),
                          subtitle: const ScText("Head Chef", size: 12)),
                    );
                  }),
            ])));
  }
}
