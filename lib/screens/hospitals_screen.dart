import 'package:flutter/material.dart';

import '../config/app_routes.dart';
import '../data/mock_data.dart';
import '../models/app_models.dart';
import '../theme/app_colors.dart';
import '../widgets/cards.dart';
import '../widgets/latte_app_bar.dart';

class HospitalsScreen extends StatelessWidget {
  const HospitalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LatteAppBar(title: 'Hospitais parceiros', showBack: true),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SectionHeader(
              title: 'Bancos de leite conectados',
              subtitle:
                  'Lista mockada com estoque, demanda e horarios de coleta.',
            ),
            const SizedBox(height: 18),
            for (final hospital in MockData.hospitals) ...[
              _HospitalCard(hospital: hospital),
              const SizedBox(height: 14),
            ],
          ],
        ),
      ),
    );
  }
}

class _HospitalCard extends StatelessWidget {
  const _HospitalCard({required this.hospital});

  final Hospital hospital;

  @override
  Widget build(BuildContext context) {
    final stockRatio = hospital.stockLiters / hospital.demandLiters;
    final critical = stockRatio < 0.7;

    return AppCard(
      onTap: () =>
          Navigator.pushNamed(context, AppRoutes.hospitalDetail(hospital.id)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconBubble(
                icon: Icons.local_hospital_outlined,
                color: critical ? AppColors.warning : AppColors.navy,
                backgroundColor: critical ? AppColors.amberSoft : AppColors.sky,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hospital.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${hospital.unit} - ${hospital.neighborhood}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.mutedText,
                      ),
                    ),
                  ],
                ),
              ),
              StatusChip(label: hospital.distance, color: AppColors.blue),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: stockRatio.clamp(0.0, 1.0),
            minHeight: 8,
            borderRadius: BorderRadius.circular(99),
            backgroundColor: AppColors.sky,
            color: critical ? AppColors.warning : AppColors.success,
          ),
          const SizedBox(height: 8),
          Text(
            '${hospital.stockLiters} L disponiveis de ${hospital.demandLiters} L desejados',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.mutedText),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    AppRoutes.hospitalDetail(hospital.id),
                  ),
                  icon: const Icon(Icons.visibility_outlined),
                  label: const Text('Detalhes'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
