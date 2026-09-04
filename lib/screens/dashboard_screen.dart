import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/app_models.dart';
import '../theme/app_colors.dart';
import '../widgets/cards.dart';
import '../widgets/latte_app_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LatteAppBar(title: 'Painel', showBack: true),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SectionHeader(
              title: 'Estoque e operacao',
              subtitle: 'Visao simulada para bancos de leite parceiros.',
            ),
            const SizedBox(height: 18),
            const _StockAlert(),
            const SizedBox(height: 18),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: MockData.dashboardMetrics
                  .map((metric) => _MetricCard(metric: metric))
                  .toList(),
            ),
            const SizedBox(height: 24),
            const SectionHeader(title: 'Cadastros recentes'),
            const SizedBox(height: 12),
            AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  for (var i = 0; i < MockData.recentDonors.length; i++) ...[
                    _DonorRow(donor: MockData.recentDonors[i]),
                    if (i != MockData.recentDonors.length - 1)
                      const Divider(height: 1, color: AppColors.border),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StockAlert extends StatelessWidget {
  const _StockAlert();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      backgroundColor: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const IconBubble(icon: Icons.notifications_active_outlined),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alerta: queda de doacoes prevista',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Reducao simulada de 10% para a proxima semana.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.mutedText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          LinearProgressIndicator(
            value: 45 / 70,
            minHeight: 12,
            borderRadius: BorderRadius.circular(999),
            backgroundColor: AppColors.sky,
            color: AppColors.warning,
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Estoque atual: 45 L'), Text('Meta: 70 L')],
          ),
          const SizedBox(height: 16),
          AppCard(
            backgroundColor: AppColors.amberSoft,
            borderColor: AppColors.amber.withValues(alpha: 0.35),
            child: const Text(
              'A combinacao entre menor volume coletado, aumento de demanda hospitalar e fatores sazonais pode impactar o estoque.',
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.metric});

  final DashboardMetric metric;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width / 2 - 26;
    final color = metric.positive ? AppColors.success : AppColors.warning;

    return SizedBox(
      width: width,
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(metric.icon, color: AppColors.navy, size: 30),
            const SizedBox(height: 12),
            Text(metric.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              metric.value,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 6),
            Text(
              metric.change,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}

class _DonorRow extends StatelessWidget {
  const _DonorRow({required this.donor});

  final RecentDonor donor;

  @override
  Widget build(BuildContext context) {
    final color = switch (donor.status) {
      'Ativa' => AppColors.success,
      'Em analise' => AppColors.blue,
      _ => AppColors.warning,
    };

    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.sky,
            child: Text(
              donor.name.substring(0, 1),
              style: const TextStyle(color: AppColors.navy),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  donor.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 3),
                Text(
                  '${donor.neighborhood} - ${donor.date}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.mutedText),
                ),
              ],
            ),
          ),
          StatusChip(label: donor.status, color: color),
        ],
      ),
    );
  }
}
