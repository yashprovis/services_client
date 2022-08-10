import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:services_client/provider/tabs_provider.dart';

import 'tabs/booking.dart';
import 'tabs/booking_history.dart';
import 'tabs/home.dart';
import 'tabs/profile.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = "/tabs";
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Widget> screens = [
    const HomeScreen(),
    const BookingScreen(),
    const BookingHistoryScreen(),
    const ProfileScreen()
  ];

  // @override
  // void initState() {
  //   init();
  //   super.initState();
  // }

  // init() async {
  //   UserProvider userProvider =
  //       Provider.of<UserProvider>(context, listen: false);
  //   OrderProvider orderProvider =
  //       Provider.of<OrderProvider>(context, listen: false);
  //   await userProvider.refreshUser();
  //   await orderProvider.fetchCurrentOrders();
  // }

  @override
  Widget build(BuildContext context) {
    TabsProvider tabs = Provider.of<TabsProvider>(context);
    return Scaffold(
        body: screens[tabs.index],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabs.index,
            onTap: (index) {
              tabs.changeIndex(index);
            },
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.storefront_sharp), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag_outlined), label: ""),
            ]));
  }
}
