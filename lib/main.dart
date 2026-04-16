import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'views/splash_screen_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://qdsyiwotmadwgjlzzvnc.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFkc3lpd290bWFkd2dqbHp6dm5jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzYzMTkzMzUsImV4cCI6MjA5MTg5NTMzNX0.hlIAGxob-vt4C1vdjkHLzg1h96c3rTH66VNWQW_DPtQ',
  );

  runApp(const RunTrackerApp());
}

class RunTrackerApp extends StatelessWidget {
  const RunTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreenUi(),
      theme: ThemeData(
        textTheme: GoogleFonts.promptTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
