import 'package:chetneak_v2/screens/home_screen/catergory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'categories.dart';
import 'category_list_view.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.menu, color: Colors.black),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.black),
                onPressed: () {},
              ),
              Positioned(
                right: 11,
                top: 11,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    '2',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Explore the',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              Text(
                'Beautiful world!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search places',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Icon(Icons.filter_list, color: Colors.orange),
                ],
              ),
              SizedBox(height: 8),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     CategoryCard(title: 'Sky Tour', icon: Icons.air),
              //     CategoryCard(title: 'Desert', icon: Icons.terrain),
              //     CategoryCard(title: 'Beach', icon: Icons.beach_access),
              //   ],
              // ),
              // SizedBox(height: 8),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     CategoryCard(title: 'Sky Tour', icon: Icons.air),
              //     CategoryCard(title: 'Desert', icon: Icons.terrain),
              //     CategoryCard(title: 'Beach', icon: Icons.beach_access),
              //   ],
              // ),
              HomeCategory(),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Travel Places',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'View All',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    TravelPlaceCard(
                      imageUrl:
                          'https://service.chetneak.com/api/v1/media/uploads_images_books_1708009054354-145767169.jpeg',
                      placeName: 'Thiksey Monastery',
                      location: 'Ladakh, India',
                    ),
                    TravelPlaceCard(
                      imageUrl:
                          'https://service.chetneak.com/api/v1/media/uploads_images_books_1708009054354-145767169.jpeg',
                      placeName: 'Thiksey Monastery',
                      location: 'Ladakh, India',
                    ),
                    TravelPlaceCard(
                      imageUrl:
                          'https://service.chetneak.com/api/v1/media/uploads_images_books_1708009054354-145767169.jpeg',
                      placeName: 'Thiksey Monastery',
                      location: 'Ladakh, India',
                    ),
                    TravelPlaceCard(
                      imageUrl:
                          'https://service.chetneak.com/api/v1/media/uploads_images_books_1708009054354-145767169.jpeg',
                      placeName: 'Thiksey Monastery',
                      location: 'Ladakh, India',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;

  CategoryCard({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.orange),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(color: Colors.orange),
          ),
        ],
      ),
    );
  }
}

class TravelPlaceCard extends StatelessWidget {
  final String imageUrl;
  final String placeName;
  final String location;

  TravelPlaceCard({
    required this.imageUrl,
    required this.placeName,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      width: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Image.network(
              imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  placeName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  location,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
