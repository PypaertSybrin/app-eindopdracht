import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastytrade/firebase_options.dart';
import 'package:tastytrade/routes/auth/login.dart';
import 'package:tastytrade/services/local_notification_service.dart';
import 'package:tastytrade/services/get_recipes.dart';
import 'package:tastytrade/utils/navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetRecipes()),
        ChangeNotifierProvider(create: (_) => Navigation()),
      ],
      child: const MainApp(),
    ),
  );
  LocalNotificationService().init();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: Login());
  }
}
