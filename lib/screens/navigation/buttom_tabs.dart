import 'package:chetneak_v2/constants.dart';
import 'package:chetneak_v2/screens/home_screen/index.dart';
import 'package:chetneak_v2/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:chetneak_v2/screens/home_screen/HomeScreen.dart';
import 'package:chetneak_v2/screens/hotel_booking/hotel_home_screen.dart';
import 'package:chetneak_v2/screens/profile.dart';
import 'package:get/get.dart';
import '../chats/chats_screen.dart';

class BottomTabs extends StatefulWidget {
  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    // HomeScreen(),
    HomeScreen(),
    ListChatScreen(),
    HotelHomeScreen(),
    // Scaffold(),
    ProfileScreen(),
    SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: buildAppBar(),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/new-chat');
        },
        backgroundColor: kPrimaryColor,
        child: Icon(
          Icons.person_add_alt_1,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
      },
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.grey),
          activeIcon: Icon(Icons.home, color: Colors.black),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.chat, color: Colors.grey),
          activeIcon: Icon(Icons.chat, color: Colors.black),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: Icon(Icons.hotel, color: Colors.white),
          ),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.favorite, color: Colors.grey),
          activeIcon: Icon(Icons.favorite, color: Colors.black),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person, color: Colors.grey),
          activeIcon: Icon(Icons.person, color: Colors.black),
          label: '',
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text("Chats"),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
      ],
    );
  }
}
