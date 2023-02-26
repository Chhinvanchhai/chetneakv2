import 'package:chetneak_v2/constants.dart';
import 'package:flutter/material.dart';
import 'package:chetneak_v2/screens/home_screen/HomeScreen.dart';
import 'package:chetneak_v2/screens/hotel_booking/hotel_home_screen.dart';
import 'package:chetneak_v2/screens/profile.dart';
import '../chats/chats_screen.dart';
import '../messages/message_screen.dart';

class BottomTabs extends StatefulWidget {
  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    // HomeScreen(),
    HomeScreens(),
    ChatsScreen(),
    // HotelHomeScreen(),
    Scaffold(),
    Profile(),
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
        onPressed: () {},
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
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
        BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            radius: 14,
            backgroundImage: AssetImage("assets/images/user_2.png"),
          ),
          label: "Profile",
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
