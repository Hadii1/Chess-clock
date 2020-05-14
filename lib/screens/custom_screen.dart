import 'package:flutter/material.dart';
import 'package:liclock/models/custom_timing_podo.dart';
import 'package:hive/hive.dart';
import 'package:liclock/providers/chess_timer.dart';
import 'package:liclock/widgets/playing_clock.dart';
import 'package:provider/provider.dart';
import 'custom_timing_screen.dart';

class CustomScreen extends StatefulWidget {
  @override
  _CustomScreenState createState() => _CustomScreenState();
}

class _CustomScreenState extends State<CustomScreen> {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box<CustomTiming>('Custom Timings');
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  GridView.builder(
                    itemCount: box.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    padding: const EdgeInsets.all(6),
                    itemBuilder: (BuildContext context, int index) {
                      CustomTiming timing = box.getAt(index);
                      return CustomTimingSqaure(
                        timing: timing,
                        onTimingDeleted: () {
                          setState(() {});
                        },
                      );
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(6),
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      backgroundColor: Colors.black87,
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) {
                            return CustomTimingScreen();
                          },
                        );
                        if (mounted) {
                          setState(() {});
                        }
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      splashColor: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTimingSqaure extends StatefulWidget {
  const CustomTimingSqaure({
    @required this.timing,
    @required this.onTimingDeleted,
  });
  final CustomTiming timing;
  final Function onTimingDeleted;

  @override
  _CustomTimingSqaureState createState() => _CustomTimingSqaureState();
}

class _CustomTimingSqaureState extends State<CustomTimingSqaure> {
  bool _isDialogShown = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GridTile(
        child: InkResponse(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return ChangeNotifierProvider(
                    create: (_) => ChessTimerProvider(),
                    child: PlayingClock(widget.timing),
                  );
                },
              ),
            );
          },
          onLongPress: () async {
            setState(() {
              _isDialogShown = true;
            });

            bool deleteTiming = await showDialog(
              barrierDismissible: false,
              context: context,
              child: AlertDialog(
                content: Text('Are you sure you want to delete this timing?'),
                actions: <Widget>[
                  FlatButton(
                      child: Text(
                        'Yes',
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                      onPressed: () => Navigator.of(context).pop(true)),
                  FlatButton(
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                    onPressed: () => Navigator.of(context).pop(false),
                  )
                ],
              ),
            );

            if (deleteTiming) {
              var box = Hive.box<CustomTiming>('Custom Timings');
              for (int i = 0; i < box.length; i++) {
                print(box.getAt(i).clockName);
                if (box.getAt(i).clockName == widget.timing.clockName) {
                  box.deleteAt(i);
                  widget.onTimingDeleted();
                }
              }
            }

            setState(() {
              _isDialogShown = false;
            });
          },
          child: AnimatedContainer(
              duration: Duration(milliseconds: 250),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: _isDialogShown
                      ? Theme.of(context).accentColor
                      : Colors.white,
                  shape: BoxShape.rectangle,
                  border: Border.all(width: 0.5, color: Colors.black87),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 5,
                      blurRadius: 20,
                    )
                  ]),
              child: Center(
                child: Text(
                  '${widget.timing.clockName}',
                  style: TextStyle(fontSize: 18),
                ),
              )),
        ),
      ),
    );
  }
}
