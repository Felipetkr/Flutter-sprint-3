import 'package:flutter/material.dart';

import '../config/app_routes.dart';
import '../data/mock_data.dart';
import '../models/app_models.dart';
import '../theme/app_colors.dart';
import '../widgets/cards.dart';
import '../widgets/latte_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LatteAppBar(showDashboard: true),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          children: [
            const _HeroPanel(),
            const SizedBox(height: 18),
            for (final action in MockData.actions) ...[
              _ActionTile(action: action),
              const SizedBox(height: 12),
            ],
            const SizedBox(height: 10),
            const SectionHeader(
              title: 'Como funciona',
              subtitle:
                  'Um fluxo simples para aproximar doadoras, bancos de leite e familias.',
            ),
            const SizedBox(height: 14),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 640;
                final cardWidth = isWide
                    ? (constraints.maxWidth - 12) / 2
                    : constraints.maxWidth;

                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: MockData.steps
                      .map(
                        (step) => SizedBox(
                          width: cardWidth,
                          child: _StepCard(step: step),
                        ),
                      )
                      .toList(),
                );
              },
            ),
            const SizedBox(height: 24),
            const SectionHeader(
              title: 'Nosso impacto',
              subtitle:
                  'Dados simulados para demonstrar o comportamento da solucao.',
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: MockData.impactStats
                  .map((stat) => _ImpactCard(stat: stat))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroPanel extends StatelessWidget {
  const _HeroPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Colors.white, AppColors.sky],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: AppColors.amberSoft,
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Text(
              'LEITE HUMANO - VIDA QUE CONECTA',
              style: TextStyle(
                color: AppColors.amber,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text.rich(
            TextSpan(
              text:
                  'Conectando doadoras, hospitais e familias que precisam de ',
              children: [
                TextSpan(
                  text: 'leite humano.',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 12),
          Text(
            'O latteConect facilita a doacao, a coleta domiciliar e o acesso seguro para quem mais precisa.',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.mutedText),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.donorRegistration),
                  icon: const Icon(Icons.favorite_border),
                  label: const Text('Doar leite'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.action});

  final HomeAction action;

  @override
  Widget build(BuildContext context) {
    final iconColor = action.highlight ? AppColors.amber : AppColors.navy;
    final background = action.highlight ? AppColors.amberSoft : AppColors.sky;

    return AppCard(
      onTap: () => Navigator.pushNamed(context, action.route),
      child: Row(
        children: [
          IconBubble(
            icon: action.icon,
            color: iconColor,
            backgroundColor: background,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  action.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  action.subtitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.mutedText),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward, color: AppColors.navy),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({required this.step});

  final HowStep step;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconBubble(icon: step.icon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${step.order}. ${step.title}',
                  style: Theme.of(context).textTheme.titleMedium,
                  softWrap: true,
                ),
                const SizedBox(height: 6),
                Text(
                  step.description,
                  softWrap: true,
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

class _ImpactCard extends StatelessWidget {
  const _ImpactCard({required this.stat});

  final ImpactStat stat;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width / 2 - 26,
      child: AppCard(
        backgroundColor: AppColors.navy,
        borderColor: AppColors.navy,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(stat.icon, color: AppColors.amber, size: 28),
            const SizedBox(height: 10),
            Text(
              stat.value,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              stat.label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.78),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
