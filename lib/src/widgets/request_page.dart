import 'package:flutter/material.dart';
import 'package:flutter_request_kit/flutter_request_kit.dart';
import 'package:flutter_request_kit/src/i18n/i18n.dart';
import 'package:flutter_request_kit/src/i18n/localization_provider.dart';
import 'package:flutter_request_kit/src/widgets/components/search_field.dart';
import 'package:flutter_request_kit/src/widgets/request_comments_widget.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({
    super.key,
    required this.currentUser,
    this.locale = const EnUS(),
    required this.theme,
    required this.store,
  });
  final Creator currentUser;
  final I18n locale;
  final ThemeData theme;
  final RequestStore store;

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  String _searchQuery = '';
  RequestStatus? _selectedStatus;

  List<RequestItem> _filterRequests(List<RequestItem> requestList) {
    return requestList.where((request) {
      final matchesSearchQuery =
          request.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              request.description.toLowerCase().contains(
                    _searchQuery.toLowerCase(),
                  );
      final matchesStatus =
          _selectedStatus == null || request.status == _selectedStatus;
      return matchesSearchQuery && matchesStatus;
    }).toList(growable: false);
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _onAddRequest() {
    showRequestFormPage(
      context,
      locale: widget.locale,
      onSave: (RequestItem item) {
        AddRequest(item);
      },
      creator: widget.currentUser,
    );
  }

  void _onStatusSelected(RequestStatus? status) {
    setState(() {
      _selectedStatus = status;
    });
  }

  Future<void> _onRefresh() async {
    // TODO: implement on refresh
    await Future<void>.delayed(const Duration(seconds: 1));
  }

  void _onEditRequest(RequestItem request) {
    showRequestFormPage(
      context,
      request: request,
      locale: widget.locale,
      onSave: (RequestItem item) {
        UpdateRequest(request.id, item);
      },
      onDelete: () {
        DeleteRequest(request.id);
        Navigator.of(context).pop();
      },
      creator: widget.currentUser,
    );
  }

  void _onRequestSelected(RequestItem request) {
    showRequestCommentsBottomSheet(
      context: context,
      request: request,
      locale: widget.locale,
      currentUser: widget.currentUser,
    );
  }

  void _onVoteChange(RequestItem request) {
    UpdateVote(request.id, Vote(userId: widget.currentUser.userId));
  }

  @override
  Widget build(BuildContext context) {
    return VxState(
      store: widget.store,
      child: LocalizationProvider(
        locale: widget.locale,
        child: SafeArea(
          child: Column(
            children: [
              SearchField(
                onSearchChanged: _onSearchChanged,
                onAddRequest: _onAddRequest,
                selectedStatus: _selectedStatus,
                onStatusSelected: _onStatusSelected,
              ),
              Expanded(
                child: VxBuilder<RequestStore>(
                  mutations: const {
                    AddRequest,
                    DeleteRequest,
                    UpdateRequest,
                    UpdateVote,
                    AddComment,
                  },
                  builder: (__, store, _) {
                    final filteredRequestList = _filterRequests(
                      store.requests,
                    );
                    return RequestListWidget(
                      currentUserId: widget.currentUser.userId,
                      requestList: filteredRequestList,
                      onRefresh: _onRefresh,
                      onLongPress: _onEditRequest,
                      onRequestSelected: _onRequestSelected,
                      onVoteChange: _onVoteChange,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
