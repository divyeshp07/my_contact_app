import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:using_objext_box/services/contact_services.dart';
import 'package:using_objext_box/view/pages/contact_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ContactServices.create();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: ContactAppobbx(),
    );
  }
}
