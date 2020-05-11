import 'package:flutter/material.dart';
import 'package:liclock/widgets/delay_card.dart';
import 'package:liclock/widgets/time_card.dart';
import 'package:liclock/widgets/inc_card.dart';
import 'package:provider/provider.dart';
import 'package:liclock/providers/custom_timing_provider.dart';

class CustomTimingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CustomTimingProvider(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Custom Clock'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TimeCard(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: IncCard(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: DelayCard(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
