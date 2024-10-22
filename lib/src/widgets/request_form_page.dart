import 'package:flutter/material.dart';
import 'package:flutter_request_kit/src/extension/provider_extensions.dart';
import 'package:flutter_request_kit/src/i18n/i18n.dart';
import 'package:flutter_request_kit/src/i18n/localization_provider.dart';
import 'package:flutter_request_kit/src/models/models.dart';
import 'package:flutter_request_kit/src/widgets/request_form_widget.dart';

void showRequestFormPage(
  BuildContext context, {
  required I18n locale,
  RequestItem? request,
  required void Function(RequestItem) onSave,
  void Function()? onDelete,
  required Creator creator,
}) {
  Navigator.push(
    context,
    MaterialPageRoute<Widget>(
      settings: const RouteSettings(name: '/request_form'),
      builder: (_) {
        return LocalizationProvider(
          locale: locale,
          child: Builder(
            builder: (ctx) {
              return RequestFormPage(
                request: request,
                onSave: (newRequest) {
                  onSave(newRequest);
                  Navigator.of(ctx).pop();
                },
                onDelete: onDelete,
                creator: creator,
              );
            },
          ),
        );
      },
    ),
  );
}

class RequestFormPage extends StatelessWidget {
  const RequestFormPage({
    super.key,
    this.request,
    required this.onSave,
    this.onDelete,
    required this.creator,
  });

  final RequestItem? request;
  final void Function(RequestItem) onSave;
  final VoidCallback? onDelete;
  final Creator creator;

  bool get canDelete =>
      creator.userId == request?.creator.userId || creator.isAdmin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          request == null
              ? context.locale.add_request
              : context.locale.edit_request,
        ),
        actions: request == null || !canDelete
            ? []
            : [
                if (onDelete != null)
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: onDelete,
                  ),
              ],
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SafeArea(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * .8,
            child: RequestFormWidget(
              request: request,
              onSave: onSave,
              creator: creator,
            ),
          ),
        ),
      ),
    );
  }
}
