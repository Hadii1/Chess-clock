import 'package:flutter/material.dart';
import 'package:liclock/models/custom_timing_podo.dart';
import 'package:liclock/models/initial_timings_model.dart';
import 'package:liclock/providers/chess_timer.dart';
import 'package:liclock/screens/playing_clock.dart';
import 'package:provider/provider.dart';

class InitialScreen extends StatelessWidget {
  final List<CustomTiming> _builtInTimings = InitialTimingModel.initialTimings;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: GridView.count(
          crossAxisCount: 3,
          children: _builtInTimings
              .map(
                (timing) => TimingSqaure(
                  timing,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class TimingSqaure extends StatelessWidget {
  const TimingSqaure(
    this.timing,
  );

  final CustomTiming timing;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkResponse(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return ChangeNotifierProvider(
                  create: (_) => TimerLogicProvider(),
                  child: PlayingClock(timing),
                );
              },
            ),
          );
        },
        child: GridTile(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle,
              border: Border.all(width: 0.4, color: Colors.black87),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${timing.clockName}',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                    color: Colors.black87,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    '${timing.atimeMins} + ${timing.aInc}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
