import 'package:flutter/material.dart';
import 'package:flutter_request_kit/flutter_request_kit.dart';
import 'package:flutter_request_kit/src/extension/provider_extensions.dart';
import 'package:flutter_request_kit/src/theme/request_sizes.dart';

class SearchField extends StatelessWidget {
  final Function(String) onSearchChanged;
  final VoidCallback onAddRequest;
  final RequestStatus? selectedStatus;
  final Function(RequestStatus?) onStatusSelected;

  const SearchField({
    super.key,
    required this.onSearchChanged,
    required this.onAddRequest,
    required this.selectedStatus,
    required this.onStatusSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Padding(
      padding: const EdgeInsets.all(RequestSizes.s8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: onSearchChanged,
                  decoration: InputDecoration(
                    hintText: context.locale.search_request,
                    suffixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(width: RequestSizes.s4),
              IconButton.filled(
                enableFeedback: true,
                style: theme.iconButtonTheme.style,
                onPressed: onAddRequest,
                icon: const Icon(Icons.add),
              )
            ],
          ),
          const SizedBox(height: RequestSizes.s8),
          Wrap(
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            spacing: RequestSizes.s8,
            children: RequestStatus.values
                .where((e) => e != RequestStatus.none)
                .map((status) {
              return ChoiceChip(
                label: Text(status.toName(context.locale)),
                selected: selectedStatus == status,
                onSelected: (selected) {
                  onStatusSelected(selected ? status : null);
                },
              );
            }).toList(growable: false),
          ),
        ],
      ),
    );
  }
}
