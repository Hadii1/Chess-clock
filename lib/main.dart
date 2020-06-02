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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      theme: ThemeData(
        accentColor: Colors.orange,
        splashColor: Colors.orange,
      ),
      title: 'Cheska',
      home: InitScreen(),
    );
  }
}

//Init the local storage
class InitScreen extends StatefulWidget {
  InitScreen({Key key}) : super(key: key);

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  void initState() {
    _initHive();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<void> _initHive() async {
    final documentDir = await path_prov.getApplicationDocumentsDirectory();
    Hive.init(documentDir.path);
    Hive.registerAdapter(CustomTimingAdapter());
    Hive.openBox<CustomTiming>('Custom Timings');
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) {
              return LandingScreen();
            },
          ),
        );
      },
    );
  }
}
