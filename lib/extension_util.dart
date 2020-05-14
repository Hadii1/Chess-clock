String _formatSeconds(double number) {
  return number.toInt().toString().length == 1
      ? number.toString().substring(0, 3)
      : number.toString().substring(0, 4);
}

String _formatMinsAndSec(int number) {
  String formatedNumber;
  number.toString().length == 1
      ? formatedNumber = '0$number'
      : formatedNumber = '${number.toString()}';
  return formatedNumber;
}

extension FormatTiming on int {
  String format() => _timeFormat(this);
}

String _timeFormat(int totalMillis) {
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
    return ('${_formatMinsAndSec(mins)}:${_formatMinsAndSec(sec.toInt())}');
  }
  return ('$hours:${_formatMinsAndSec(mins)}:${_formatMinsAndSec(sec.toInt())}');
}
