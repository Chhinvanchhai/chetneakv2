import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:chetneak_v2/controllers/helper_controller.dart';
import 'package:chetneak_v2/models/hotel_list_data.dart';
import 'package:chetneak_v2/screens/widget/widgets.dart';
import 'package:chetneak_v2/themes/app_theme.dart';
import '../../controllers/resort_controller.dart';
import '../hotel_booking/smooth_star_rating.dart';

class HotelMaps extends StatefulWidget {
  @override
  _HotelMapsState createState() => _HotelMapsState();
}

class _HotelMapsState extends State<HotelMaps> {
  // Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController; //contrller for Google map
  Helper helper = Get.find();
  final ResortController resortController = Get.find();

  static LatLng _center = LatLng(11.5630852, 104.8549773);
  late BitmapDescriptor pinLocationIcon;
  final Set<Marker> markers = new Set();
  double _pinPillPosition = -200;
  LatLng _lastMapPosition = _center;

  HotelListData resorts = HotelListData(
    imagePath: '',
    titleTxt: '',
    subTxt: '',
    dist: 0,
    rating: 0,
  );
  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed() {
    setState(() {});
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    await Future.delayed(const Duration(seconds: 4), () {
      resortController.resortList.asMap().forEach((index, resort) => {
            mapController.showMarkerInfoWindow(MarkerId(LatLng(
                    resortController.resortList[index].location.latitude,
                    resortController.resortList[index].location.longitude)
                .toString())),
            if (index == 0)
              {
                mapController.showMarkerInfoWindow(MarkerId(LatLng(
                        resortController.resortList[0].location.latitude,
                        resortController.resortList[0].location.longitude)
                    .toString())),
              }

            // mapController.showMarkerInfoWindow(MarkerId(
            //     LatLng(resort.location.latitude, resort.location.longitude)
            //         .toString()))
          });
    });
  }

  void getLatLong() async {
    var currentLocation = await helper.determinePosition();
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 0.5),
      'assets/images/point.png',
    );
    setState(() {
      _center = LatLng(currentLocation.latitude, currentLocation.longitude);
      markers.add(Marker(
          //add third marker
          markerId: MarkerId(currentLocation.longitude.toString()),
          position: LatLng(currentLocation.latitude,
              currentLocation.longitude), //position of marker
          infoWindow: InfoWindow(
            //popup info
            title: 'My Current Location ',
            snippet: 'My Current Location ',
          ),
          icon: pinLocationIcon,
          onTap: () {
            //this is what you're looking for!
          } //Icon for Marker
          ));
    });

    print("current long=${currentLocation.longitude.toString()}");
    print("current lat=${currentLocation.latitude.toString()}");
  }

  onResorts(resort) {
    // Get.toNamed('/hoteldetial?uid=${resort.uid}&name=${resort.titleTxt}');
    print("resort=====${resort.titleTxt}");
    setState(() {
      _pinPillPosition = 0;
      resorts = resort;
    });
  }

  void hotelList() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 0.5),
      'assets/images/point.png',
    );
    resortController.resortList.forEach((resort) => {
          setState(() {
            markers.add(Marker(
                //add third marker
                markerId: MarkerId(
                    LatLng(resort.location.latitude, resort.location.longitude)
                        .toString()),
                position: LatLng(resort.location.latitude,
                    resort.location.longitude), //position of marker
                icon: BitmapDescriptor.defaultMarker,
                infoWindow: InfoWindow(
                  //popup info
                  title: resorts.perNight.toString(),
                ),
                onTap: () {
                  onResorts(resort);
                } //Icon for Marker
                ));
          })
        });
  }

  void mapClick() {
    setState(() {
      _pinPillPosition = -200;
    });
  }

  @override
  void initState() {
    hotelList();
    getLatLong();
    super.initState();
  }

  void ChangeStare(rate) {
    print("rate===$rate");
    setState(() {
      resorts.rating = rate;
    });
  }

  void onDetial() {
    Get.toNamed('/hoteldetial', arguments: resorts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearly Place'),
        backgroundColor: Colors.green[700],
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 14.0,
              ),
              markers: markers,
              onTap: (latlang) {
                mapClick();
              },
              mapType: _currentMapType,
              onCameraMove: _onCameraMove,
              onMapCreated: _onMapCreated),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: "btn1",
                    onPressed: _onMapTypeButtonPressed,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.map, size: 36.0),
                  ),
                  SizedBox(height: 16.0),
                  FloatingActionButton(
                    heroTag: "btn2",
                    onPressed: _onAddMarkerButtonPressed,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.add_location, size: 36.0),
                  ),
                ],
              ),
            ),
          ),
          AnimatedPositioned(
              bottom: _pinPillPosition,
              right: 0,
              left: 0,
              duration: Duration(milliseconds: 200),
              child: Container(
                padding: EdgeInsets.all(20),
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          child: AspectRatio(
                            aspectRatio: 2,
                            child: resorts.imagePath != ''
                                ? Image.network(
                                    resorts.imagePath,
                                    fit: BoxFit.cover,
                                  )
                                : SizedBox(),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              H1(title: resorts.titleTxt),
                              Row(
                                children: [
                                  H1(
                                    title: resorts.perNight.toString() + '\$',
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  H3(
                                    title: 'per night',
                                    size: 18,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: <Widget>[
                          SmoothStarRating(
                            rating: resorts.rating,
                            onRatingChanged: (value) => ChangeStare(value),
                            size: 20,
                            color: AppTheme.buildLightTheme().primaryColor,
                            borderColor:
                                AppTheme.buildLightTheme().primaryColor,
                          ),
                          Text(
                            ' ${resorts.reviews} Reviews',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.withOpacity(0.8)),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Text(
                              '${resorts.dist.toStringAsFixed(1)} km to city',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.withOpacity(0.8)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Botton(
                        text: 'book_now',
                        onPress: () {
                          onDetial();
                        })
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
