import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chetneak_v2/controllers/helper_controller.dart';
import 'package:chetneak_v2/models/User.dart';
import 'package:chetneak_v2/models/hotel_list_data.dart';

class ResortController extends GetxController {
  var users = <Users>[].obs;
  double distances = 50;
  final scrollController = ScrollController();
  var page = 1;
  bool isLoadMore = false;
  var storId = '';
  List<DocumentSnapshot>? documentList;
  Helper helper = Get.find();
  List resortList = [].obs;
  var totalHotel = 0.obs;
  // List resortDefaluData = [
  //   ChatMessage(
  //     text: "Hi Sajol,",
  //     messageType: ChatMessageType.text,
  //     messageStatus: MessageStatus.viewed,
  //     isSender: false,
  //   ),
  //
  // ].obs;
  @override
  void onInit() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        isLoadMore = true;
        page += 1;
        print("Reach Bottom Of screen!!!!!!!!!!====> $page");
        // getResortListMore();
      }
    });
    super.onInit();
  }

  getResortList(dist) async {
    // var position = await helper.determinePosition();
    print("dist============${dist}");
    var position = {'latitude': 11.5565428, 'longitude': 104.8804897};
    double? lat = position['latitude'];
    double? lon = position['longitude'];
    double distance = dist * 0.000621371;
    double lowerLat = position['latitude']! - (lat! * distance);
    double lowerLon = position['longitude']! - (lon! * distance);
    double greaterLat = position['latitude']! + (lat * distance);
    double greaterLon = position['longitude']! + (lon * distance);
    GeoPoint lesserGeopoint = GeoPoint(lowerLat, lowerLon);
    GeoPoint greaterGeopoint = GeoPoint(greaterLat, greaterLon);
    resortList = [].obs;
    FirebaseFirestore.instance
        .collection('resorts')
        .where("position", isGreaterThan: lesserGeopoint)
        .where("position", isLessThan: greaterGeopoint)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        return;
      }
      documentList = querySnapshot.docs;
      querySnapshot.docs.forEach((doc) {
        var distance = helper.calculateDistance(
            position['latitude'],
            position['longitude'],
            doc['position'].latitude,
            doc['position'].longitude);
        resortList.add(HotelListData(
            imagePath: doc.data().toString().contains('images')
                ? doc['images'][0]
                : 'https://firebasestorage.googleapis.com/v0/b/nearyou-49d62.appspot.com/o/resorts%2Fresort1611192307729_6L9fX7OKKtZVYR14hS0BvuTFuHt2_0.jpg?alt=media&token=0a98afdd-18d3-4093-a97a-fa3f59f402fd',
            titleTxt: doc['name'],
            subTxt: doc['location'],
            uid: doc['uid'],
            dist: distance,
            rating: 4.4,
            location: doc['position']));
      });
      totalHotel.value = resortList.length;
    });
  }

  getResortListMore() async {
    // var position = await helper.determinePosition();
    var position = {'latitude': 11.5565428, 'longitude': 104.8804897};
    double? lat = position['latitude'];
    double? lon = position['longitude'];
    double distance = 131 * 0.000621371;
    double lowerLat = position['latitude']! - (lat! * distance);
    double lowerLon = position['longitude']! - (lon! * distance);
    double greaterLat = position['latitude']! + (lat * distance);
    double greaterLon = position['longitude']! + (lon * distance);
    GeoPoint lesserGeopoint = GeoPoint(lowerLat, lowerLon);
    GeoPoint greaterGeopoint = GeoPoint(greaterLat, greaterLon);
    if (documentList != null) {
      FirebaseFirestore.instance
          .collection('resorts')
          .where("position", isGreaterThan: lesserGeopoint)
          .where("position", isLessThan: greaterGeopoint)
          // .startAfterDocument(documentList![documentList!.length - 1])
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isEmpty) {
          print("=========EMPTY=======");
          return;
        }
        documentList = querySnapshot.docs;
        querySnapshot.docs.forEach((doc) {
          var distance = helper.calculateDistance(
              position['latitude'],
              position['longitude'],
              doc['position'].latitude,
              doc['position'].longitude);

          resortList.add(HotelListData(
            imagePath: doc.data().toString().contains('images')
                ? doc['images'][0]
                : 'https://firebasestorage.googleapis.com/v0/b/nearyou-49d62.appspot.com/o/resorts%2Fresort1611192307729_6L9fX7OKKtZVYR14hS0BvuTFuHt2_0.jpg?alt=media&token=0a98afdd-18d3-4093-a97a-fa3f59f402fd',
            titleTxt: doc['name'],
            subTxt: doc['location'],
            dist: distance,
            rating: 4.4,
          ));
        });
      });
    }
  }
}
