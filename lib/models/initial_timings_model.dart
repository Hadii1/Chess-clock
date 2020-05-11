import 'package:liclock/models/custom_timing_podo.dart';

class InitialTimingModel {
  final String timing;
  final String increment;
  final String title;

  InitialTimingModel(this.timing, this.increment, this.title);

  static List<CustomTiming> getTimingsList() {
    List<CustomTiming> timings = List();
    timings.add(CustomTiming(
        atimeHours: 0,
        atimeMins: 1,
        atimeSec: 0,
        aInc: 0,
        btimeHours: 0,
        btimeMins: 1,
        btimeSec: 0,
        bInc: 0,
        aDelay: 0,
        bDelay: 0,
        clockName: 'Bullet'));
    timings.add(CustomTiming(
        atimeHours: 0,
        atimeMins: 1,
        atimeSec: 0,
        aInc: 3,
        btimeHours: 0,
        btimeMins: 1,
        btimeSec: 0,
        bInc: 3,
        aDelay: 0,
        bDelay: 0,
        clockName: 'Bullet'));
    timings.add(CustomTiming(
        atimeHours: 0,
        atimeMins: 1,
        atimeSec: 0,
        aInc: 5,
        btimeHours: 0,
        btimeMins: 1,
        btimeSec: 0,
        bInc: 5,
        aDelay: 0,
        bDelay: 0,
        clockName: 'Bullet'));
    timings.add(CustomTiming(
        atimeHours: 0,
        atimeMins: 3,
        atimeSec: 0,
        aInc: 0,
        btimeHours: 0,
        btimeMins: 3,
        btimeSec: 0,
        bInc: 0,
        aDelay: 0,
        bDelay: 0,
        clockName: 'Blitz'));
    timings.add(CustomTiming(
        atimeHours: 0,
        atimeMins: 3,
        atimeSec: 0,
        aInc: 3,
        btimeHours: 0,
        btimeMins: 3,
        btimeSec: 0,
        bInc: 3,
        aDelay: 0,
        bDelay: 0,
        clockName: 'Blitz'));

    timings.add(CustomTiming(
        atimeHours: 0,
        atimeMins: 3,
        atimeSec: 0,
        aInc: 5,
        btimeHours: 0,
        btimeMins: 3,
        btimeSec: 0,
        bInc: 5,
        aDelay: 0,
        bDelay: 0,
        clockName: 'Blitz'));
    timings.add(CustomTiming(
        atimeHours: 0,
        atimeMins: 5,
        atimeSec: 0,
        aInc: 0,
        btimeHours: 0,
        btimeMins: 5,
        btimeSec: 0,
        bInc: 0,
        aDelay: 0,
        bDelay: 0,
        clockName: 'Blitz'));
    timings.add(CustomTiming(
        atimeHours: 0,
        atimeMins: 5,
        atimeSec: 0,
        aInc: 5,
        btimeHours: 0,
        btimeMins: 5,
        btimeSec: 0,
        bInc: 5,
        aDelay: 0,
        bDelay: 0,
        clockName: 'Blitz'));

    timings.add(CustomTiming(
        atimeHours: 0,
        atimeMins: 5,
        atimeSec: 0,
        aInc: 0,
        btimeHours: 0,
        btimeMins: 5,
        btimeSec: 0,
        bInc: 5,
        aDelay: 0,
        bDelay: 0,
        clockName: 'Blitz'));

    timings.add(CustomTiming(
        atimeHours: 0,
        atimeMins: 10,
        atimeSec: 0,
        aInc: 0,
        btimeHours: 0,
        btimeMins: 10,
        btimeSec: 0,
        bInc: 0,
        aDelay: 0,
        bDelay: 0,
        clockName: 'Rapid'));

    timings.add(CustomTiming(
        atimeHours: 0,
        atimeMins: 10,
        atimeSec: 0,
        aInc: 10,
        btimeHours: 0,
        btimeMins: 10,
        btimeSec: 0,
        bInc: 10,
        aDelay: 0,
        bDelay: 0,
        clockName: 'Rapid'));

    timings.add(CustomTiming(
        atimeHours: 0,
        atimeMins: 15,
        atimeSec: 0,
        aInc: 15,
        btimeHours: 0,
        btimeMins: 15,
        btimeSec: 0,
        bInc: 15,
        aDelay: 0,
        bDelay: 0,
        clockName: 'Rapid'));

    return timings;
  }
}
