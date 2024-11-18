import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';

import '../util/constants.dart';

extension IterableX<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  E? lastWhereOrNull(bool Function(E element) test) {
    E? result;
    for (final element in this) {
      if (test(element)) result = element;
    }
    return result;
  }

  E? get firstOrNull => isNotEmpty ? first : null;

  E? get lastOrNull => isNotEmpty ? last : null;
}

extension DialogShowMethod on material.Widget {
  /// Don't use this when dialog children depend on [context] or need [State.setState]
  Future<T?> showDialog<T>(material.BuildContext? context,
      {bool barrierDismissible = true, bool useRootNavigator = false}) {
    final effectiveContext = context ?? kAppKey.currentContext;
    if (effectiveContext == null) return Future.value();
    return material.showDialog<T>(
      context: effectiveContext,
      builder: (context) => this,
      barrierDismissible: barrierDismissible,
      useRootNavigator: useRootNavigator,
    );
  }
}

extension DENumberUtils<E extends num> on E {
  E withMinimum(E min) {
    if (this < min) return min;
    return this;
  }

  E withMaximum(E max) {
    if (this > max) return max;
    return this;
  }
}

extension DEWidgetsSeparator on Iterable<Widget> {
  Iterable<Widget> addSeparators(
      {required Widget separator, int skipFirst = 0}) sync* {
    final iterator = this.iterator;
    var count = 0;

    while (iterator.moveNext()) {
      if (count < skipFirst) {
        yield iterator.current;
      } else {
        yield separator;
        yield iterator.current;
      }
      count++;
    }
  }
}
