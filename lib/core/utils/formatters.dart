import 'package:intl/intl.dart';

final _number = NumberFormat.decimalPattern('ja');

String formatYen(int amount) => '¥${_number.format(amount)}';

String formatPoints(int points) => _number.format(points);

String formatTime(DateTime time) => DateFormat('HH:mm').format(time);

String formatDate(DateTime date, String locale) =>
    DateFormat.yMMMd(locale).format(date);

String formatDateTime(DateTime date, String locale) =>
    '${DateFormat.MMMd(locale).format(date)} ${formatTime(date)}';
