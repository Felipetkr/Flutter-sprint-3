import 'package:flutter/material.dart';

class HomeAction {
  const HomeAction({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
    this.highlight = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String route;
  final bool highlight;
}

class HowStep {
  const HowStep({
    required this.order,
    required this.title,
    required this.description,
    required this.icon,
  });

  final int order;
  final String title;
  final String description;
  final IconData icon;
}

class ImpactStat {
  const ImpactStat({
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;
}

class Hospital {
  const Hospital({
    required this.id,
    required this.name,
    required this.unit,
    required this.neighborhood,
    required this.address,
    required this.distance,
    required this.phone,
    required this.stockLiters,
    required this.demandLiters,
    required this.status,
    required this.availableSlots,
  });

  final String id;
  final String name;
  final String unit;
  final String neighborhood;
  final String address;
  final String distance;
  final String phone;
  final int stockLiters;
  final int demandLiters;
  final String status;
  final List<String> availableSlots;
}

class DashboardMetric {
  const DashboardMetric({
    required this.title,
    required this.value,
    required this.change,
    required this.icon,
    required this.positive,
  });

  final String title;
  final String value;
  final String change;
  final IconData icon;
  final bool positive;
}

class RecentDonor {
  const RecentDonor({
    required this.name,
    required this.neighborhood,
    required this.date,
    required this.status,
  });

  final String name;
  final String neighborhood;
  final String date;
  final String status;
}

class DonationRequest {
  const DonationRequest({
    required this.responsible,
    required this.baby,
    required this.hospital,
    required this.priority,
    required this.status,
  });

  final String responsible;
  final String baby;
  final String hospital;
  final String priority;
  final String status;
}
