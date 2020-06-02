import 'package:flutter/material.dart';
import 'package:liclock/models/custom_timing_podo.dart';
import 'package:liclock/models/initial_timings_model.dart';
import 'package:liclock/providers/chess_timer.dart';
import 'package:liclock/widgets/playing_clock.dart';
import 'package:provider/provider.dart';
import 'credits.dart';

class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          children: <Widget>[
            Expanded(
              child: GridView.builder(
                itemCount: InitialTimingModel.initialTimings.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (_, index) {
                  return TimingSqaure(
                    InitialTimingModel.initialTimings[index],
                  );
                },
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(Icons.launch),
                color: Colors.black87.withOpacity(0.7),
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
              border: Border.all(width: 0.5, color: Colors.black87),
              boxShadow: [
                BoxShadow(color: Colors.white, blurRadius: 20, spreadRadius: 5)
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${timing.clockName}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '${timing.atimeMins} + ${timing.aInc}',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                    color: Colors.black87,
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
