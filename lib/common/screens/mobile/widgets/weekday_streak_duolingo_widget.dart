import 'package:flutter/material.dart';

class WeekdayStreakDuolingo extends StatelessWidget {
  WeekdayStreakDuolingo({super.key});

  Iterable<Widget> getDays() sync* {
    final DateTime now = DateTime.now();

    for (int i = 4; i > 0; i--) {
      DateTime date = now.add(Duration(days: -i));
      yield createColumn(date.weekday, true);
    }
    yield createColumn(now.weekday, false);
  }

  Widget createColumn(int day, bool isDone) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Column(
        children: [
          Text(
            weekDayToString[day] ?? "",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          isDone
              ? CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  child: const CircleAvatar(
                    radius: 9,
                    // backgroundColor: Colors.white.withOpacity(0.1),
                    // backgroundColor: Colors.white.withOpacity(0.3),
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                )
              : CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.black.withOpacity(0.3),
                ),
        ],
      ),
    );
  }

  final Map<int, String> weekDayToString = {
    1: "S",
    2: "T",
    3: "Q",
    4: "Q",
    5: "S",
    6: "S",
    7: "D",
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      children: getDays().toList(),
    );
  }
}
