import 'package:flutter/material.dart';
import  'package:projeto_escola_login/telas/LoginTela.dart';
import 'package:api/supabase_service.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.iniatilize(
    url: 'https://supabase.com/dashboard/project/hpgbaucheruzuwipnxnc',
    anonKey: '',
  );
 runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});
}
@override
Widget build(BuildContext context){
  return MaterialApp(
    title: 'Gestão escolar',
    theme: ThemeData(
      primarySwatch: Colors.indigo, useMaterial3: true,
    ),
    home: const LoginTela(),
  );
}
