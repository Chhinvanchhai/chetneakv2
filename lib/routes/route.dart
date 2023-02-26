import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:chetneak_v2/screens/hotel_booking/hotel_detail.dart';
import 'package:chetneak_v2/screens/maps/hotel_map.dart';
import '../screens/auth/signin_or_signup_screen.dart';
import '../screens/chats/chats_screen.dart';
import '../screens/hotel_booking/hotel_home_screen.dart';
import '../screens/navigation/buttom_tabs.dart';
import '../screens/settings.dart';
import '../screens/welcome/start_screen.dart';

List<GetPage> routes = [
  //Simple GetPage
  GetPage(
    name: '/',
    page: () => Started(),
  ),
  GetPage(
    name: '/login',
    page: () => LoginScreen(),
  ),
  GetPage(
      name: '/home', page: () => BottomTabs(), middlewares: [AuthMiddleware()]),
  GetPage(
      name: '/message',
      page: () => ChatsScreen(),
      middlewares: [AuthMiddleware()]),
  GetPage(
      name: '/settings',
      page: () => SettingsScreen(),
      middlewares: [AuthMiddleware()]),
  GetPage(
      name: '/findplace',
      page: () => HotelHomeScreen(),
      middlewares: [AuthMiddleware()]),
  GetPage(
      name: '/hoteldetial',
      page: () => HotelDetial(),
      middlewares: [AuthMiddleware()]),
  GetPage(
      name: '/maps', page: () => HotelMaps(), middlewares: [AuthMiddleware()]),
  // GetPage with custom transitions and bindings
];

class AuthMiddleware extends GetMiddleware {
  static bool checkUser() {
    final box = GetStorage();
    // box.write('user', null);
    var user;
    if (box.read('user') != null) {
      user = box.read('user') as Map;
      print(user);
      return true;
    }
    return false;
  }

  RouteSettings? redirect(String? route) {
    return !checkUser() ? RouteSettings(name: "/") : null;
  }
}
