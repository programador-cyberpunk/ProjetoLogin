import 'dart:js';

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
  try{
    final authResponse = await supabase.auth.signInWithPassword(
      email: _emailController.text.trim(),
      password> _passwordController.text.trim(),
    );
  if(authResponse.user != null && mounted){
    Navigator.off(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeTela()),;
  }

  }on AuthException catch (error){
    if(mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(error.message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),);
    }
    }
  catch (error){
    if(mounted){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Deu erro,tente outra vez'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),);
    }
  } finally{
    if(mounted){
      setState((){
        _isLoading = false;
      });
    }
  }
}

@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(title: const Text('Login')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) => (value == null || value.isEmpty) ? 'Campo obrigatório' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
              validator: (value) => (value == null || value.isEmpty) ? 'Campo obrigatório' : null,
            ),
            const SizedBox(height: 24),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _signIn,
              child: const Text('Entrar'),
            ),
          ],
        ),
      ),
    ),
  );
}
}

