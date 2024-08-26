import 'package:flutter/material.dart';
import 'package:flutter_request_kit/src/enums/request_status.dart';
import 'package:flutter_request_kit/src/extension/provider_extensions.dart';
import 'package:flutter_request_kit/src/i18n/i18n.dart';
import 'package:flutter_request_kit/src/i18n/localization_provider.dart';
import 'package:flutter_request_kit/src/services/services.dart';
import 'package:flutter_request_kit/src/theme/custom_theme_provider.dart';
import 'package:flutter_request_kit/src/widgets/components/search_field.dart';

import '../models/models.dart';
import 'request_comments_widget.dart';
import 'request_form_widget.dart';
import 'request_list_widget.dart';

class RequestPage extends StatefulWidget {
  final Creator currentUser;
  final I18n locale;
  final ThemeData theme;
  final RequestService requestService;

  const RequestPage({
    super.key,
    required this.currentUser,
    this.locale = const EnUS(),
    required this.theme,
    required this.requestService,
  });

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  late List<RequestItem> _requestList;
  late List<RequestItem> _filteredRequestList;
  String _searchQuery = "";
  RequestStatus? _selectedStatus;

  RequestService get _requestService => widget.requestService;

  @override
  void initState() {
    super.initState();
    _requestService.listRequests((list) {
      setState(() {
        _requestList = list;
        _filteredRequestList = list;
      });
    });
  }

  void _viewRequestComments(BuildContext context, RequestItem request) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      constraints: BoxConstraints(
        minHeight: MediaQuery.sizeOf(context).height * .8,
        maxHeight: MediaQuery.sizeOf(context).height * .8,
      ),
      builder: (_) {
        return CustomThemeProvider(
          themeData: widget.theme,
          child: LocalizationProvider(
            locale: widget.locale,
            child: RequestComments(
              request: request,
              currentUser: widget.currentUser,
              onAddComment: (comment) {
                _requestService.addComment(request.id, comment);
                _updateRequestList();
              },
              onUpvote: () {
                final upvote = Upvote(
                  userId: widget.currentUser.userId,
                );
                _requestService.upVoteRequest(request.id, upvote);
                _updateRequestList();
              },
              onRemoveUpvote: () {
                _requestService.downVoteRequest(
                    request.id, widget.currentUser.userId);
                _updateRequestList();
              },
            ),
          ),
        );
      },
    );
  }

  void _updateRequestList() {
    _requestService.listRequests((list) {
      setState(() {
        _requestList = list;
        _filterRequests();
      });
    });
  }

  void _filterRequests() {
    setState(() {
      _filteredRequestList = _requestList.where((request) {
        final matchesSearchQuery =
            request.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                request.description
                    .toLowerCase()
                    .contains(_searchQuery.toLowerCase());
        final matchesStatus =
            _selectedStatus == null || request.status == _selectedStatus;
        return matchesSearchQuery && matchesStatus;
      }).toList(growable: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomThemeProvider(
      themeData: widget.theme,
      child: LocalizationProvider(
        locale: widget.locale,
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                context.locale.page_title,
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  SearchField(
                    onSearchChanged: (query) {
                      setState(() {
                        _searchQuery = query;
                        _filterRequests();
                      });
                    },
                    onAddRequest: () {
                      showRequestFormPage(
                        context,
                        request: null,
                        onSave: (RequestItem item) {
                          _requestService.addRequest(item);
                          _updateRequestList();
                        },
                        creator: widget.currentUser,
                      );
                    },
                    selectedStatus: _selectedStatus,
                    onStatusSelected: (status) {
                      setState(() {
                        _selectedStatus = status;
                        _filterRequests();
                      });
                    },
                  ),
                  Expanded(
                    child: RequestListWidget(
                      currentUserId: widget.currentUser.userId,
                      requestList: _filteredRequestList,
                      onLongPress: (request) {
                        showRequestFormPage(
                          context,
                          request: request,
                          onSave: (RequestItem item) {
                            _requestService.updateRequest(
                              item.id,
                              item,
                            );
                            _updateRequestList();
                          },
                          onDelete: () {
                            _requestService.deleteRequest(request.id);
                            Navigator.of(context).pop();
                            _updateRequestList();
                          },
                          creator: widget.currentUser,
                        );
                      },
                      onRequestSelected: (request) {
                        _viewRequestComments(context, request);
                      },
                      onUpvote: (request) {
                        final upvote = Upvote(
                          userId: widget.currentUser.userId,
                        );
                        _requestService.upVoteRequest(request.id, upvote);
                        _updateRequestList();
                      },
                      onRemoveUpvote: (request) {
                        _requestService.downVoteRequest(
                          request.id,
                          widget.currentUser.userId,
                        );
                        _updateRequestList();
                      },
                      onRefresh: () async {
                        await Future.delayed(const Duration(seconds: 1));
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
