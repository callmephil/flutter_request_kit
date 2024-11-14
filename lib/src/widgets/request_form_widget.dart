import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_request_kit/flutter_request_kit.dart';
import 'package:flutter_request_kit/src/extension/provider_extensions.dart';
import 'package:flutter_request_kit/src/theme/request_sizes.dart';

class RequestFormWidget extends StatefulWidget {
  const RequestFormWidget({
    super.key,
    this.request,
    required this.onSave,
    required this.creator,
  });

  final RequestItem? request;
  final void Function(RequestItem) onSave;
  final Creator creator;

  @override
  State<RequestFormWidget> createState() => _RequestFormWidgetState();
}

class _RequestFormWidgetState extends State<RequestFormWidget> {
  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  RequestStatus _status = RequestStatus.none;

  @override
  void initState() {
    super.initState();
    if (widget.request != null) {
      _titleController.text = widget.request!.title;
      _descriptionController.text = widget.request!.description;
      _status = widget.request!.status;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final request = RequestItem(
        id: widget.request?.id ?? DateTime.now().toString(),
        creator: widget.creator,
        title: _titleController.text,
        description: _descriptionController.text,
        createdAt: widget.request?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
        status: widget.creator.isAdmin
            ? _status
            : (widget.request?.status ?? RequestStatus.none),
      );
      widget.onSave(request);
    }
  }

  bool get _canEdit =>
      widget.creator.isAdmin ||
      widget.request == null ||
      widget.request!.creator.userId == widget.creator.userId;

  String? Function(String?) _validator(String message) {
    return (value) {
      if (value?.isEmpty ?? false) {
        return message;
      }
      return null;
    };
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(RequestSizes.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.creator.isAdmin) ...[
              Text(
                context.locale.status,
                style: context.theme.textTheme.labelSmall,
              ),
              const SizedBox(height: RequestSizes.s4),
              DropdownButton<RequestStatus>(
                value: _status,
                onChanged: (newStatus) {
                  setState(() {
                    _status = newStatus!;
                  });
                },
                items: RequestStatus.values.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status.toName(context.locale)),
                  );
                }).toList(growable: false),
              ),
            ],
            const SizedBox(height: RequestSizes.s24),
            Text(
              context.locale.title,
              style: context.theme.textTheme.labelSmall,
            ),
            const SizedBox(height: RequestSizes.s8),
            TextFormField(
              controller: _titleController,
              readOnly: !widget.creator.isAdmin &&
                  widget.request != null &&
                  widget.request!.creator.userId != widget.creator.userId,
              validator: _validator(context.locale.please_enter_a_value),
            ),
            const SizedBox(height: RequestSizes.s24),
            Text(
              context.locale.description,
              style: context.theme.textTheme.labelSmall,
            ),
            const SizedBox(height: RequestSizes.s8),
            Expanded(
              child: TextFormField(
                controller: _descriptionController,
                readOnly: !widget.creator.isAdmin &&
                    widget.request != null &&
                    widget.request!.creator.userId != widget.creator.userId,
                validator: _validator(context.locale.please_enter_a_value),
                maxLength: 500,
                maxLines: 500,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
              ),
            ),
            const SizedBox(height: RequestSizes.s24),
            if (_canEdit)
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _onSubmit,
                  child: Text(
                    widget.request == null
                        ? context.locale.add_request
                        : context.locale.edit_request,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
