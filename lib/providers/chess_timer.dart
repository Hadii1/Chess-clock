import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:liclock/models/custom_timing_podo.dart';
import 'package:quiver/async.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:liclock/extension_util.dart';

class ChessTimerProvider with ChangeNotifier {
  //100 and 0 means nothing, just to avoid null
  AudioCache audioCache;

  ChessTimerProvider() {
    audioCache = AudioCache();

    audioCache.load('tick.mp3');
    audioCache.load('meow.mp3');
  }

  void initValues(CustomTiming timing) {
    int atimeMs, btimeMs;
    reset();
    atimeMs =
        (timing.atimeHours * 3600 + timing.atimeMins * 60 + timing.atimeSec) *
            1000;
    btimeMs =
        (timing.btimeHours * 3600 + timing.btimeMins * 60 + timing.btimeSec) *
            1000;

    atotalMs = atimeMs;
    btotalMs = btimeMs;
    ainc = timing.aInc;
    binc = timing.bInc;
    aDelay = timing.aDelay;
    bDelay = timing.bDelay;
    atemp = atimeMs;
    btemp = btimeMs;
    atextShown = ('${atimeMs.format()}');
    btextShown = ('${btimeMs.format()}');
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

  int get atotalMs => _atotalMs;
  int get btotalMs => _btotalMs;
  int get aDelay => _adelay;
  int get bDelay => _bdelay;
  String get atextShown => _atextShown;
  String get btextShown => _btextShown;
  bool get playing => _playing;
  bool get aturn => _aturn;
  bool get btimeEnded => _btimeEnded;
  bool get atimeEnded => _atimeEnded;
  int get aInc => _ainc;
  int get bInc => _binc;
  int get moves => _moves;
  int get atemp => _atemp;
  int get btemp => _btemp;

  CountdownTimer _acountdownTimer;
  CountdownTimer _bcountdownTimer;

  Timer _adelayTimer;
  Timer _bdelayTimer;

  StreamSubscription<CountdownTimer> _alistener;
  StreamSubscription<CountdownTimer> _blistener;

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

      atextShown = _atemp.format();
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

      btextShown = _btemp.format();
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
    atextShown = atotalMs.format();
    btextShown = btotalMs.format();
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
      atextShown = _acountdownTimer.remaining.inMilliseconds.format();
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
      btextShown = _bcountdownTimer.remaining.inMilliseconds.format();
    });
  }

  void pause() {
    if (playing) {
      playPressed();
    }
  }
}
