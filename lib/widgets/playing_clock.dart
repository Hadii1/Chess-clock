import 'package:flutter/material.dart';
import 'package:liclock/models/custom_timing_podo.dart';
import 'package:liclock/providers/chess_timer.dart';
import 'package:provider/provider.dart';

class PlayingClock extends StatefulWidget {
  const PlayingClock(this._timing);
  final CustomTiming _timing;

  @override
  _PlayingClockState createState() => _PlayingClockState();
}

class _PlayingClockState extends State<PlayingClock>
    with WidgetsBindingObserver {
  TimerLogicProvider prov;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      prov.initValues(widget._timing);
    });

    super.initState();
  }

  @override
  void dispose() {
    prov.disposeTimers();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      prov.pause();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    prov = Provider.of<TimerLogicProvider>(context);
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
          Expanded(
              //B CARD:
              flex: 4,
              child: RotatedBox(
                  quarterTurns: 2,
                  child: InkWell(
                      splashColor: prov.aturn ? Colors.black87 : Colors.orange,
                      onTap: () {
                        if (!prov.btimeEnded) {
                          if (prov.playing) {
                            if (!prov.aturn) {
                              prov.cardPressed('b');
                            }
                          }
                        }
                      },
                      child: Stack(
                        children: <Widget>[
                          Card(
                            color: prov.btimeEnded
                                ? Colors.red
                                : prov.aturn
                                    ? Colors.grey[300]
                                    : Colors.black87,
                            child: Center(
                              child: Text(
                                prov.btextShown,
                                style: TextStyle(
                                    fontSize: 60,
                                    color: prov.aturn
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  prov.bDelay != 0
                                      ? 'Delay: ${prov.bDelay}s'
                                      : '',
                                  style: TextStyle(
                                      color: !prov.aturn
                                          ? Colors.white
                                          : Colors.black87,
                                      fontSize: 12),
                                ),
                                Text(
                                  prov.bInc != 0
                                      ? 'Increment: ${prov.bInc}s'
                                      : '',
                                  style: TextStyle(
                                      color: !prov.aturn
                                          ? Colors.white
                                          : Colors.black87,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          )
                        ],
                      )))),
          Expanded(
            flex: 1,
            child: Stack(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: FloatingActionButton(
                          elevation: 2,
                          backgroundColor: Colors.black87,
                          child: prov.playing
                              ? Icon(
                                  Icons.pause,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                ),
                          onPressed: () => prov.playPressed(),
                        )),
                    FloatingActionButton(
                      elevation: 2,
                      backgroundColor: Colors.black87,
                      child: Icon(
                        Icons.replay,
                        color: Colors.white,
                      ),
                      heroTag: 'tag2',
                      onPressed: () => prov.reset(),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 4),
                  alignment: Alignment.centerLeft,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Text(
                      'Moves: ${prov.moves}',
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              //A CARD:
              flex: 4,
              child: InkWell(
                  splashColor: prov.aturn ? Colors.orange : Colors.black87,
                  onTap: () => {
                        if (!prov.atimeEnded)
                          {
                            if (prov.playing)
                              {
                                if (prov.aturn) {prov.cardPressed('a')}
                              }
                          }
                      },
                  child: Stack(
                    children: <Widget>[
                      Card(
                          color: prov.atimeEnded
                              ? Colors.red
                              : prov.aturn ? Colors.black87 : Colors.grey[300],
                          child: Center(
                            child: Text(
                              prov.atextShown,
                              style: TextStyle(
                                  fontSize: 60,
                                  color:
                                      prov.aturn ? Colors.white : Colors.black),
                            ),
                          )),
                      Container(
                          padding: EdgeInsets.all(12),
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                prov.aDelay != 0
                                    ? 'Delay: ${prov.aDelay}s'
                                    : '',
                                style: TextStyle(
                                    color: prov.aturn
                                        ? Colors.white
                                        : Colors.black87,
                                    fontSize: 12),
                              ),
                              Text(
                                prov.aInc != 0
                                    ? 'Increment: ${prov.aInc}s'
                                    : '',
                                style: TextStyle(
                                    color: prov.aturn
                                        ? Colors.white
                                        : Colors.black87,
                                    fontSize: 12),
                              ),
                            ],
                          ))
                    ],
                  )))
        ]));
  }
}
