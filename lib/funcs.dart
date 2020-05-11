import 'models/custom_timing_podo.dart';

initializeProviderValues(CustomTiming customTiming, var prov) {
  int atimeMs, btimeMs;
  prov.reset();

  atimeMs = (customTiming.atimeHours * 3600 +
          customTiming.atimeMins * 60 +
          customTiming.atimeSec) *
      1000;
  btimeMs = (customTiming.btimeHours * 3600 +
          customTiming.btimeMins * 60 +
          customTiming.btimeSec) *
      1000;

  prov.atotalMs = atimeMs;
  prov.btotalMs = btimeMs;
  prov.ainc = customTiming.aInc;
  prov.binc = customTiming.bInc;
  prov.aDelay = customTiming.aDelay;
  prov.bDelay = customTiming.bDelay;
  prov.atemp = atimeMs;
  prov.btemp = btimeMs;

  prov.atextShown = ('${prov.timeFormat(atimeMs)}');
  prov.btextShown = ('${prov.timeFormat(btimeMs)}');
}

