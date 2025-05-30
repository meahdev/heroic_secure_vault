import 'dart:async';

import 'package:flutter/cupertino.dart';

/// A helper class that listens to a stream and notifies listeners on stream events.
///
/// This is useful for integrating streams with [ChangeNotifier] based widgets
/// such as when using GoRouter for routing and needing to refresh navigation
/// on stream updates.
class GoRouterRefreshStreamHelper extends ChangeNotifier {
  /// Subscribes to the given [stream] and notifies listeners whenever the stream emits an event.
  GoRouterRefreshStreamHelper(Stream<dynamic> stream) {
    // Use broadcast stream to allow multiple listeners if needed
    _subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  // Internal subscription to the stream.
  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    // Cancel the stream subscription to avoid memory leaks.
    _subscription.cancel();
    super.dispose();
  }
}
