import 'package:flutter/material.dart';

import '../config/app_routes.dart';
import '../data/mock_data.dart';
import '../models/app_models.dart';
import '../theme/app_colors.dart';
import '../widgets/cards.dart';
import '../widgets/latte_app_bar.dart';

class HospitalDetailScreen extends StatelessWidget {
  const HospitalDetailScreen({super.key, required this.hospitalId});

  final String hospitalId;

  @override
  Widget build(BuildContext context) {
    final hospital = MockData.hospitals.firstWhere(
      (item) => item.id == hospitalId,
      orElse: () => MockData.hospitals.first,
    );

    return Scaffold(
      appBar: const LatteAppBar(title: 'Detalhe do hospital', showBack: true),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _Header(hospital: hospital),
            const SizedBox(height: 18),
            AppCard(
              child: Column(
                children: [
                  _InfoRow(
                    icon: Icons.location_on_outlined,
                    label: 'Endereco',
                    value: hospital.address,
                  ),
                  _InfoRow(
                    icon: Icons.phone_outlined,
                    label: 'Contato',
                    value: hospital.phone,
                  ),
                  _InfoRow(
                    icon: Icons.verified_user_outlined,
                    label: 'Status',
                    value: hospital.status,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const SectionHeader(title: 'Horarios disponiveis'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: hospital.availableSlots
                  .map(
                    (slot) => ActionChip(
                      label: Text(slot),
                      avatar: const Icon(
                        Icons.calendar_today_outlined,
                        size: 18,
                      ),
                      onPressed: () =>
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Horario $slot selecionado.'),
                            ),
                          ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.donorRegistration),
              icon: const Icon(Icons.favorite_border),
              label: const Text('Agendar doacao neste hospital'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.hospital});

  final Hospital hospital;

  @override
  Widget build(BuildContext context) {
    final ratio = hospital.stockLiters / hospital.demandLiters;

    return AppCard(
      backgroundColor: AppColors.sky,
      borderColor: AppColors.skyStrong,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconBubble(
            icon: Icons.local_hospital_outlined,
            backgroundColor: Colors.white,
          ),
          const SizedBox(height: 14),
          Text(
            hospital.name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 6),
          Text(
            '${hospital.unit} - ${hospital.neighborhood} - ${hospital.distance}',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.mutedText),
          ),
          const SizedBox(height: 18),
          LinearProgressIndicator(
            value: ratio.clamp(0.0, 1.0),
            minHeight: 10,
            borderRadius: BorderRadius.circular(99),
            backgroundColor: Colors.white,
            color: ratio < 0.7 ? AppColors.warning : AppColors.success,
          ),
          const SizedBox(height: 8),
          Text(
            '${hospital.stockLiters} L em estoque / demanda de ${hospital.demandLiters} L',
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.navy),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.labelLarge),
                Text(
                  value,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.mutedText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
