import 'dart:async';
import 'dart:convert';

import 'package:coaching_academy/MVVM/views/modules/sporty/dashboard/sporty_dashboard2.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/home/widgets/bottom_sheet_widget.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/home/widgets/search_filter_option.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:coaching_academy/utils/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/ServiceCoachModel.dart';

class SportyHomeMapScreen extends StatefulWidget {
  final bool? isLocationEmpty;
  const SportyHomeMapScreen({super.key, this.isLocationEmpty});

  @override
  SportyHomeMapScreenState createState() => SportyHomeMapScreenState();
}

class SportyHomeMapScreenState extends State<SportyHomeMapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final TextEditingController searchController = TextEditingController();

  CameraPosition? _userCameraPosition;

  List<Marker> myMarkers = [];
  Map<String, ServiceCoachModel> serviceMap = {};
  Map<int, List<ServiceCoachModel>> servicesByCoach = {};

  ServiceCoachModel? selectedService;
  bool showBottomSheet = false;
  List<ServiceCoachModel>? selectedCoachServices;


  List<Marker> markerList = [
    const Marker(
      markerId: MarkerId("First"),
      position: LatLng(37.7749, -122.4194),
      infoWindow: InfoWindow(title: "My Location"),
    ),
  ];
  final FocusNode _focusNode = FocusNode(); // Create a FocusNode
  bool _isFocused = false;
  bool _isFilterOn = false;
  @override
  void dispose() {
    _focusNode.dispose(); // Clean up the focus node when the widget is disposed
    super.dispose();
  }

  @override
  void initState() {
    fetchServicesFromAPI();
    WidgetsBinding.instance.addPostFrameCallback((t) {
      _focusNode.addListener(() {
        setState(() {
          _isFocused = _focusNode.hasFocus; // Check if the TextField is focused
        });
      });
    });
    //myMarkers.addAll(markerList);
    if (kIsWeb) {
      print('Running on Web');
    }

    super.initState();
  }

  Future<Position> getUserLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("error: $error");
    });
    return await Geolocator.getCurrentPosition();
  }

  packData() {
    getUserLocation().then((value) async {
      print("My Location");
      print('${value.longitude},${value.latitude}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.black.withOpacity(0.2),
      //   centerTitle: true,
      //   leading: const SizedBox(),
      //   leadingWidth: 0,
      //   title: const CustomText(
      //     text: "Location",
      //     color: Colors.white,
      //     fontSize: 20,
      //     fontWeight: FontWeight.w600,
      //   ),
      // ),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              // mapType: MapType.hybrid,
                initialCameraPosition: _userCameraPosition ??
                const CameraPosition( // fallback si userPosition pas encore chargé
                    target: LatLng(0, 0),
                zoom: 1,
              ),
              markers: Set<Marker>.of(myMarkers),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            _isFilterOn
                ? Positioned(
                    top: 200,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: const CustomText(
                                  text: "Edit your Search",
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SearchFilterOption(
                            iconPath: AppImages.searchIcon,
                            onPress: () {
                              PageNavigator(ctx: context).nextPage(
                                  page: const SportyDashboard2(
                                indexx: 0,
                              ));
                            },
                            title: "All Disciplines",
                          ),
                          10.verticalSpace,
                          SearchFilterOption(
                            iconPath: AppImages.locationFilledIcon,
                            onPress: () {
                              PageNavigator(ctx: context).nextPage(
                                  page: const SportyDashboard2(
                                indexx: 0,
                              ));
                            },
                            title: "Around Me",
                          ),
                          10.verticalSpace,
                          SearchFilterOption(
                            iconPath: AppImages.timeFilledIcon,
                            onPress: () {
                              PageNavigator(ctx: context).nextPage(
                                  page: const SportyDashboard2(
                                indexx: 0,
                              ));
                            },
                            title: "October 7, 2024",
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
            Positioned(
              top: 150,
              left: 0,
              right: 0,
              child: CustomTextField(
                focusNode: _focusNode,
                iconPath: AppImages.searchIcon,
                iconColor: Colors.black,
                controller: searchController,
                hintText: "Search Here",
                textFontSize: 12,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isFilterOn = !_isFilterOn;
                    });
                  },
                  child: SvgPicture.asset(
                    AppImages.filterIcon,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                fontWeight: FontWeight.w400,
                borderRadius: 10,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 35),
              width: MediaQuery.of(context).size.width,
              // height: 135,
              color: Colors.black.withOpacity(0.8),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Location",
                    isPoppins: true,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomSheet: _isFocused
          ? const SizedBox()
          : showBottomSheet && selectedCoachServices != null
          ? BottomSheetWidget(services: selectedCoachServices!)
          : const SizedBox(),

    );
  }

  Future<void> fetchServicesFromAPI() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final url = Uri.parse('http://localhost:8000/api/coach/services');

    try {
      final userPosition = await getUserLocation();
      _userCameraPosition = CameraPosition(
        target: LatLng(userPosition.latitude, userPosition.longitude),
        zoom: 14,
      );
      final userMarker = Marker(
        markerId: const MarkerId("user_position"),
        position: LatLng(userPosition.latitude, userPosition.longitude),
        infoWindow: const InfoWindow(title: "Moi"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      );
      myMarkers.add(userMarker);



      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final List<dynamic> servicesData = decoded['services'];
        //print('service response api: $servicesData');
        List<ServiceCoachModel> services = servicesData
            .map((item) => ServiceCoachModel.fromJson(item))
            .toList();

        setState(() {
          myMarkers.clear();
          serviceMap.clear();

          /*for (var service in services) {
            final latitude = service.user.latitude;
            final longitude = service.user.longitude;
            //print("$longitude et $latitude");
            if (latitude != null && longitude != null) {
              final distance = Geolocator.distanceBetween(
                userPosition.latitude,
                userPosition.longitude,
                latitude,
                longitude,
              );
              //print("distance $distance");

              if (distance <= 5000) {
                final markerId = MarkerId(service.id.toString()); // exemple: "12"

                final marker = Marker(
                  markerId: markerId,
                  position: LatLng(latitude, longitude),
                  infoWindow: InfoWindow(
                    title: service.serviceName,
                    snippet: service.user.name,
                  ),
                  onTap: () {
                    setState(() {
                      selectedService = service; // <== on garde ce coach sélectionné
                      showBottomSheet = true;    // <== on affiche le bottom sheet
                    });
                  },
                );


                myMarkers.add(marker);
                // Groupement par coach
                final coachId = service.user.id;
                if (!servicesByCoach.containsKey(coachId)) {
                  servicesByCoach[coachId] = [];
                }
                servicesByCoach[coachId]!.add(service);
                servicesByCoach.forEach((coachId, coachServices) {
                  final coach = coachServices.first.user;
                  final latitude = coach.latitude;
                  final longitude = coach.longitude;

                  if (latitude != null && longitude != null) {
                    final distance = Geolocator.distanceBetween(
                      userPosition.latitude,
                      userPosition.longitude,
                      latitude,
                      longitude,
                    );

                    if (distance <= 5000) {
                      final markerId = MarkerId(coachId.toString());

                      final marker = Marker(
                        markerId: markerId,
                        position: LatLng(latitude, longitude),
                        infoWindow: InfoWindow(
                          title: coach.name,
                          snippet: coachServices.map((s) => s.serviceName).join(", "),
                        ),
                        onTap: () {
                          setState(() {
                            selectedCoachServices = coachServices;
                            showBottomSheet = true;
                          });
                        },
                      );

                      myMarkers.add(marker);
                    }
                  }
                });


              }
            }
          }*/
          for (var service in services) {
            final coachId = service.user.id;
            if (!servicesByCoach.containsKey(coachId)) {
              servicesByCoach[coachId] = [];
            }
            servicesByCoach[coachId]!.add(service);
          }

          servicesByCoach.forEach((coachId, coachServices) {
            final coach = coachServices.first.user;
            final latitude = coach.latitude;
            final longitude = coach.longitude;

            if (latitude != null && longitude != null) {
              final distance = Geolocator.distanceBetween(
                userPosition.latitude,
                userPosition.longitude,
                latitude,
                longitude,
              );

              if (distance <= 5000) {
                final markerId = MarkerId(coachId.toString());

                final marker = Marker(
                  markerId: markerId,
                  position: LatLng(latitude, longitude),
                  infoWindow: InfoWindow(
                    title: coach.name,
                    snippet: coachServices.map((s) => s.serviceName).join(", "),
                  ),
                  onTap: () {
                    setState(() {
                      selectedCoachServices = coachServices;
                      showBottomSheet = true;
                    });
                  },
                );

                myMarkers.add(marker);
              }
            }
          });

        });

        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(_userCameraPosition!));

      } else {
        print('Erreur API: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur: $e');
    }
  }



}
