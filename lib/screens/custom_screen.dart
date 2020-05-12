import 'package:flutter/material.dart';
import 'package:liclock/models/custom_timing_podo.dart';
import 'package:liclock/providers/chess_timer.dart';
import 'package:hive/hive.dart';
import 'package:liclock/widgets/playing_clock.dart';
import 'package:provider/provider.dart';
import 'custom_timing_screen.dart';

class CustomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box('Custom Timings');
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
                    itemBuilder: (BuildContext context, int index) {
                      final timing = box.getAt(index) as CustomTiming;
                      return buildCustomTimingelements(timing, context);
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(6),
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      backgroundColor: Colors.black87,
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) {
                            return CustomTimingScreen();
                          },
                        ),
                      ),
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

Widget buildCustomTimingelements(CustomTiming timing, BuildContext context) {
  final prov = Provider.of<ChessTimerProvider>(context);
  return Card(
    child: GridTile(
      child: InkResponse(
        onTap: () {
          prov.initValues(timing);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return PlayerCards(prov);
              },
            ),
          );
        },
        onLongPress: () => _showDialog(context, timing),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
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
              child: Text('${timing.clockName}',
                  style: TextStyle(
                    fontSize: 18,
                  )),
            )),
      ),
    ),
  );
}

_showDialog(BuildContext context, CustomTiming element) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteDialog(element);
      });
}

class DeleteDialog extends StatelessWidget {
  final Box box = Hive.box('Custom Timings');
  final CustomTiming element;
  DeleteDialog(this.element);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Text('Are you sure you want to delete this timing?'),
        actions: <Widget>[
          FlatButton(
              child: Text('Yes'),
              onPressed: () => {
                    for (int i = 0; i < box.length; i++)
                      {
                        if (box.getAt(i).clockName == element.clockName)
                          {box.deleteAt(i)}
                      },
                    Navigator.pop(context),
                  }),
          FlatButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          )
        ]);
  }
}
