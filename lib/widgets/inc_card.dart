import 'package:flutter/material.dart';
import 'package:liclock/providers/custom_timing_provider.dart';
import 'package:provider/provider.dart';
import 'package:numberpicker/numberpicker.dart';

class IncCard extends StatefulWidget {
  @override
  _TimeCardState createState() => _TimeCardState();
}

class _TimeCardState extends State<IncCard> {
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
                                CustomDialog(context, prov, 1));
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
                                CustomDialog(context, prov, 2));
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
                    ? widget.prov.aincSec
                    : widget.prov.bincSec,
                minValue: 0,
                maxValue: 480,
                onChanged: (num a) {
                  setState(() {
                    widget.player == 1
                        ? widget.prov.aincSec = a
                        : widget.prov.bincSec = a;
                  });
                }),
          
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