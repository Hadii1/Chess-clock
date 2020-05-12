import 'package:flutter/material.dart';
import 'package:liclock/providers/chess_timer.dart';
import 'package:liclock/screens/custom_screen.dart';
import 'package:liclock/screens/initial_screen.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          centerTitle: true,
          title: Text(
            'Hadi Chess Clock',
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Initial',
              ),
              Tab(
                text: 'Custom',
              )
            ],
          ),
        ),
        body: ChangeNotifierProvider<ChessTimerProvider>(
          create: (_) => ChessTimerProvider(),
          child: TabBarView(
            children: <Widget>[
              InitialScreen(),
              CustomScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
