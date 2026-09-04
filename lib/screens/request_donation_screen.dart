import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../widgets/cards.dart';
import '../widgets/form_fields.dart';
import '../widgets/latte_app_bar.dart';

class RequestDonationScreen extends StatefulWidget {
  const RequestDonationScreen({super.key});

  @override
  State<RequestDonationScreen> createState() => _RequestDonationScreenState();
}

class _RequestDonationScreenState extends State<RequestDonationScreen> {
  final _responsibleController = TextEditingController(
    text: 'Priscila Nogueira',
  );
  final _babyController = TextEditingController(
    text: 'Recem-nascido prematuro',
  );
  final _phoneController = TextEditingController(text: '(11) 98888-0000');
  final _notesController = TextEditingController(
    text: 'Bebe internado em UTI neonatal, com recomendacao hospitalar.',
  );

  String _hospital = MockData.hospitals.first.name;
  String _priority = 'Alta';
  bool _submitted = false;

  @override
  void dispose() {
    _responsibleController.dispose();
    _babyController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LatteAppBar(title: 'Preciso de doacao', showBack: true),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SectionHeader(
              title: 'Solicitacao de leite humano',
              subtitle:
                  'Preencha os dados principais para simular a triagem do banco de leite.',
            ),
            const SizedBox(height: 18),
            AppCard(child: _form()),
            const SizedBox(height: 18),
            if (_submitted) const _SubmittedNotice(),
            const SizedBox(height: 18),
            const SectionHeader(title: 'Solicitacoes recentes'),
            const SizedBox(height: 12),
            for (final request in MockData.donationRequests) ...[
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.child_care_outlined,
                          color: AppColors.navy,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            request.responsible,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        StatusChip(
                          label: request.priority,
                          color: request.priority == 'Alta'
                              ? AppColors.danger
                              : AppColors.warning,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(request.baby),
                    const SizedBox(height: 6),
                    Text(
                      '${request.hospital} - ${request.status}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.mutedText,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }

  Widget _form() {
    return Column(
      children: [
        FormSection(
          children: [
            AppTextField(
              label: 'Responsavel',
              hint: 'Nome completo',
              controller: _responsibleController,
              required: true,
            ),
            AppTextField(
              label: 'Telefone / WhatsApp',
              hint: '(00) 00000-0000',
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              required: true,
            ),
            AppTextField(
              label: 'Dados do bebe',
              hint: 'Idade, condicao e orientacao medica',
              controller: _babyController,
              required: true,
            ),
            DropdownButtonFormField<String>(
              initialValue: _hospital,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Hospital de referencia',
              ),
              items: MockData.hospitals
                  .map(
                    (hospital) => DropdownMenuItem(
                      value: hospital.name,
                      child: Text(hospital.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) =>
                  setState(() => _hospital = value ?? _hospital),
            ),
            DropdownButtonFormField<String>(
              initialValue: _priority,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Prioridade'),
              items: const ['Alta', 'Media', 'Baixa']
                  .map(
                    (item) => DropdownMenuItem(value: item, child: Text(item)),
                  )
                  .toList(),
              onChanged: (value) =>
                  setState(() => _priority = value ?? _priority),
            ),
            AppTextField(
              label: 'Observacoes',
              hint: 'Informe detalhes importantes',
              controller: _notesController,
              maxLines: 3,
            ),
          ],
        ),
        const SizedBox(height: 18),
        ElevatedButton.icon(
          onPressed: () => setState(() => _submitted = true),
          icon: const Icon(Icons.send_outlined),
          label: const Text('Enviar solicitacao'),
        ),
      ],
    );
  }
}

class _SubmittedNotice extends StatelessWidget {
  const _SubmittedNotice();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      backgroundColor: AppColors.sky,
      borderColor: AppColors.skyStrong,
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: AppColors.success),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Solicitacao registrada. O banco de leite avaliara estoque e entrara em contato.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
