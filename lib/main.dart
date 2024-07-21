import 'package:bus_ticket_booker_flutter/firebase_options.dart';
import 'package:bus_ticket_booker_flutter/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetMaterialApp(
        title: 'Bus Ticket Booker',
        theme: ThemeData(
          useMaterial3: true,
        ),
        getPages: AppRoutes.routes(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
