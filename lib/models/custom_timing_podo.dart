import 'package:hive/hive.dart';

part 'custom_timing_podo.g.dart';

@HiveType(typeId: 1)
class CustomTiming {
  @HiveField(0)
  final String clockName;

  @HiveField(1)
  final int atimeHours;

  @HiveField(2)
  final int atimeMins;

  @HiveField(3)
  final int atimeSec;

  @HiveField(6)
  final int aInc;

  @HiveField(9)
  final int aDelay;

  @HiveField(10)
  final int btimeHours;

  @HiveField(11)
  final int btimeMins;

  @HiveField(12)
  final int btimeSec;

  @HiveField(15)
  final int bInc;

  @HiveField(18)
  final int bDelay;

  CustomTiming({
    this.clockName,
    this.atimeHours,
    this.atimeMins,
    this.atimeSec,
    this.aInc,
    this.aDelay,
    this.btimeHours,
    this.btimeMins,
    this.btimeSec,
    this.bInc,
    this.bDelay,
  });
}
