import 'package:flutter/material.dart';
import 'package:liclock/funcs.dart';
import 'package:liclock/models/initial_timings_model.dart';
import 'package:liclock/providers/chess_timer.dart';
import 'package:liclock/widgets/playing_clock.dart';
import 'package:provider/provider.dart';
import 'credits.dart';

class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ChessTimerProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          children: <Widget>[
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                children: <Widget>[
                  ...buildInitialTimingElements(prov, context)
                ],
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

List<Widget> buildInitialTimingElements(var prov, BuildContext context) {
  return InitialTimingModel.getTimingsList()
      .map((element) => Card(
            child: InkResponse(
              onTap: () {
                initializeProviderValues(element, prov);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return PlayerCards();
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
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 20,
                              spreadRadius: 5)
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${element.atimeMins} + ${element.aInc}',
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.w300),
                        ),
                        Text(
                          '${element.clockName}',
                        ),
                      ],
                    )),
              ),
            ),
          ))
      .toList();
}
