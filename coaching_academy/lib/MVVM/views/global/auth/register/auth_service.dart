import 'dart:convert';
import 'dart:io' as io;
import 'package:flutter/foundation.dart'; // Pour kIsWeb
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart'; // Pour définir le type MIME
import 'package:mime/mime.dart'; // ajoute ce package si besoin

class AuthService {
  static Future<bool> signupUser({
    required String name,
    required String email,
    required String country,
    required String address,
    required dynamic profileImage, // io.File sur mobile, Uint8List sur web
  }) async {
    var uri = Uri.parse('http://0.0.0.0:8000/api/signup');
    var request = http.MultipartRequest('POST', uri);

    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['country'] = country;
    request.fields['address'] = address;

    if (kIsWeb) {
      // Web: obtenir le type MIME à partir du fichier d'image (en bytes)
      final mimeType = lookupMimeType('profile.png') ?? 'image/jpeg'; // Utilise un nom de fichier temporaire pour le lookup
      final mediaType = MediaType.parse(mimeType);

      // Ajouter l'image en bytes (Uint8List)
      request.files.add(
        http.MultipartFile.fromBytes(
          'profile_picture',
          profileImage, // Ici, profileImage doit être un Uint8List
          filename: 'profile.png', // Assure-toi de donner un nom de fichier valide
          contentType: mediaType,
        ),
      );
    } else {
      // Mobile : fichier depuis le chemin local
      request.files.add(
        await http.MultipartFile.fromPath(
          'profile_picture',
          (profileImage as io.File).path, // Ici, profileImage est un io.File
        ),
      );
    }

    print('Sending request with image: ${request.files}');
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("userData", jsonEncode(data));
      return true;
    } else {
      print("Signup failed: ${response.body}");
      return false;
    }
  }

  static Future<bool> completeSignup({
        required String bio,
        required String password,
      }) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString("userData");
    print("userJson saved in the session: $userJson");
    if (userJson == null) return false;
    final user = jsonDecode(userJson);

    final response = await http.post(
      Uri.parse("http://0.0.0.0:8000/api/complete-signup"), // à modifier selon ton backend
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "user_id": user["id"], // ou "email" si nécessaire
        "bio": bio,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final updatedUser = jsonDecode(response.body);
      await prefs.setString("userData", jsonEncode(updatedUser));
      return true;
    } else {
      print("Signup step 2 failed: ${response.body}");
      return false;
    }
  }

  static Future<bool> finalizeSignup() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString("userData");

    if (userJson == null) return false;
    final user = jsonDecode(userJson);

    final response = await http.post(
      Uri.parse("http://0.0.0.0:8000/api/validate-registration"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "user_id": user["id"], // ou "email" selon ce que ton backend attend
      }),
    );

    if (response.statusCode == 200) {
      print("User registration finalized");
      return true;
    } else {
      print("Failed to finalize registration: ${response.body}");
      return false;
    }
  }


}
