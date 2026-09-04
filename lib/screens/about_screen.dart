import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/cards.dart';
import '../widgets/latte_app_bar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LatteAppBar(title: 'Sobre o projeto', showBack: true),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: const [
            SectionHeader(
              title: 'latteConect',
              subtitle: 'MVP social para digitalizar a doacao de leite humano.',
            ),
            SizedBox(height: 18),
            _AboutCard(
              icon: Icons.report_problem_outlined,
              title: 'Problema',
              text:
                  'A comunicacao entre campanhas, nutrizes, bancos de leite e familias ainda e pouco integrada. Isso reduz alcance, engajamento e previsibilidade de estoque.',
            ),
            SizedBox(height: 12),
            _AboutCard(
              icon: Icons.lightbulb_outline,
              title: 'Solucao proposta',
              text:
                  'O app centraliza cadastro de doadoras, agendamento de coleta, solicitacao de doacao, hospitais parceiros e um painel com dados operacionais mockados.',
            ),
            SizedBox(height: 12),
            _AboutCard(
              icon: Icons.auto_awesome_outlined,
              title: 'Diferenciais',
              text:
                  'A proposta evolui para IA consultiva, gamificacao, notificacoes de impacto e mapa de calor por CEP para apoiar decisoes dos gestores.',
            ),
            SizedBox(height: 20),
            SectionHeader(title: 'Roadmap'),
            SizedBox(height: 12),
            _RoadmapCard(),
          ],
        ),
      ),
    );
  }
}

class _AboutCard extends StatelessWidget {
  const _AboutCard({
    required this.icon,
    required this.title,
    required this.text,
  });

  final IconData icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconBubble(icon: icon),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                Text(
                  text,
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

class _RoadmapCard extends StatelessWidget {
  const _RoadmapCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sprint 3 - MVP navegavel',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          const Text(
            'Cadastro, login simulado, informacoes, hospitais parceiros e dados mockados.',
          ),
          const SizedBox(height: 16),
          Text(
            'Sprint 4 - Engajamento e inteligencia',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          const Text(
            'IA consultiva, gamificacao, notificacoes, mapa de calor e dashboard analitico.',
          ),
        ],
      ),
    );
  }
}
