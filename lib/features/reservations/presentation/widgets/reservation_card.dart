import 'package:flutter/material.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../domain/entities/reservation.dart';

class ReservationCard extends StatelessWidget {
  final Reservation reservation;
  final VoidCallback onCancel;

  const ReservationCard({
    super.key,
    required this.reservation,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _getTypeColor(context, reservation.facilityType),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getTypeIcon(reservation.facilityType),
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reservation.facilityName,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        reservation.facilityType,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Chip(
                  label: Text(
                    reservation.status == 'active' ? 'Confirmada' : 'Cancelada',
                    style: const TextStyle(fontSize: 12),
                  ),
                  backgroundColor: reservation.status == 'active'
                      ? Colors.green.shade100
                      : Colors.red.shade100,
                  labelStyle: TextStyle(
                    color: reservation.status == 'active'
                        ? Colors.green.shade900
                        : Colors.red.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            _buildInfoRow(
              context,
              Icons.event_rounded,
              'Evento',
              reservation.userName,
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              Icons.calendar_today_rounded,
              'Fecha',
              DateFormatter.formatDate(reservation.date),
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              Icons.access_time_rounded,
              'Horario',
              reservation.timeSlot,
            ),
            if (reservation.status == 'active') ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: onCancel,
                  icon: const Icon(Icons.cancel_rounded),
                  label: const Text('Cancelar Reservación'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      BuildContext context,
      IconData icon,
      String label,
      String value,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: '$label: ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'Salón de Baile':
        return Icons.music_note_rounded;
      case 'Salón de Conferencias':
        return Icons.business_center_rounded;
      case 'Salón de Banquetes':
        return Icons.restaurant_menu_rounded;
      default:
        return Icons.event_rounded;
    }
  }

  Color _getTypeColor(BuildContext context, String type) {
    switch (type) {
      case 'Salón de Baile':
        return Colors.pink.shade400;
      case 'Salón de Conferencias':
        return Colors.blue.shade600;
      case 'Salón de Banquetes':
        return Colors.amber.shade700;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }
}