import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path_prov;
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:liclock/models/custom_timing_podo.dart';
import 'screens/landing_screen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      theme: Theme.of(context).copyWith(
        accentColor: Colors.orange,
        splashColor: Colors.orange.withOpacity(0.2),
      ),
      title: 'Hadi Chess Clock',
      home: FutureBuilder(
        future: _initHive(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('Error');
            } else {
              return LandingScreen();
            }
          } else
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black87,
                ),
              ),
            );
        },
      ),
    );
  }

  Future<void> _initHive() async {
    final documentDir = await path_prov.getApplicationDocumentsDirectory();
    Hive.init(documentDir.path);
    Hive.registerAdapter(CustomTimingAdapter());
    Hive.openBox('Custom Timings');
  }
}
