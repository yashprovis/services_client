import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../widgets/sc_text.dart';

class HelpSupport extends StatefulWidget {
  static const routeName = "/helpSupport";
  const HelpSupport({Key? key}) : super(key: key);

  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  List<Map<String, dynamic>> items = List.generate(
      5,
      (index) => {
            'id': index,
            'title': 'Item $index',
            'description':
                'This is the description of the item $index. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            'isExpanded': false
          });

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
                    "Help and Support",
                    // color: Colors.white,
                    size: 20,
                    //   weight: FontWeight.w500,
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: ScText(
                "FAQ",
                color: primaryColor,
                size: 40,
                weight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            ExpansionPanelList(
              elevation: 3,
              // Controlling the expansion behavior
              expansionCallback: (index, isExpanded) {
                setState(() {
                  items[index]['isExpanded'] = !isExpanded;
                });
              },
              animationDuration: const Duration(milliseconds: 600),
              children: items
                  .map(
                    (item) => ExpansionPanel(
                      canTapOnHeader: true,
                      backgroundColor: item['isExpanded'] == true
                          ? secondaryLight.withOpacity(.3)
                          : Colors.white,
                      headerBuilder: (_, isExpanded) => Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30),
                          child: Text(
                            item['title'],
                            style: const TextStyle(fontSize: 20),
                          )),
                      body: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
                        child: Text(item['description']),
                      ),
                      isExpanded: item['isExpanded'],
                    ),
                  )
                  .toList(),
            ),
          ]),
        ));
  }
}
