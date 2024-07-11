import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import 'home_controller.dart';

class HomeCategory extends StatelessWidget {
  HomeCategory({
    super.key,
  });

  final HomeController homeController = Get.find();

  get defaultPadding => 30;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      int crossAxisCount = 3;
      double childAspectRatio = 0.7; // Default aspect ratio
      double screenWidth = constraints.maxWidth;

      if (screenWidth >= 1200) {
        crossAxisCount = 6; // Large screen
        childAspectRatio = screenWidth / 1800; // Adjust aspect ratio
      } else if (screenWidth >= 800) {
        crossAxisCount = 6; // Medium
        childAspectRatio = screenWidth / 1800;
      } else {
        crossAxisCount = 3; // Small screen
        childAspectRatio = screenWidth / (screenWidth - 20);
        print("---------------:" + childAspectRatio.toString());
      }
      return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        // height: 220,
        padding: const EdgeInsets.all(20 / 2),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 55, 57, 78),
            borderRadius: BorderRadius.circular(10)),
        child: Obx(() => GridView.count(
              crossAxisCount: crossAxisCount,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              childAspectRatio: childAspectRatio,
              children: homeController.listCategories
                  .map((item) => InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  image: DecorationImage(
                                      image: AssetImage(item.imagePath),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  )
                                ],
                              )),
                        ),
                      ))
                  .toList(),
            )),
      );
    });
  }
}
