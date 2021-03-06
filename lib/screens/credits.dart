import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Credits'),
        backgroundColor: Colors.black87,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(8, 24, 0, 0),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                ),
                children: [
                  TextSpan(
                    text: '• Rate Us',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w300,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        LaunchReview.launch(
                          iOSAppId: '1523219613',
                          androidAppId: 'devs.hadi_chess_clock',
                        );
                      },
                  ),
                  TextSpan(
                    text: ' on Google play.',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8, 36, 0, 0),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                ),
                children: [
                  TextSpan(
                    text: '• Application icon was created by Freepik on:\n',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  TextSpan(
                      text: '  https://www.flaticon.com/authors/freepik',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).accentColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launch('https://www.flaticon.com/authors/freepik');
                        })
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8, 36, 0, 48),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                ),
                children: [
                  TextSpan(
                    text: '• Developer contact:\n',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  TextSpan(
                    text: '  Hadi.Hammoud@live.com',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Theme.of(context).accentColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launch('mailto:hadi.hammoud@live.com');
                      },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
