import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_request_kit/packages/vx_store/lib/src/vxstate.dart';

/// Function signature for the callback with context.
typedef ContextCallback = void
    Function(BuildContext context, VxMutation mutation, {VxStatus? status});

/// Helper widget that executes the provided callbacks with context
/// on execution of the mutations. Useful to show SnackBar or navigate
/// to a different route after a mutation.
class VxNotifier extends StatefulWidget {
  /// [VxNotifier] make callbacks for given mutations
  const VxNotifier({super.key, this.child, required this.mutations});

  /// Optional child widget
  final Widget? child;

  /// Map of mutations and their corresponding callback
  final Map<Type, ContextCallback> mutations;

  @override
  State<VxNotifier> createState() => _VxNotifierState();
}

class _VxNotifierState extends State<VxNotifier> {
  StreamSubscription<VxMutation>? eventSub;

  @override
  void initState() {
    super.initState();
    final mutations = widget.mutations.keys.toSet();
    final stream = VxState.events.where(
      (e) => mutations.contains(e.runtimeType),
    );
    eventSub = stream.listen((e) {
      if (mounted) {
        widget.mutations[e.runtimeType]?.call(context, e, status: e.status);
      }
    });
  }

  @override
  void dispose() {
    eventSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // allow null child
    return widget.child ?? const SizedBox();
  }
}
