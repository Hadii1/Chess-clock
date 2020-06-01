import 'package:flutter/material.dart';
import 'package:liclock/providers/custom_timing_provider.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class CustomTimingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<CustomTimingProvider>(context);
    return Scaffold(
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
              Container(
                padding: EdgeInsets.all(24),
                child: TextField(
                  maxLength: 12,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black87),
                    labelText: 'Clock Name',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                  onChanged: (String value) => prov.clockName = value,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: RaisedButton(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    color: Colors.black87,
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (!prov.isRightFormat()) {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Enter a valid Time',
                            ),
                          ),
                        );
                        return;
                      }

                      prov.saveData();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeCard extends StatelessWidget {
  Widget build(BuildContext context) {
    final prov = Provider.of<CustomTimingProvider>(context);

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(4, 4, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.arrow_right),
              Padding(
                padding: EdgeInsets.all(4),
                child: Text('Equal Timings:'),
              ),
              Checkbox(
                value: prov.equalTiming,
                checkColor: Colors.white,
                activeColor: Colors.black87,
                onChanged: (bool value) {
                  prov.equalTiming = value;
                },
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(12, 8, 0, 2),
          alignment: Alignment.topLeft,
          child: Center(
            child: Text(
              'Time',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w300),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Card(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: FlatButton(
                  child: Text(
                    '${prov.convertToTextFormat(prov.atimeHours)}:${prov.convertToTextFormat(prov.atimeMins)}:${prov.convertToTextFormat(prov.atimeSec)}',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          TimeDialog(player: 1, provider: prov),
                    );
                  },
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: FlatButton(
                  child: Text(
                    '${prov.convertToTextFormat(prov.btimeHours)}:${prov.convertToTextFormat(prov.btimeMins)}:${prov.convertToTextFormat(prov.btimeSec)}',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          TimeDialog(player: 2, provider: prov),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TimeDialog extends StatefulWidget {
  final int player;
  final CustomTimingProvider provider;
  TimeDialog({@required this.player, @required this.provider});

  @override
  _TimeDialogState createState() => _TimeDialogState();
}

class _TimeDialogState extends State<TimeDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetAnimationCurve: Curves.easeInOut,
      insetAnimationDuration: const Duration(seconds: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        height: 250,
        width: 350,
        padding: EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  'Hours',
                  style: TextStyle(fontSize: 18),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 1),
                  child: Text(
                    '_____',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                ),
                NumberPicker.integer(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  highlightSelectedValue: true,
                  itemExtent: 40,
                  step: 1,
                  initialValue: widget.player == 1
                      ? widget.provider.atimeHours
                      : widget.provider.btimeHours,
                  minValue: 0,
                  maxValue: 10,
                  onChanged: (num a) {
                    widget.player == 1
                        ? widget.provider.atimeHours = a
                        : widget.provider.btimeHours = a;
                    setState(
                        () {}); //to highlight selected values in the dialog
                  },
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Minutes',
                  style: TextStyle(fontSize: 18),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 1),
                  child: Text(
                    '_____',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                ),
                NumberPicker.integer(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.grey.withOpacity(0.2)),
                  itemExtent: 40,
                  highlightSelectedValue: true,
                  initialValue: widget.player == 1
                      ? widget.provider.atimeMins
                      : widget.provider.btimeMins,
                  minValue: 0,
                  maxValue: 60,
                  onChanged: (num a) {
                    widget.player == 1
                        ? widget.provider.atimeMins = a
                        : widget.provider.btimeMins = a;
                    setState(
                        () {}); //to highlight selected values in the dialog
                  },
                )
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  'Seconds',
                  style: TextStyle(fontSize: 18),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 1),
                  child: Text(
                    '_____',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                ),
                NumberPicker.integer(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.grey.withOpacity(0.2)),
                  highlightSelectedValue: true,
                  itemExtent: 40,
                  initialValue: widget.player == 1
                      ? widget.provider.atimeSec
                      : widget.provider.btimeSec,
                  minValue: 0,
                  maxValue: 60,
                  onChanged: (num a) {
                    widget.player == 1
                        ? widget.provider.atimeSec = a
                        : widget.provider.btimeSec = a;
                    setState(
                        () {}); //to highlight selected values in the dialog
                  },
                ),
                FlatButton(
                  splashColor: Colors.orange,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(top: 6),
                    child: Text(
                      'Confirm',
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class IncCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<CustomTimingProvider>(context);

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(12, 8, 0, 2),
          alignment: Alignment.topLeft,
          child: Center(
              child: Text(
            'Increment',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w300),
          )),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: 80,
                child: Card(
                  child: Center(
                    child: FlatButton(
                      child: Text(
                        '${prov.aincSec}',
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              IncrementDialog(player: 1, provider: prov),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 80,
                child: Card(
                  child: Center(
                    child: FlatButton(
                      child: Text(
                        '${prov.bincSec}',
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              IncrementDialog(player: 2, provider: prov),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ]),
      ],
    );
  }
}

class IncrementDialog extends StatefulWidget {
  final int player;
  final CustomTimingProvider provider;

  IncrementDialog({@required this.player, @required this.provider});

  @override
  _IncrementDialogState createState() => _IncrementDialogState();
}

class _IncrementDialogState extends State<IncrementDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetAnimationCurve: Curves.easeInOut,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        height: 250,
        width: 250,
        padding: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Text(
                'Seconds',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 1),
              child: Text(
                '_____',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
            ),
            NumberPicker.integer(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.grey.withOpacity(0.2)),
              highlightSelectedValue: true,
              itemExtent: 40,
              initialValue: widget.player == 1
                  ? widget.provider.aincSec
                  : widget.provider.bincSec,
              minValue: 0,
              maxValue: 480,
              onChanged: (num a) {
                widget.player == 1
                    ? widget.provider.aincSec = a
                    : widget.provider.bincSec = a;
                setState(() {}); //to highlight selected values in the dialog
              },
            ),
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: FlatButton(
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.black87),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DelayCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<CustomTimingProvider>(context);

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(12, 8, 0, 2),
          alignment: Alignment.topLeft,
          child: Center(
            child: Text(
              'Simple Delay',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w300),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              width: 80,
              child: Card(
                child: Center(
                  child: FlatButton(
                    child: Text(
                      '${prov.adelaySec}',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            DelayDialog(player: 1, provider: prov),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 80,
              child: Card(
                child: Center(
                  child: FlatButton(
                    child: Text(
                      '${prov.bdelaySec}',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            DelayDialog(player: 2, provider: prov),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DelayDialog extends StatefulWidget {
  final int player;
  final CustomTimingProvider provider;
  DelayDialog({@required this.player, @required this.provider});

  @override
  _DelayDialogState createState() => _DelayDialogState();
}

class _DelayDialogState extends State<DelayDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetAnimationCurve: Curves.easeInOut,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        height: 250,
        width: 250,
        padding: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Text(
                'Seconds',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 1),
              child: Text(
                '_____',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
            ),
            NumberPicker.integer(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(2),
                color: Colors.grey.withOpacity(0.2),
              ),
              highlightSelectedValue: true,
              itemExtent: 40,
              initialValue: widget.player == 1
                  ? widget.provider.adelaySec
                  : widget.provider.bdelaySec,
              minValue: 0,
              maxValue: 480,
              onChanged: (num a) {
                widget.player == 1
                    ? widget.provider.adelaySec = a
                    : widget.provider.bdelaySec = a;
                setState(() {}); //to highlight selected values in the dialog
              },
            ),
            Container(
              padding: EdgeInsets.all(6),
              alignment: Alignment.bottomRight,
              child: FlatButton(
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.black87),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
