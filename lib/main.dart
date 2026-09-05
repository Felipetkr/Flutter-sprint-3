import 'package:flutter/material.dart';

import 'config/app_routes.dart';
import 'screens/about_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/donor_registration_screen.dart';
import 'screens/home_screen.dart';
import 'screens/hospital_detail_screen.dart';
import 'screens/hospitals_screen.dart';
import 'screens/request_donation_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const LatteConnectApp());
}

class LatteConnectApp extends StatelessWidget {
  const LatteConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'latteConect',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (_) => const HomeScreen(),
        AppRoutes.donorRegistration: (_) => const DonorRegistrationScreen(),
        AppRoutes.requestDonation: (_) => const RequestDonationScreen(),
        AppRoutes.hospitals: (_) => const HospitalsScreen(),
        AppRoutes.dashboard: (_) => const DashboardScreen(),
        AppRoutes.about: (_) => const AboutScreen(),
      },
      onGenerateRoute: (settings) {
        final name = settings.name ?? '';
        if (name.startsWith(AppRoutes.hospitalDetailPrefix)) {
          final hospitalId = name.substring(
            AppRoutes.hospitalDetailPrefix.length,
          );
          return MaterialPageRoute(
            builder: (_) => HospitalDetailScreen(hospitalId: hospitalId),
          );
        }

        return MaterialPageRoute(builder: (_) => const HomeScreen());
      },
    );
  }
}
