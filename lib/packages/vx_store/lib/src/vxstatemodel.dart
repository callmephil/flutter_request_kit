part of 'vxstate.dart';

/// Tracks the listener widgets and notify them when
/// their corresponding mutation executes
class VxStateModel extends InheritedModel<Widget> {
  const VxStateModel({super.key, required super.child, this.recent});
  final Set<Type>? recent;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      oldWidget.hashCode != recent.hashCode;

  @override
  bool updateShouldNotifyDependent(
    covariant InheritedModel<Widget> oldWidget,
    Set<Widget> dependencies,
  ) {
    // check if there is a mutation executed for which
    // dependent has listened
    return dependencies.intersection(recent!).isNotEmpty;
  }
}
