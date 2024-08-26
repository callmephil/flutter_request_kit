import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_request_kit/src/extension/provider_extensions.dart';
import 'package:flutter_request_kit/src/services/services.dart';
import 'package:flutter_request_kit/src/theme/request_sizes.dart';

import '../enums/enums.dart';
import '../models/models.dart';

void showRequestFormPage(
  BuildContext context, {
  RequestItem? request,
  RequestService? requestService,
  required Function(RequestItem) onSave,
  void Function()? onDelete,
  required Creator creator,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) {
        return RequestFormPage(
          request: request,
          onSave: (newRequest) {
            if (request == null) {
              requestService?.addRequest(newRequest);
            } else {
              requestService?.updateRequest(newRequest.id, newRequest);
            }
            onSave.call(newRequest);
            Navigator.of(context).pop();
          },
          onDelete: onDelete,
          creator: creator,
        );
      },
    ),
  );
}

class RequestFormPage extends StatelessWidget {
  final RequestItem? request;
  final Function(RequestItem) onSave;
  final VoidCallback? onDelete;
  final Creator creator;

  const RequestFormPage({
    super.key,
    this.request,
    required this.onSave,
    this.onDelete,
    required this.creator,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          request == null
              ? context.locale.add_request
              : context.locale.edit_request,
        ),
        actions: [
          if (onDelete != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
        ],
      ),
      body: SafeArea(
        child: RequestFormWidget(
          request: request,
          onSave: onSave,
          creator: creator,
        ),
      ),
    );
  }
}

class RequestFormWidget extends StatefulWidget {
  final RequestItem? request;
  final Function(RequestItem) onSave;
  final Creator creator; // Current user as the creator

  const RequestFormWidget({
    super.key,
    this.request,
    required this.onSave,
    required this.creator,
  });

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
            : widget.request?.status ?? RequestStatus.none,
      );
      widget.onSave(request);
    }
  }

  bool get _canEdit =>
      widget.creator.isAdmin ||
      widget.request == null ||
      widget.request!.creator.userId == widget.creator.userId;

  String? Function(String?)? _validator(String message) {
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
            Expanded(
              child: TextFormField(
                controller: _descriptionController,
                readOnly: !widget.creator.isAdmin &&
                    widget.request != null &&
                    widget.request!.creator.userId != widget.creator.userId,
                validator: _validator(context.locale.please_enter_a_value),
                maxLength: 500,
                maxLines: 999,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
              ),
            ),
            const SizedBox(height: RequestSizes.s24),
            if (_canEdit)
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _onSubmit,
                  child: Text(widget.request == null
                      ? context.locale.add_request
                      : context.locale.edit_request),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
