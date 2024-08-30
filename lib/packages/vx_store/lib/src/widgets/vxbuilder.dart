import 'package:flutter/widgets.dart';
import 'package:flutter_request_kit/packages/vx_store/lib/src/vxstate.dart';

/// A stream builder like widget that accepts
/// mutations and rebuilds after their execution.
class VxBuilder<T> extends StatelessWidget {
  /// Creates widget to rerender child widgets when given
  /// [mutations] execute.
  const VxBuilder({
    super.key,
    required this.builder,
    required this.mutations,
  });

  /// [builder] provides the child widget to rendered.
  final VxStateWidgetBuilder<T> builder;

  /// Widget will rerender every time any of [mutations] executes.
  final Set<Type> mutations;

  @override
  Widget build(BuildContext context) {
    final stream = VxState.events.where(
      (e) => mutations.contains(e.runtimeType),
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
        return builder(ctx, VxState.store as T, status);
      },
    );
  }
}
