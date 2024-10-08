import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_request_kit/packages/vx_store/lib/src/vxstate.dart';
import 'package:flutter_request_kit/packages/vx_store/lib/src/widgets/vxnotifier.dart';

/// A stream builder like widget that accepts
/// mutations and rebuilds after their execution.
class VxConsumer<T> extends StatefulWidget {
  /// Creates widget to rerender child widgets when given
  /// [mutations] execute.
  const VxConsumer({
    super.key,
    required this.builder,
    required this.mutations,
    this.notifications,
  });

  /// [builder] provides the child widget to rendered.
  final VxStateWidgetBuilder<T> builder;

  /// Widget will rerender every time any of [mutations] executes.
  final Set<Type> mutations;

  /// Map of mutations and their corresponding callback
  final Map<Type, ContextCallback>? notifications;

  @override
  State<VxConsumer<T>> createState() => _VxConsumerState<T>();
}

class _VxConsumerState<T> extends State<VxConsumer<T>> {
  StreamSubscription<VxMutation>? eventSub;

  @override
  void initState() {
    super.initState();
    if (widget.notifications != null) {
      final notifications = widget.notifications!.keys.toSet();
      final stream = VxState.events.where(
        (e) => notifications.contains(e.runtimeType),
      );
      eventSub = stream.listen((e) {
        if (mounted) {
          widget.notifications![e.runtimeType]
              ?.call(context, e, status: e.status);
        }
      });
    }
  }

  @override
  void dispose() {
    eventSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stream = VxState.events.where(
      (e) => widget.mutations.contains(e.runtimeType),
    );
    return StreamBuilder<VxMutation>(
      stream: stream,
      builder: (ctx, mut) {
        VxStatus? status;
        if (!mut.hasData || mut.connectionState == ConnectionState.waiting) {
          status = VxStatus.none;
        } else {
          status = mut.data?.status;
        }
        final store = VxState.store as T;
        return widget.builder(ctx, store, status);
      },
    );
  }
}
