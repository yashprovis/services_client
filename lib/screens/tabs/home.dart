import 'package:flutter/material.dart';
import 'package:services_client/dummt.dart';
import 'package:services_client/widgets/sc_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:services_client/widgets/sc_text.dart';

import '../../constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> cityList = [
    "Jaipur",
    "Jodhpur",
    "Mumbai",
    "Pune",
    "Delhi"
  ];
  String? selectedCity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(right: 16, left: 16, top: 10, bottom: 20),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              customButton: Container(
                width: MediaQuery.of(context).size.width,
                height: 48,
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.map_outlined),
                          SizedBox(width: 10),
                          ScText(selectedCity ?? "Pick work location"),
                        ],
                      ),
                      const Icon(Icons.arrow_drop_down, color: primaryColor)
                    ],
                  ),
                ),
              ),
              items: cityList.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: ScText(
                      item,
                      size: 14,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                selectedCity = value as String;
                setState(() {});
              },
              buttonHeight: 40,
              buttonWidth: 240,
              itemHeight: 40,
              itemPadding: EdgeInsets.zero,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ScText(
            "Services",
            size: 20,
            color: Colors.black,
          ),
        ),
        GridView.builder(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: servicesList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 110,
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8),
            itemBuilder: (ctx, i) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: .3),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Container(
                      height: 78,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(servicesList[i]["image"]!))),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ScText(servicesList[i]["name"]!, size: 12),
                    )
                  ],
                ),
              );
            }),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ScText(
            "Top Professionals",
            size: 20,
            color: Colors.black,
          ),
        ),
        ListView.builder(
            padding: const EdgeInsets.all(20),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (ctx, i) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                    tileColor: Colors.grey[200],
                    leading: Container(
                      width: 78,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(servicesList[i]["image"]!))),
                    ),
                    title: const ScText("Elon Musk", size: 14),
                    trailing: ScButton(
                        text: "Book",
                        func: () {},
                        textSize: 14,
                        isLoading: false,
                        width: 60,
                        height: 30),
                    subtitle: const ScText("Head Chef", size: 12)),
              );
            }),
      ],
    ));
  }
}
