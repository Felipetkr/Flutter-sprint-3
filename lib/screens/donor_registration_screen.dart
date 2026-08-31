import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../widgets/cards.dart';
import '../widgets/form_fields.dart';
import '../widgets/latte_app_bar.dart';

class DonorRegistrationScreen extends StatefulWidget {
  const DonorRegistrationScreen({super.key});

  @override
  State<DonorRegistrationScreen> createState() =>
      _DonorRegistrationScreenState();
}

class _DonorRegistrationScreenState extends State<DonorRegistrationScreen> {
  final _nameController = TextEditingController(text: 'Ana Souza');
  final _phoneController = TextEditingController(text: '(11) 99999-0000');
  final _emailController = TextEditingController(text: 'ana.souza@email.com');
  final _birthController = TextEditingController(text: '14/03/1994');
  final _cepController = TextEditingController(text: '04020-000');
  final _addressController = TextEditingController(text: 'Rua das Flores, 123');
  final _neighborhoodController = TextEditingController(text: 'Vila Mariana');

  int _step = 0;
  String _civilStatus = 'Solteira';
  String _hospital = MockData.hospitals.first.name;
  String _selectedDate = '28/05/2026';
  String _selectedSlot = '09:00 - 10:00';
  final Set<String> _days = {'Segunda', 'Quarta', 'Sexta'};
  bool _healthy = true;
  bool _authorized = true;

