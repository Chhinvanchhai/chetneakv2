import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chetneak_v2/models/hotel_list_data.dart';

import '../../controllers/resort_controller.dart';
import '../design_course/design_course_app_theme.dart';
import '../design_course/models/category.dart';

class PopularCourseListView extends StatefulWidget {
  const PopularCourseListView({required this.callBack, Key? key})
      : super(key: key);

  final Function(HotelListData) callBack;

  @override
  State<PopularCourseListView> createState() => _PopularCourseListViewState();
}

class _PopularCourseListViewState extends State<PopularCourseListView> {
  late final AnimationController animationController;
  final ResortController resortController = Get.put(ResortController());

  @override
  void initState() {
    super.initState();
    resortController.getResortList(resortController.distances);
    print("==================datalist=================");
    print(resortController.resortList);
    print("================== end list =================");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 1),
        child: Obx(() => ListView.builder(
            itemCount: resortController.resortList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 300,
                margin: EdgeInsets.all(12.0),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    offset: const Offset(2, 2),
                    spreadRadius: 3,
                  )
                ]),
              );
            })));
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView(
      {required this.hotelData,
      required this.animationController,
      required this.animation,
      required this.callback,
      Key? key})
      : super(key: key);

  final VoidCallback callback;
  final HotelListData hotelData;
  final AnimationController animationController;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          child: Container(
            height: 80,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Expanded(
                      child: Ink(
                        decoration: const BoxDecoration(
                          color: Color(0xFFF8FAFB),
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          // border: Border.all(
                          //     color: DesignCourseAppTheme.notWhite),
                        ),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, left: 16, right: 16),
                                    child: Text(
                                      hotelData.titleTxt,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        letterSpacing: 0.27,
                                        color: DesignCourseAppTheme.darkerText,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 16, left: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                    ),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                      child: AspectRatio(
                          aspectRatio: 1.28,
                          child: Image.network(hotelData.imagePath)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
