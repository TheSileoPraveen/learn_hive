import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learn_hive/note_screen.dart';
import 'package:learn_hive/splace_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('notesData');
final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
  runApp(MyApp(isConnectedToInternet:connectivityResult.contains(ConnectivityResult.none)? false : true ));
}

class MyApp extends StatelessWidget {
  final bool isConnectedToInternet;
   const MyApp({super.key, required this.isConnectedToInternet});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:isConnectedToInternet? SplashScreen(): NoteScreen(),
    );
  }
}

