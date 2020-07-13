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
                padding: EdgeInsets.symmetric(vertical: 16),
                child: IncCard(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: DelayCard(),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: TextField(
                  maxLength: 12,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w200,
                    ),
                    counter: SizedBox.shrink(),
                    labelText: 'Clock Name',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.3,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.3,
                        color: Theme.of(context).accentColor,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (String value) => prov.clockName = value,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: AnimatedCrossFade(
                  crossFadeState: prov.isRightFormat()
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: Duration(milliseconds: 300),
                  firstChild: Container(
                    width: double.maxFinite,
                    child: RaisedButton(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: Colors.black87,
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        prov.saveData();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  secondChild: Container(
                    width: double.maxFinite,
                    child: RaisedButton(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      disabledColor: Colors.grey,
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: null,
                    ),
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
          padding: EdgeInsets.fromLTRB(6, 6, 0, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.arrow_right),
              Text(
                'Equal Timings:',
                style: TextStyle(fontSize: 16),
              ),
              RoundedCheckBox(
                onChanged: (value) {
                  prov.equalTiming = value;
                },
                value: prov.equalTiming,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: FlatButton(
                child: Text(
                  '${prov.convertToTextFormat(prov.atimeHours)}:${prov.convertToTextFormat(prov.atimeMins)}:${prov.convertToTextFormat(prov.atimeSec)}',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => TimeDialog(player: 1, provider: prov),
                  );
                },
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: FlatButton(
                child: Text(
                  '${prov.convertToTextFormat(prov.btimeHours)}:${prov.convertToTextFormat(prov.btimeMins)}:${prov.convertToTextFormat(prov.btimeSec)}',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => TimeDialog(player: 2, provider: prov),
                  );
                },
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
        padding: EdgeInsets.only(top: 24),
        height: 250,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Hours',
                        style: TextStyle(fontSize: 16),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 1),
                        child: Text(
                          '_____',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
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
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Minutes',
                        style: TextStyle(fontSize: 16),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 1),
                        child: Text(
                          '_____',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
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
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Seconds',
                        style: TextStyle(fontSize: 16),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 1),
                        child: Text(
                          '_____',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
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
                    ],
                  ),
                ),
              ],
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
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: FlatButton(
                child: Text(
                  '${prov.aincSec}',
                  style: TextStyle(fontSize: 16),
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
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: FlatButton(
                child: Text(
                  '${prov.bincSec}',
                  style: TextStyle(fontSize: 16),
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
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 1),
              child: Text(
                '_____',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey,
                ),
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
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: FlatButton(
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Theme.of(context).accentColor),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: FlatButton(
                  child: Text(
                    '${prov.adelaySec}',
                    style: TextStyle(fontSize: 16),
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
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: FlatButton(
                  child: Text(
                    '${prov.bdelaySec}',
                    style: TextStyle(fontSize: 16),
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
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 1),
              child: Text(
                '_____',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
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
              alignment: Alignment.center,
              child: FlatButton(
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Theme.of(context).accentColor),
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

class RoundedCheckBox extends StatelessWidget {
  const RoundedCheckBox({@required this.onChanged, @required this.value});
  final Function(bool) onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          onChanged(!value);
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: value ? Colors.black : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: value ? 0 : 1,
              color: Colors.grey,
            ),
          ),
          child: Center(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: value
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    )
                  : SizedBox.shrink(),
            ),
          ),
        ),
      ),
    );
  }
}
