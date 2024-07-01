import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chetneak_v2/screens/widget/h1.dart';
import 'package:chetneak_v2/screens/widget/h3.dart';
import 'package:chetneak_v2/screens/widget/title.dart';
import 'package:chetneak_v2/themes/app_theme.dart';
import 'category_list_view.dart';
import '../design_course/course_info_screen.dart';
import 'PopularCourseListView.dart';
import 'categories.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({Key? key}) : super(key: key);

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      textStyle: TextStyle(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          getAppBarUI(),
          SizedBox(
            height: 12,
          ),
          Expanded(
            child: SingleChildScrollView(
                child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Categories(),
                  getSearchBarUI(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 18.0),
                    child: H1(title: 'category'),
                  ),
                  Categories(),
                  // Container(
                  //   height: 180,
                  //   child: CategoryListView(
                  //     callBack: () {},
                  //   ),
                  // ),
                  Flexible(child: getPopularPalceUI())
                ],
              ),
            )),
          )
        ],
      ),
    );
  }

  // wiget
  Widget getSearchBarUI() {
    return Container(
      padding: EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () => Get.toNamed('/findplace'),
          child: Container(
            height: 46,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
            child: Row(
              children: [
                Expanded(
                  child: H3(title: 'find_place'),
                ),
                const CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.redAccent,
                  child: Icon(Icons.place_outlined),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Phnom Penh',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    letterSpacing: 0.2,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  'Chhin Vanchhai',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                    fontSize: 20.0,
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed("/settings");
            },
            child: SizedBox(
              width: 40,
              height: 40,
              child: Image.asset('assets/images/userImage.png'),
            ),
          )
        ],
      ),
    );
  }

  Widget getPopularPalceUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: PopularCourseListView(
          callBack: (holtelData) =>
              Get.toNamed('/hoteldetial', arguments: holtelData)),
    );
  }

  // void moveTo() {
  //   Navigator.push<dynamic>(
  //     context,
  //     MaterialPageRoute<dynamic>(
  //       builder: (BuildContext context) => const CourseInfoScreen(),
  //     ),
  //   );
  // }
}
