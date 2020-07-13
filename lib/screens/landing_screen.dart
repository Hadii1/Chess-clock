import 'package:flutter/material.dart';
import 'package:liclock/screens/credits.dart';
import 'package:liclock/screens/custom_screen.dart';
import 'package:liclock/screens/initial_screen.dart';

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
            'Cheska',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              letterSpacing: 1,
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: Icon(Icons.launch),
                iconSize: 20,
                color: Colors.white,
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (_) {
                      return CreditScreen();
                    },
                  ),
                ),
              ),
            )
          ],
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
        body: TabBarView(
          children: <Widget>[
            InitialScreen(),
            CustomScreen(),
          ],
        ),
      ),
    );
  }
}
