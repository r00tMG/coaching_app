import 'package:coaching_academy/MVVM/views/global/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';

void main() {
  StripePayment.setOptions(
    StripeOptions(
      publishableKey: "...", // clé publique Stripe
      merchantId: "Test",
      androidPayMode: 'test',
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coaching Academy',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
