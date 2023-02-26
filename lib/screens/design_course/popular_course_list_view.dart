import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chetneak_v2/models/hotel_list_data.dart';

import '../../controllers/resort_controller.dart';
import 'design_course_app_theme.dart';
import 'models/category.dart';

class PopularCourseListView extends StatefulWidget {
  const PopularCourseListView({required this.callBack, Key? key})
      : super(key: key);

  final Function(HotelListData) callBack;

  @override
  State<PopularCourseListView> createState() => _PopularCourseListViewState();
}

class _PopularCourseListViewState extends State<PopularCourseListView>
    with TickerProviderStateMixin {
  late final AnimationController animationController;
  final ResortController resortController = Get.put(ResortController());

  @override
  void initState() {
    super.initState();
    resortController.getResortList(resortController.distances);
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Obx(() => GridView(
              padding: const EdgeInsets.all(3),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 0.8,
              ),
              children: List<Widget>.generate(
                resortController.resortList.length,
                (int index) {
                  final int count = resortController.resortList.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ),
                  );
                  animationController.forward();
                  return CategoryView(
                    callback: () {
                      widget.callBack(resortController.resortList[index]);
                    },
                    hotelData: resortController.resortList[index],
                    animation: animation,
                    animationController: animationController,
                  );
                },
              ),
            )));
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
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, _) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 40 * (1.0 - animation.value), 0.0),
            child: Container(
              height: 80,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  child: Container(
                    color: Colors.red,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.0)),
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
                                                color: DesignCourseAppTheme
                                                    .darkerText,
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
                          padding: const EdgeInsets.only(
                              top: 10, right: 16, left: 16),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: DesignCourseAppTheme.grey
                                        .withOpacity(0.2),
                                    blurRadius: 6.0),
                              ],
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
            ),
          ),
        );
      },
    );
  }
}
