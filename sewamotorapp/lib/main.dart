import 'package:flutter/material.dart';
import 'package:sewamotorapp/screens/splash_screen.dart';
import 'screens/login_motor_screen.dart';
import 'screens/dashboard_motor_screen.dart';
import 'screens/registrasi_screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sewa Motor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Set SplashScreen sebagai halaman awal
      routes: {
        '/': (context) => SplashScreen(), // Tambahkan rute splash screen
        '/login': (context) => LoginMotorScreen(),
        '/dashboard': (context) => DashboardMotorScreen(),
        '/registrasi': (context) => RegistrasiScreen(),
      },
    );
  }
}