import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/coach/onboarding/working_hours_screen.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/button/custom_button.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:coaching_academy/utils/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';


class CoachLocation extends StatefulWidget {
  const CoachLocation({super.key});

  @override
  State<CoachLocation> createState() => _CoachLocationState();
}

class _CoachLocationState extends State<CoachLocation> {
  TextEditingController locationController = TextEditingController();
  String? dynamicAddress;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: "Location",
          onPress: () {
            Navigator.pop(context);
          }),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: "Map Location",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      isPoppins: true,
                    ),
                    10.verticalSpace,
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: const CustomText(
                  text: "Pin your Saloon Location on Map to continue",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  isPoppins: true,
                ),
              ),
              10.verticalSpace,
              CustomTextField(
                controller: locationController,
                hintText: "Location",
                iconPath: AppImages.searchIcon,
                iconColor: Colors.black,
              ),
              10.verticalSpace,
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SvgPicture.asset(AppImages.coachLocation)),
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: const CustomText(
                  text: "Address",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  isPoppins: true,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: CustomText(
                  text: dynamicAddress ?? 'Adresse en cours...',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  isPoppins: true,
                ),

              ),
              100.verticalSpace,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                    buttonText: "Continue",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    // onPressed: () {
                    //   PageNavigator(ctx: context)
                    //       .nextPage(page: const WorkingHoursScreen());
                    // },
                    onPressed: () async {
                      await registerLocation(context: context);
                    })

                ),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> registerLocation({required BuildContext context}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    print("token location page $token");
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Token non trouvé. Veuillez vous reconnecter.')),
      );
      return;
    }

    try
    {
      // Demande de permission
      LocationPermission permission = await Geolocator.requestPermission();
      print("Permission: $permission");
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permission de localisation refusée')),
        );
        return;
      }

      // Récupération de la position GPS
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print("Position : $position");

      double latitude = position.latitude;
      double longitude = position.longitude;
      print('salut');

    // Reverse geocoding pour obtenir l'adresse
      String address='';
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
        print("le placemarks : $placemarks");

        if (placemarks.isNotEmpty) {
          final placemark = placemarks.first;

          // Sécurité : afficher tous les champs un par un
          print("street: ${placemark.street}");
          print("locality: ${placemark.locality}");
          print("country: ${placemark.country}");
          print("postalCode: ${placemark.postalCode}");

          String street = placemark.street ?? 'Rue inconnue';
          String city = placemark.locality ?? 'Ville inconnue';
          String country = placemark.country ?? 'Pays inconnu';
          String postalCode = placemark.postalCode ?? 'Code postal inconnu';

          String address = '$street, $city, $country, $postalCode';

          setState(() {
            dynamicAddress = address;
          });
          print("dynamicAddress: $dynamicAddress");
        } else {
          setState(() {
            dynamicAddress = 'Adresse non disponible';
          });
        }
      } catch (e) {
        print('Erreur lors du reverse geocoding : $e');
        setState(() {
          dynamicAddress = 'Erreur lors de la récupération de l’adresse';
        });
      }

      // Appel API avec position et adresse
      final response = await http.post(
        Uri.parse('http://0.0.0.0:8000/api/coach/location'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'location': locationController.text,
          'address': dynamicAddress,
          'latitude': latitude,
          'longitude': longitude,
        }),
      );

      final data = jsonDecode(response.body);
      print("data on location page $data");

      if (response.statusCode == 200) {
        print('Location enregistrée : ${data['location']}');
        PageNavigator(ctx: context).nextPage(page: const WorkingHoursScreen());
      } else {
        print('Erreur : ${data['message']}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur : ${data['message']}')),
        );
      }
    } catch (e) {
      print('Exception : $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Une erreur est survenue')),
      );
    }
  }



}
