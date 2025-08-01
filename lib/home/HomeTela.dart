import 'package:flutter/material.dart';
import 'package:projeto_escola_login/main.dart';
import 'package:projeto_escola_login/educadores/add_educador_tela.dart';

class HomeTela extends StatefulWidget{
  const HomeTela({super.key});

 @override
  State<HomeTela> createState() => _HomeTelaState();
}

class _HomeTelaState extends State<HomeTela>{
  late final Future<List<Map<String, dynamic>>> _educadoresFuture;

 @override
 void initState(){
   super.initState();
   _educadoresFuture = _getEducadores();
 }
 Future<List<Map<String, dynamic>>> _getEducadores() async{
   // essa função aqui serve pra pegar a função RPC criada la no superbase
   final data = await supabase.rpc('get_educadores_contagem');
   return (data as List).map((item) => item as Map<String, dynamic>).toList();

   @override
   Widget build(BuildContext context){
     return Scaffold(
       appBar: AppBar(
         title: const Text('Educadores'),
         actions: [
           IconButton(icon:const Icon(Icons.logout)),
           onPressed: () async{
           await supabase.auth.signOut();
            if(mounted){
              Navigator.off(context).pushReplacement(MaterialPageRoute(builder: context) => const LoginTela()),
            }
           }
         ]
       ),
     );
   }
   body: FutureBuilder<List<Map<String, dynamic>>>(
     future: _educadoresFuture,
     builder: (context,snapshot){
       if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
       }
       if(!snapshot.hasData || snapshot.data!.isEmpty){
         return const Center(child: Text('Nenhum educador foi encontrado.'));
       }

       final educadores = snapshot.data!;

       return ListView.builder(
         itemCount: educadores.length,
         itemBuilder: (context, index){
           final educador = educadores[index];
           return ListTile(
             title: Text(educador['nome_completo']),
             subtitle: Text('Perfil: ${educador['perfil']}'),
             trailing: Text('Turmas: ${educador['total_turmas']}'),
           );
         },
       );
     },
   ),
   floatingActionButton: FloatingActionButton(
   onPressed: () {
   Navigator.of(context)
       .push(MaterialPageRoute(builder: (context) => const AddEducadorTela()))
       .then((_) => setState(() {
   _educadoresFuture = _getEducadores();
   }));
   },
   child: const Icon(Icons.add),
   ),
   );
 }
}
