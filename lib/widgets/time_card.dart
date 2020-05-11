import 'package:flutter/material.dart';
import 'package:liclock/providers/custom_timing_provider.dart';
import 'package:provider/provider.dart';
import 'package:numberpicker/numberpicker.dart';

class TimeCard extends StatefulWidget {
  @override
  _TimeCardState createState() => _TimeCardState();
}

class _TimeCardState extends State<TimeCard> {
  @override
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
          )),
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
                        builder: (context) => CustomDialog(context, prov, 1));
                  },
                ),
              )),
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
                          builder: (context) => CustomDialog(context, prov, 2));
                    },
                  ),
                ),
              ),
            ]),
      ],
    );
  }
}

class CustomDialog extends StatefulWidget {
  final BuildContext context;
  final CustomTimingProvider prov;
  final int player;
  CustomDialog(this.context, this.prov, this.player);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
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
                        color: Colors.grey.withOpacity(0.2)),
                    highlightSelectedValue: true,
                    itemExtent: 40,
                    step: 1,
                    initialValue: widget.player == 1
                        ? widget.prov.atimeHours
                        : widget.prov.btimeHours,
                    minValue: 0,
                    maxValue: 10,
                    onChanged: (num a) {
                      setState(() {
                        widget.player == 1
                            ? widget.prov.atimeHours = a
                            : widget.prov.btimeHours = a;
                      });
                    }),
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
                        ? widget.prov.atimeMins
                        : widget.prov.btimeMins,
                    minValue: 0,
                    maxValue: 60,
                    onChanged: (num a) {
                      setState(() {
                        widget.player == 1
                            ? widget.prov.atimeMins = a
                            : widget.prov.btimeMins = a;
                      });
                    })
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
                        ? widget.prov.atimeSec
                        : widget.prov.btimeSec,
                    minValue: 0,
                    maxValue: 60,
                    onChanged: (num a) {
                      setState(() {
                        widget.player == 1
                            ? widget.prov.atimeSec = a
                            : widget.prov.btimeSec = a;
                      });
                    }),
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
