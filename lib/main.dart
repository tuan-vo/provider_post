import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_post/register_page.dart';
import 'package:provider_post/register_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (ctx) => RegisterProvider())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const RegisterPage(),
      ),
    );
  }
}
