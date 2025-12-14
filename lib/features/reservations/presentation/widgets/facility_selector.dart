import 'package:flutter/material.dart';
import '../../../facilities/domain/entities/facility.dart';

class FacilitySelector extends StatelessWidget {
  final List<Facility> facilities;
  final String? selectedFacilityId;
  final Function(String) onFacilitySelected;

  const FacilitySelector({
    super.key,
    required this.facilities,
    required this.selectedFacilityId,
    required this.onFacilitySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: facilities.map((facility) {
        final isSelected = selectedFacilityId == facility.id;
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Card(
            color: isSelected
                ? Theme.of(context).colorScheme.primaryContainer
                : null,
            child: InkWell(
              onTap: () => onFacilitySelected(facility.id),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: _getTypeColor(facility.type),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            _getTypeIcon(facility.type),
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                facility.name,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.onPrimaryContainer
                                      : null,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                facility.type,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.onPrimaryContainer
                                      : Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (facility.description.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                Text(
                                  facility.description,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.onPrimaryContainer
                                        : Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                              const SizedBox(height: 8),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.people_rounded,
                                    size: 16,
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.onPrimaryContainer
                                        : Theme.of(context).colorScheme.primary,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${facility.capacity} personas',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: isSelected
                                          ? Theme.of(context).colorScheme.onPrimaryContainer
                                          : Theme.of(context).colorScheme.onSurfaceVariant,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (isSelected)
                          Icon(
                            Icons.check_circle_rounded,
                            color: Theme.of(context).colorScheme.primary,
                            size: 32,
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      }).toList(),
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

  Color _getTypeColor(String type) {
    switch (type) {
      case 'Salón de Baile':
        return Colors.pink.shade400;
      case 'Salón de Conferencias':
        return Colors.blue.shade600;
      case 'Salón de Banquetes':
        return Colors.amber.shade700;
      default:
        return Colors.grey;
    }
  }
}