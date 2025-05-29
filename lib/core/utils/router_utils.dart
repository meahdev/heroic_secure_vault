import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/route_constants.dart';

class RouterUtils {
  static bool isCredentialScreen(BuildContext context) {
    final routeName = GoRouterState.of(context).name;
    return routeName == RouteConstants.credential;
  }
}
