import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/icons_app.dart';
import 'weekday_streak_duolingo_widget.dart';

class DuolingoHomeScreenWidget extends StatelessWidget {
  DuolingoHomeScreenWidget({
    super.key,
  });

  final Color _gradientGreenTopBackgroundColor = const Color(0xFF51795C);
  final Color _gradientGreenBottomBackgroundColor = const Color(0xFF869441);

  final DateTime lastUpdated = DateTime(2024, 7, 29);
  final int initialStreakCount = 342;

  @override
  Widget build(BuildContext context) {
    final int daysDifference = DateTime.now().difference(lastUpdated).inDays;
    final int currentStreakCount = initialStreakCount + daysDifference;
    double half = MediaQuery.of(context).size.width * 0.5;
    return Align(
      alignment: Alignment.topLeft,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Container(
          height: half - 30,
          width: double.infinity,
          constraints: const BoxConstraints(
            minHeight: 200,
            maxHeight: 300,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                _gradientGreenTopBackgroundColor,
                _gradientGreenBottomBackgroundColor,
              ],
            ),
          ),
          child: Row(
            children: [
              /// PRIMEIRA COLUNA
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 18, bottom: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    /// PRIMEIRO ELEMENTO - [ÍCONE] [QUANTIDADE + DIAS]
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          IconsApp.streak,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          // "342 Days",
                          "${currentStreakCount} Days",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    /// SEGUNDO ELEMENTO - [TEXTO],
                    const Text(
                      "Are you ready to learn?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),

                    /// TERCEIRO ELEMENTO - WeekdayStreakDuolingo(),
                    WeekdayStreakDuolingo(),
                    // const SizedBox(height: 12),
                  ],
                ),
              ),
              const Spacer(),

              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 150,
                  width: 180,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(IconsApp.coruja),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
