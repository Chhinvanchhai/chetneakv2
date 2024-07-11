import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'models/category.dart';

class HomeController extends GetxController {
  var listCategories = <CategoryModel>[].obs;
  var genreItems = [].obs;
  var itemsCat = [].obs;
  var page = 1, totalPage = 1;
  var pageSize = 15;
  var loading = false;
  var bestView = [].obs;
  var slideItem = [].obs;

  final catModal = CategoryModel.categoryList;

  bool isLoadMore = true;
  RxBool isLoading = false.obs;
  final scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    listCategories.value = CategoryModel.categoryList;
  }
}
