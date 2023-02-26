import 'package:flutter/material.dart';
import 'package:chetneak_v2/screens/widget/h2.dart';
import 'package:chetneak_v2/themes/app_theme.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  var selectedCat = 0;
  void setSelected(index) {
    setState(() {
      selectedCat = index;
    });
  }

  List listCategories = [
    'apartment',
    'home',
    'villa',
    'hotel',
    'resort',
    'history',
    'mountain',
    'island'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.0),
      height: 75,
      width: double.maxFinite,
      child: ListView.builder(
          itemCount: listCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) => InkWell(
                onTap: () => setSelected(index),
                child: Container(
                  margin: EdgeInsets.only(right: 12.0),
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  decoration: BoxDecoration(
                      color: index == selectedCat ? AppTheme.primary : null,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.withOpacity(0.3))),
                  child: Center(
                      child: H2(
                    title: listCategories[index],
                    color: index == selectedCat ? Colors.white : Colors.black,
                  )),
                ),
              ))),
    );
  }
}
