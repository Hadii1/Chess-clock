import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:quiver/async.dart';
import 'package:audioplayers/audio_cache.dart';

class ChessTimerProvider with ChangeNotifier {
  //100 and 0 means nothing, just to avoid null
  AudioCache audioCache;

  ChessTimerProvider() {
    audioCache = AudioCache();

    audioCache.load('tick.mp3');
    audioCache.load('meow.mp3');
  }
  // 100 & 0 just for avoiding null
  int _btotalMs = 100;
  int _atotalMs = 100;
  int _ainc = 0;
  int _binc = 0;
  int _adelay = 0;
  int _bdelay = 0;
  int _atemp = 0;
  int _btemp = 0;
  int _moves = 0;

  bool _aturn = true;
  bool _playing = false;
  bool _atimeEnded = false;
  bool _btimeEnded = false;
  bool _firstStart = true;

  String _atextShown = '';
  String _btextShown = '';
  set atemp(int number) {
    _atemp = number;
    notifyListeners();
  }

  set btemp(int number) {
    _btemp = number;
    notifyListeners();
  }

  set moves(int number) {
    _moves = number;
    notifyListeners();
  }

  set aDelay(int value) {
    _adelay = value;
    notifyListeners();
  }

  set bDelay(int value) {
    _bdelay = value;
    notifyListeners();
  }

  set ainc(int value) {
    _ainc = value;
    notifyListeners();
  }

  set playing(bool value) {
    _playing = value;
    notifyListeners();
  }

  set atotalMs(int value) {
    _atotalMs = value;
    notifyListeners();
  }

  set binc(int value) {
    _binc = value;
    notifyListeners();
  }

  set atextShown(String value) {
    _atextShown = value;
    notifyListeners();
  }

  set btotalMs(int value) {
    _btotalMs = value;
    notifyListeners();
  }

  set btextShown(String value) {
    _btextShown = value;
    notifyListeners();
  }

  set aturn(bool value) {
    _aturn = value;
    notifyListeners();
  }

  set atimeEnded(bool value) {
    _atimeEnded = value;
    notifyListeners();
  }

  set btimeEnded(bool value) {
    _btimeEnded = value;
    notifyListeners();
  }

  get atotalMs => _atotalMs;
  get btotalMs => _btotalMs;
  get aDelay => _adelay;
  get bDelay => _bdelay;
  get atextShown => _atextShown;
  get btextShown => _btextShown;
  get playing => _playing;
  get aturn => _aturn;
  get btimeEnded => _btimeEnded;
  get atimeEnded => _atimeEnded;
  get aInc => _ainc;
  get bInc => _binc;
  get moves => _moves;
  get atemp => _atemp;
  get btemp => _btemp;

  CountdownTimer _acountdownTimer;
  CountdownTimer _bcountdownTimer;

  Timer _adelayTimer;
  Timer _bdelayTimer;

  StreamSubscription<CountdownTimer> _alistener;
  StreamSubscription<CountdownTimer> _blistener;

  String timeFormat(int totalMillis) {
    double totalSec = totalMillis / 1000;
    int hours = totalSec ~/ 3600;
    int mins = (totalSec - hours * 3600) ~/ 60;
    double sec = totalSec - hours * 3600 - mins * 60;
    if (hours == 0) {
      if (mins == 0) {
        if (sec < 1) {
          return sec.toString();
        }
        return _formatSeconds(sec);
      }
      return ('${_format(mins)}:${_format(sec.toInt())}');
    }
    return ('$hours:${_format(mins)}:${_format(sec.toInt())}');
  }

  String _format(int number) {
    String formatedNumber;
    number.toString().length == 1
        ? formatedNumber = '0$number'
        : formatedNumber = '${number.toString()}';
    return formatedNumber;
  }

  String _formatSeconds(double number) {
    return number.toInt().toString().length == 1
        ? number.toString().substring(0, 3)
        : number.toString().substring(0, 4);
  }

