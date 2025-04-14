import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trading_app/pages/loginpage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    try {
    await dotenv.load(fileName: "api.env"); // Ensure fileName is correct
    print(".env file loaded successfully");
  } catch (e) {
    print("Failed to load .env file: $e");
  }
  runApp(const MyApp());
}

/* Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
} */

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Trading App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}