  List<String> get _titles => const [
    'Dados pessoais',
    'Endereco para coleta',
    'Disponibilidade e saude',
    'Agendamento da coleta',
    'Confirmacao',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _birthController.dispose();
    _cepController.dispose();
    _addressController.dispose();
    _neighborhoodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LatteAppBar(title: 'Cadastro de doadora', showBack: true),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            _StepProgress(currentStep: _step, titles: _titles),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  SectionHeader(
                    title: '${_step + 1}. ${_titles[_step]}',
                    subtitle: _subtitleForStep(_step),
                  ),
                  const SizedBox(height: 18),
                  AppCard(child: _contentForStep()),
                  const SizedBox(height: 16),
                  const _SecurityNotice(),
                ],
              ),
            ),
            _BottomActions(
              showBack: _step > 0,
              isLast: _step == _titles.length - 1,
              onBack: () => setState(() => _step--),
              onNext: _handleNext,
            ),
          ],
        ),
      ),
    );
  }

  String _subtitleForStep(int step) {
    return switch (step) {
      0 => 'Vamos comecar com as informacoes basicas da nutriz.',
      1 => 'Informe onde a equipe podera realizar a coleta domiciliar.',
      2 => 'Os dados simulam a triagem inicial antes da coleta.',
      3 => 'Escolha uma data, horario e hospital responsavel.',
      _ => 'Revise os dados antes de enviar a solicitacao.',
    };
  }

  Widget _contentForStep() {
    return switch (_step) {
      0 => _personalForm(),
      1 => _addressForm(),
      2 => _availabilityForm(),
      3 => _scheduleForm(),
      _ => _confirmation(),
    };
  }

  Widget _personalForm() {
    return FormSection(
      children: [
        AppTextField(
          label: 'Nome completo',
          hint: 'Digite seu nome completo',
          controller: _nameController,
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
          label: 'E-mail',
          hint: 'seuemail@exemplo.com',
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        AppTextField(
          label: 'Data de nascimento',
          hint: 'dd/mm/aaaa',
          controller: _birthController,
        ),
        DropdownButtonFormField<String>(
          initialValue: _civilStatus,
          isExpanded: true,
          decoration: const InputDecoration(labelText: 'Estado civil'),
          items:
              const [
                    'Solteira',
                    'Casada',
                    'Uniao estavel',
                    'Prefiro nao informar',
                  ]
                  .map(
                    (item) => DropdownMenuItem(value: item, child: Text(item)),
                  )
                  .toList(),
          onChanged: (value) =>
              setState(() => _civilStatus = value ?? _civilStatus),
        ),
      ],
    );
  }

  Widget _addressForm() {
    return FormSection(
      children: [
        AppTextField(
          label: 'CEP',
          hint: '00000-000',
          controller: _cepController,
          keyboardType: TextInputType.number,
          required: true,
        ),
        AppTextField(
          label: 'Endereco',
          hint: 'Rua, numero e complemento',
          controller: _addressController,
          required: true,
        ),
        AppTextField(
          label: 'Bairro',
          hint: 'Informe o bairro',
          controller: _neighborhoodController,
          required: true,
        ),
        DropdownButtonFormField<String>(
          initialValue: _hospital,
          isExpanded: true,
          decoration: const InputDecoration(labelText: 'Hospital responsavel'),
          items: MockData.hospitals
              .map(
                (hospital) => DropdownMenuItem(
                  value: hospital.name,
                  child: Text(hospital.name),
                ),
              )
              .toList(),
          onChanged: (value) => setState(() => _hospital = value ?? _hospital),
        ),
      ],
    );
  }

  Widget _availabilityForm() {
    const allDays = ['Segunda', 'Terca', 'Quarta', 'Quinta', 'Sexta', 'Sabado'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dias disponiveis',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: allDays.map((day) {
            final selected = _days.contains(day);
            return FilterChip(
              selected: selected,
              label: Text(day),
              onSelected: (checked) {
                setState(() {
                  checked ? _days.add(day) : _days.remove(day);
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        SwitchListTile(
          value: _healthy,
          contentPadding: EdgeInsets.zero,
          title: const Text('Estou saudavel e apta para a triagem inicial'),
          subtitle: const Text('Confirmacao simulada para fins do MVP.'),
          onChanged: (value) => setState(() => _healthy = value),
        ),
        CheckboxListTile(
          value: _authorized,
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          title: const Text('Autorizo contato do hospital parceiro'),
          subtitle: const Text(
            'Os dados serao usados apenas para viabilizar a doacao.',
          ),
          onChanged: (value) =>
              setState(() => _authorized = value ?? _authorized),
        ),
      ],
    );
  }

  Widget _scheduleForm() {
    const dates = [
      '26/05/2026',
      '27/05/2026',
      '28/05/2026',
      '29/05/2026',
      '30/05/2026',
    ];
    const slots = [
      '08:00 - 09:00',
      '09:00 - 10:00',
      '10:00 - 11:00',
      '13:00 - 14:00',
      '14:00 - 15:00',
      '15:00 - 16:00',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selecione a data',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: dates.map((date) {
            final selected = date == _selectedDate;
            return ChoiceChip(
              selected: selected,
              label: Text(date),
              onSelected: (_) => setState(() => _selectedDate = date),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        Text(
          'Horarios disponiveis',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: slots.map((slot) {
            final selected = slot == _selectedSlot;
            return ChoiceChip(
              selected: selected,
              label: Text(slot),
              onSelected: (_) => setState(() => _selectedSlot = slot),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        AppCard(
          backgroundColor: AppColors.amberSoft,
          borderColor: AppColors.amber.withValues(alpha: 0.35),
          child: const Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.amber),
              SizedBox(width: 12),
              Expanded(
                child: Text('A coleta tem duracao media de 30 a 40 minutos.'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _confirmation() {
    return Column(
      children: [
        _SummaryRow(label: 'Doadora', value: _nameController.text),
        _SummaryRow(label: 'Contato', value: _phoneController.text),
        _SummaryRow(label: 'Endereco', value: _addressController.text),
        _SummaryRow(label: 'Bairro', value: _neighborhoodController.text),
        _SummaryRow(label: 'Hospital', value: _hospital),
        _SummaryRow(label: 'Data', value: _selectedDate),
        _SummaryRow(label: 'Horario', value: _selectedSlot),
        _SummaryRow(label: 'Disponibilidade', value: _days.join(', ')),
      ],
    );
  }

  void _handleNext() {
    if (_step < _titles.length - 1) {
      setState(() => _step++);
      return;
    }

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.check_circle,
          color: AppColors.success,
          size: 44,
        ),
        title: const Text('Coleta solicitada'),
        content: Text(
          'A coleta de ${_nameController.text} foi agendada para $_selectedDate, '
          'das $_selectedSlot. O hospital entrara em contato para confirmar.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Concluir'),
          ),
        ],
      ),
    );
  }
}

class _StepProgress extends StatelessWidget {
  const _StepProgress({required this.currentStep, required this.titles});

  final int currentStep;
  final List<String> titles;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: List.generate(titles.length, (index) {
            final active = index == currentStep;
            final done = index < currentStep;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Chip(
                avatar: CircleAvatar(
                  backgroundColor: active || done
                      ? AppColors.navy
                      : AppColors.sky,
                  child: Text(
                    done ? '✓' : '${index + 1}',
                    style: TextStyle(
                      color: active || done ? Colors.white : AppColors.navy,
                      fontSize: 12,
                    ),
                  ),
                ),
                label: Text(titles[index]),
                side: BorderSide(
                  color: active ? AppColors.navy : AppColors.border,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _SecurityNotice extends StatelessWidget {
  const _SecurityNotice();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      backgroundColor: AppColors.amberSoft,
      borderColor: AppColors.amber.withValues(alpha: 0.35),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.verified_user_outlined, color: AppColors.navy),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Ambiente seguro: as informacoes sao confidenciais e utilizadas apenas para viabilizar a doacao de leite humano.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomActions extends StatelessWidget {
  const _BottomActions({
    required this.showBack,
    required this.isLast,
    required this.onBack,
    required this.onNext,
  });

  final bool showBack;
  final bool isLast;
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          if (showBack) ...[
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back),
                label: const Text('Voltar'),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onNext,
              icon: Icon(isLast ? Icons.check : Icons.arrow_forward),
              label: Text(isLast ? 'Confirmar coleta' : 'Proximo'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: AppColors.navy),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