  cardPressed(String player) {
    audioCache.play('tick.mp3', mode: PlayerMode.LOW_LATENCY);

    _disableSecondPlayer(player);

    if (player == 'a') {
      if (_adelayTimer.isActive) {
        _adelayTimer.cancel();
        _atemp = _atemp + aInc * 1000;
      } else {
        _atemp = _acountdownTimer.remaining.inMilliseconds + aInc * 1000;
        _acountdownTimer.cancel();
      }

      atextShown = (timeFormat(_atemp));
      _startTimer(2);
    } else {
      moves++;

      if (_bdelayTimer.isActive) {
        _bdelayTimer.cancel();
        _btemp = _btemp + _binc * 1000;
      } else {
        _btemp = _bcountdownTimer.remaining.inMilliseconds + _binc * 1000;
        _bcountdownTimer.cancel();
      }

      btextShown = timeFormat(_btemp);
      _startTimer(1);
    }
  }

  _startTimer(int player) {
    if (player == 1) {
      _adelayTimer = Timer(Duration(seconds: aDelay), () {
        _acountdownTimer = CountdownTimer(
            Duration(milliseconds: atemp), Duration(milliseconds: 100));
        _initializeAListener();
      });
    } else {
      _bdelayTimer = Timer(Duration(seconds: bDelay), () {
        _bcountdownTimer = CountdownTimer(
            Duration(milliseconds: btemp), Duration(milliseconds: 100));
        _initializeBListener();
      });
    }
  }

  _disableSecondPlayer(String player) {
    if (player == 'a') {
      aturn = false;
    } else {
      aturn = true;
    }
  }

  playPressed() {
    if (atimeEnded || btimeEnded) {
      return;
    }
    playing = !playing;

    if (_firstStart) {
      _firstStart = false;
      _startTimer(1);
      return;
    } else {
      //not first start
      if (!playing) {
        //pause game

        if (aturn) {
          if (_adelayTimer.isActive) {
            _adelayTimer.cancel();
          } else {
            atemp = _acountdownTimer.remaining.inMilliseconds;
            _acountdownTimer.cancel();
          }
        } else {
          if (_bdelayTimer.isActive) {
            _bdelayTimer.cancel();
          } else {
            btemp = _bcountdownTimer.remaining.inMilliseconds;
            _bcountdownTimer.cancel();
          }
        }
      } else {
        //Resume

        if (aturn) {
          _acountdownTimer = CountdownTimer(
              Duration(milliseconds: atemp), Duration(milliseconds: 100));
          _initializeAListener();
        } else {
          _bcountdownTimer = CountdownTimer(
              Duration(milliseconds: btemp), Duration(milliseconds: 100));
          _initializeBListener();
        }
      }
    }
  }

  disposeTimers() {
    print('disposing timers');
    if (_acountdownTimer != null) {
      _acountdownTimer.cancel();
    }
    if (_bcountdownTimer != null) {
      _bcountdownTimer.cancel();
    }

    if (_adelayTimer != null) {
      _adelayTimer.cancel();
    }

    if (_bdelayTimer != null) {
      _bdelayTimer.cancel();
    }
  }

  reset() {
    disposeTimers();
    moves = 0;
    atimeEnded = false;
    btimeEnded = false;
    playing = false;
    aturn = true;
    _firstStart = true;
    atemp = atotalMs;
    btemp = btotalMs;
    atextShown = timeFormat(atotalMs);
    btextShown = timeFormat(btotalMs);
  }

  _initializeAListener() {
    _alistener = _acountdownTimer.listen(null);

    _alistener.onData((duration) {
      if (_acountdownTimer.remaining.inMilliseconds < 20) {
        playing = false;
        audioCache.play('meow.mp3', mode: PlayerMode.LOW_LATENCY);
        atimeEnded = true;
        atextShown = ('00:00');
        disposeTimers();
        return;
      }
      atextShown = timeFormat(_acountdownTimer.remaining.inMilliseconds);
    });
  }

  _initializeBListener() {
    _blistener = _bcountdownTimer.listen(null);

    _blistener.onData((duration) {
      if (_bcountdownTimer.remaining.inMilliseconds < 20) {
        playing = false;
        audioCache.play('meow.mp3', mode: PlayerMode.LOW_LATENCY);
        btimeEnded = true;
        btextShown = ('00:00');
        disposeTimers();
        return;
      }
      btextShown = timeFormat(_bcountdownTimer.remaining.inMilliseconds);
    });
  }

  void pause() {
    if (playing) {
      playPressed();
    }
  }
}
