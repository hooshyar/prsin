import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prsin/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prsin/src/services/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AuthProvider())],
      child: const MyApp(),
    ),
  );
}
