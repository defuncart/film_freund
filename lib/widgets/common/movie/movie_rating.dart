import 'dart:math' show pi;

import 'package:flutter/material.dart';

/// Displays the rating for a movie
///
/// [showRating] is used to either show a placeholder or [rating]. This is useful for new movies.
///
/// [rating] is expected to be a percentage between 0 and 100
class MovieRating extends StatelessWidget {
  const MovieRating({
    required this.showRating,
    required this.rating,
    Key? key,
  })  : assert(rating >= 0 && rating <= 100),
        super(key: key);

  final bool showRating;
  final int rating;

  /// Returns a [Color] depending on [rating]
  ///
  /// `>=70 green`, `>= 40 yellow`, `<40 red`
  @visibleForTesting
  static Color ratingRingColor(int rating) {
    if (rating >= 70) {
      return Colors.green;
    } else if (rating >= 40) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = MovieRating.ratingRingColor(rating);
    final ring = Ring(
      backgroundColor: showRating ? Colors.black : Colors.grey,
      highlightColor: showRating ? color : Colors.transparent,
      normalColor: showRating ? color.withOpacity(0.5) : Colors.transparent,
      percentage: showRating ? rating : 0,
    );
    final text = showRating ? rating.toString() : 'tbd';

    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(
        painter: ring,
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.caption?.copyWith(
                  fontSize: 10,
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}

/// Draws a ring with [highlightColor] of length [percentage], [normalColor] 1 - [percentage]
///
/// This ring takes parents width & height which is expected to be square
@visibleForTesting
class Ring extends CustomPainter {
  const Ring({
    required this.backgroundColor,
    required this.highlightColor,
    required this.normalColor,
    required this.percentage,
  })  : assert(percentage >= 0 && percentage <= 100),
        super();

  final Color backgroundColor;
  final Color highlightColor;
  final Color normalColor;
  final int percentage;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide / 2;

    final rect = Rect.fromCircle(center: center, radius: radius);
    final startAngle = -pi / 2;
    final sweepAngle = (percentage / 100) * pi * 2;
    final endAngle = 2 * pi;
    const strokeWidth = 2.0;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final highlightPaint = Paint()
      ..color = highlightColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final normalPaint = Paint()
      ..color = normalColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
      center,
      radius,
      backgroundPaint,
    );

    canvas.drawArc(
      rect,
      startAngle,
      sweepAngle,
      false,
      highlightPaint,
    );

    canvas.drawArc(
      rect,
      sweepAngle,
      endAngle,
      false,
      normalPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
