import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'app_state.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: (context, _) => MyApp(),
  ));
}
