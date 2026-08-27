import 'package:flutter/material.dart';

import '../config/app_routes.dart';
import '../models/app_models.dart';

class MockData {
  static const actions = [
    HomeAction(
      title: 'Quero doar leite',
      subtitle: 'Cadastre-se como nutriz doadora e agende a coleta em casa.',
      icon: Icons.volunteer_activism_outlined,
      route: AppRoutes.donorRegistration,
      highlight: true,
    ),
    HomeAction(
      title: 'Preciso de doacao',
      subtitle: 'Solicite leite humano para um bebe que precisa de apoio.',
      icon: Icons.family_restroom_outlined,
      route: AppRoutes.requestDonation,
    ),
    HomeAction(
      title: 'Encontrar hospital',
      subtitle: 'Veja bancos de leite e hospitais parceiros por regiao.',
      icon: Icons.local_hospital_outlined,
      route: AppRoutes.hospitals,
    ),
    HomeAction(
      title: 'Conhecer o projeto',
      subtitle: 'Entenda a proposta, impacto e roadmap da solucao.',
      icon: Icons.info_outline,
      route: AppRoutes.about,
    ),
  ];

  static const steps = [
    HowStep(
      order: 1,
      title: 'Cadastro',
      description:
          'A doadora informa dados pessoais, endereco e disponibilidade.',
      icon: Icons.person_add_alt_1_outlined,
    ),
    HowStep(
      order: 2,
      title: 'Coleta',
      description:
          'O hospital parceiro agenda a retirada no domicilio da nutriz.',
      icon: Icons.calendar_month_outlined,
    ),
    HowStep(
      order: 3,
      title: 'Triagem',
      description:
          'O leite passa por analise, pasteurizacao e armazenamento seguro.',
      icon: Icons.health_and_safety_outlined,
    ),
    HowStep(
      order: 4,
      title: 'Distribuicao',
      description:
          'Bebes que precisam recebem o leite com acompanhamento hospitalar.',
      icon: Icons.local_drink_outlined,
    ),
  ];

  static const impactStats = [
    ImpactStat(value: '18.542 L', label: 'litros doados', icon: Icons.opacity),
    ImpactStat(
      value: '25.867',
      label: 'bebes beneficiados',
      icon: Icons.child_care_outlined,
    ),
    ImpactStat(
      value: '217',
      label: 'hospitais conectados',
      icon: Icons.local_hospital_outlined,
    ),
    ImpactStat(
      value: '124.318',
      label: 'doacoes realizadas',
      icon: Icons.favorite_border,
    ),
  ];

  static const hospitals = [
    Hospital(
      id: 'santa-clara',
      name: 'Banco de Leite Santa Clara',
      unit: 'Unidade Vila Mariana',
      neighborhood: 'Vila Mariana',
      address: 'Rua das Flores, 123 - Sao Paulo/SP',
      distance: '1,8 km',
      phone: '(11) 99999-1234',
      stockLiters: 45,
      demandLiters: 70,
      status: 'Coleta domiciliar ativa',
      availableSlots: ['28/05 - 09:00', '28/05 - 14:00', '29/05 - 10:00'],
    ),
    Hospital(
      id: 'maternidade-luz',
      name: 'Maternidade Luz do Cuidado',
      unit: 'Banco de Leite Zona Sul',
      neighborhood: 'Santo Amaro',
      address: 'Av. Adolfo Pinheiro, 980 - Sao Paulo/SP',
      distance: '4,2 km',
      phone: '(11) 98888-4567',
      stockLiters: 32,
      demandLiters: 62,
      status: 'Alta demanda',
      availableSlots: ['29/05 - 08:00', '30/05 - 13:00'],
    ),
    Hospital(
      id: 'hospital-esperanca',
      name: 'Hospital Municipal Esperanca',
      unit: 'Unidade Santana',
      neighborhood: 'Santana',
      address: 'Rua Voluntarios da Patria, 410 - Sao Paulo/SP',
      distance: '7,5 km',
      phone: '(11) 97777-8901',
      stockLiters: 58,
      demandLiters: 64,
      status: 'Estoque estavel',
      availableSlots: ['28/05 - 11:00', '31/05 - 15:00'],
    ),
  ];

  static const dashboardMetrics = [
    DashboardMetric(
      title: 'Doadoras ativas',
      value: '124',
      change: '+18% vs. mes anterior',
      icon: Icons.groups_2_outlined,
      positive: true,
    ),
    DashboardMetric(
      title: 'Coletas este mes',
      value: '86',
      change: '+15% vs. mes anterior',
      icon: Icons.event_available_outlined,
      positive: true,
    ),
    DashboardMetric(
      title: 'Analises pendentes',
      value: '17',
      change: '+22% de demanda',
      icon: Icons.assignment_outlined,
      positive: false,
    ),
  ];

  static const recentDonors = [
    RecentDonor(
      name: 'Ana Souza',
      neighborhood: 'Vila Clementino',
      date: '25/05/2026 - 09:42',
      status: 'Ativa',
    ),
    RecentDonor(
      name: 'Julia Lima',
      neighborhood: 'Mooca',
      date: '25/05/2026 - 08:15',
      status: 'Em analise',
    ),
    RecentDonor(
      name: 'Mariana Costa',
      neighborhood: 'Santana',
      date: '24/05/2026 - 16:33',
      status: 'Pendente',
    ),
    RecentDonor(
      name: 'Carla Menezes',
      neighborhood: 'Pinheiros',
      date: '24/05/2026 - 11:07',
      status: 'Ativa',
    ),
  ];

  static const donationRequests = [
    DonationRequest(
      responsible: 'Priscila Nogueira',
      baby: 'Recem-nascido prematuro',
      hospital: 'Banco de Leite Santa Clara',
      priority: 'Alta',
      status: 'Triagem hospitalar',
    ),
    DonationRequest(
      responsible: 'Rafael Martins',
      baby: 'Bebe internado em UTI neonatal',
      hospital: 'Maternidade Luz do Cuidado',
      priority: 'Media',
      status: 'Aguardando estoque',
    ),
  ];
}
