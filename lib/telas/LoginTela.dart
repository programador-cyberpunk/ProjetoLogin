import 'package:flutter/material.dart';
import  'package:projeto_escola_login/main.dart';
import 'package:projeto_escola_login/home/HomeTela.dart';
import 'package:api/supabase_service.dart';

class LoginTela extends StatefulWidget{
  const LoginTela({super.key});

 @override
  State<LoginTela> createState() => _LoginTelaState();
}

class _LoginTelaState extends State<LoginTela>{
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
}

Future<void> _signIn() async{
  if(_formKey.currentState!.validade()){
    setState((){ _isLoading = true;});
  }
}