import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liclock/models/custom_timing_podo.dart';
import 'package:hive/hive.dart';
import 'package:liclock/providers/chess_timer.dart';
import 'package:liclock/providers/custom_timing_provider.dart';
import 'package:liclock/screens/playing_clock.dart';
import 'package:provider/provider.dart';
import 'custom_timing_screen.dart';

class CustomScreen extends StatefulWidget {
  @override
  _CustomScreenState createState() => _CustomScreenState();
}

class _CustomScreenState extends State<CustomScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _customTimingsBox = Hive.box<CustomTiming>('Custom Timings');
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  GridView.builder(
                    itemCount: _customTimingsBox.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    padding: const EdgeInsets.all(6),
                    itemBuilder: (BuildContext context, int index) {
                      CustomTiming timing = _customTimingsBox.getAt(index);
                      return CustomTimingSqaure(
                        timing: timing,
                        onTimingDeleted: () {
                          setState(
                            () {},
                          ); //to remove the deleted element from UI
                        },
                      );
                    },
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 32, right: 16),
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      backgroundColor: Colors.black87,
                      onPressed: () async {
                        await Navigator.of(context).push(
                          CupertinoPageRoute(
                            fullscreenDialog: true,
                            builder: (_) {
                              return ChangeNotifierProvider(
                                create: (context) => CustomTimingProvider(),
                                child: CustomTimingScreen(),
                              );
                            },
                          ),
                        );

                        if (mounted) {
                          setState(
                              () {}); //To show the added timing if there was any
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
                    create: (_) => TimerLogicProvider(),
                    child: PlayingClock(widget.timing),
                  );
                },
              ),
            );
          },
          onLongPress: () => _deleteTiming(),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color:
                  _isDialogShown ? Theme.of(context).accentColor : Colors.white,
              shape: BoxShape.rectangle,
              border: Border.all(width: 0.5, color: Colors.black87),
            ),
            child: Center(
              child: Text(
                '${widget.timing.clockName}',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _deleteTiming() async {
    setState(() {
      _isDialogShown = true;
    });

    bool deleteTiming = await showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          content: Text('Are you sure you want to delete this timing?'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Yes'),
              isDestructiveAction: true,
              onPressed: () => Navigator.of(context).pop(true),
            ),
            CupertinoDialogAction(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ],
        );
      },
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
  }
}
