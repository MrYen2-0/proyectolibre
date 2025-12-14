import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../domain/entities/reservation.dart';
import '../providers/reservation_provider.dart';
import '../../../facilities/presentation/providers/facility_provider.dart';
import '../widgets/facility_selector.dart';

class CreateReservationPage extends StatefulWidget {
  const CreateReservationPage({super.key});

  @override
  State<CreateReservationPage> createState() => _CreateReservationPageState();
}

class _CreateReservationPageState extends State<CreateReservationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _eventNameController = TextEditingController();
  final _attendeesController = TextEditingController();

  String? _selectedFacilityId;
  DateTime _selectedDate = DateTime.now();
  String? _selectedTimeSlot;

  @override
  void dispose() {
    _nameController.dispose();
    _eventNameController.dispose();
    _attendeesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservar Salón'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionTitle(context, 'Información del Cliente'),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre completo',
                  hintText: 'Ingresa tu nombre',
                  prefixIcon: Icon(Icons.person_rounded),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              _buildSectionTitle(context, 'Detalles del Evento'),
              const SizedBox(height: 16),
              TextFormField(
                controller: _eventNameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del evento',
                  hintText: 'Boda, Conferencia, Cumpleaños',
                  prefixIcon: Icon(Icons.celebration_rounded),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el nombre del evento';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _attendeesController,
                decoration: const InputDecoration(
                  labelText: 'Número de asistentes',
                  hintText: 'Cantidad estimada de personas',
                  prefixIcon: Icon(Icons.people_rounded),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el número de asistentes';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Ingresa un número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              _buildSectionTitle(context, 'Selecciona un Salón'),
              const SizedBox(height: 16),
              Consumer<FacilityProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  return FacilitySelector(
                    facilities: provider.facilities,
                    selectedFacilityId: _selectedFacilityId,
                    onFacilitySelected: (facilityId) {
                      setState(() {
                        _selectedFacilityId = facilityId;
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 32),
              _buildSectionTitle(context, 'Fecha del Evento'),
              const SizedBox(height: 16),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.calendar_today_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    DateFormatter.formatDate(_selectedDate),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  onTap: _selectDate,
                ),
              ),
              const SizedBox(height: 32),
              _buildSectionTitle(context, 'Horario'),
              const SizedBox(height: 16),
              _buildTimeSlotGrid(),
              const SizedBox(height: 40),
              FilledButton.icon(
                onPressed: _createReservation,
                icon: const Icon(Icons.check_circle_rounded),
                label: const Text('Confirmar Reservación'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTimeSlotGrid() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: AppConstants.timeSlots.map((time) {
        final isSelected = _selectedTimeSlot == time;
        return ChoiceChip(
          label: Text(time),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              _selectedTimeSlot = selected ? time : null;
            });
          },
          selectedColor: Theme.of(context).colorScheme.primaryContainer,
          labelStyle: TextStyle(
            color: isSelected
                ? Theme.of(context).colorScheme.onPrimaryContainer
                : Theme.of(context).colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        );
      }).toList(),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _createReservation() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedFacilityId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona un salón'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (_selectedTimeSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona un horario'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final facilityProvider = context.read<FacilityProvider>();
    final facility = facilityProvider.facilities.firstWhere(
          (f) => f.id == _selectedFacilityId,
    );

    // Verificar capacidad
    final attendees = int.parse(_attendeesController.text);
    if (attendees > facility.capacity) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('El salón tiene capacidad máxima de ${facility.capacity} personas'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final reservation = Reservation(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      facilityId: facility.id,
      facilityName: facility.name,
      facilityType: facility.type,
      date: _selectedDate,
      timeSlot: _selectedTimeSlot!,
      userName: '${_nameController.text} - ${_eventNameController.text} ($attendees personas)',
      status: 'active',
    );

    context.read<ReservationProvider>().addReservation(reservation);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('¡Reservación confirmada exitosamente!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green.shade700,
      ),
    );

    context.go('/');
  }
}