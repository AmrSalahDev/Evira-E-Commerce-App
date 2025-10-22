import 'dart:math' as math;

import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSliderPart extends StatefulWidget {
  final Function(double min, double max) onRangeChanged;
  final RangeValues initialRange;
  final RangeValues rangeValues;
  const CustomSliderPart({
    super.key,
    required this.onRangeChanged,
    required this.initialRange,
    required this.rangeValues,
  });

  @override
  State<CustomSliderPart> createState() => _CustomSliderPartState();
}

class _CustomSliderPartState extends State<CustomSliderPart> {
  late RangeValues priceRange;

  @override
  void initState() {
    super.initState();
    priceRange = RangeValues(
      widget.initialRange.start,
      widget.initialRange.end,
    );
  }

  @override
  void didUpdateWidget(CustomSliderPart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialRange != widget.initialRange) {
      priceRange = widget.initialRange;
    }
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = GoogleFonts.urbanist(
      color: context.textColor,
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
    );

    return Column(
      children: [
        SliderTheme(
          data: SliderThemeData(
            padding: EdgeInsets.zero,
            activeTrackColor: context.textColor,
            inactiveTrackColor: context.dividerColor,
            thumbColor: context.textColor,
            overlayColor: Colors.white.withValues(alpha: 0.2),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 14),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
            trackHeight: 2,
          ),
          child: RangeSlider(
            padding: EdgeInsets.zero,
            values: priceRange,
            min: widget.rangeValues.start,
            max: widget.rangeValues.end,
            onChanged: (values) {
              setState(() {
                priceRange = values;
                widget.onRangeChanged(priceRange.start, priceRange.end);
              });
            },
          ),
        ),

        // Labels aligned perfectly with thumbs
        LayoutBuilder(
          builder: (context, constraints) {
            final totalWidth = constraints.maxWidth;
            final rangeSpan = widget.rangeValues.end - widget.rangeValues.start;

            if (rangeSpan <= 0) {
              return const SizedBox(height: 30);
            }

            // These values MUST match your SliderTheme configuration
            const double thumbRadius = 14.0;
            const double overlayRadius = 24.0;

            // Calculate the horizontal padding exactly as Flutter does
            final double horizontalPadding = math.max(
              overlayRadius / 2,
              thumbRadius / 2,
            );

            // Calculate track bounds (this is what getPreferredRect returns)
            final double trackLeft = horizontalPadding;
            final double trackRight = totalWidth - horizontalPadding;
            final double trackWidth = trackRight - trackLeft;

            // Calculate thumb positions on the track
            final startRatio =
                (priceRange.start - widget.rangeValues.start) / rangeSpan;
            final endRatio =
                (priceRange.end - widget.rangeValues.start) / rangeSpan;

            final startThumbCenter = trackLeft + (startRatio * trackWidth);
            final endThumbCenter = trackLeft + (endRatio * trackWidth);

            // Format labels
            final startText = '\$${priceRange.start.round().toString()}';
            final endText = '\$${priceRange.end.round().toString()}';

            // Measure text widths
            final startWidth = _measureTextWidth(startText, labelStyle);
            final endWidth = _measureTextWidth(endText, labelStyle);

            // Calculate label positions (centered on thumbs)
            double startLeft = startThumbCenter - (startWidth / 2);
            double endLeft = endThumbCenter - (endWidth / 2);

            // Clamp to prevent overflow
            startLeft = startLeft.clamp(0.0, totalWidth - startWidth);
            endLeft = endLeft.clamp(0.0, totalWidth - endWidth);

            // Handle overlap
            const minSeparation = 8.0;
            final overlap = (startLeft + startWidth + minSeparation) - endLeft;

            if (overlap > 0) {
              final midPoint = (startThumbCenter + endThumbCenter) / 2;
              final totalLabelWidth = startWidth + endWidth + minSeparation;

              startLeft = (midPoint - totalLabelWidth / 2).clamp(
                0.0,
                totalWidth - startWidth,
              );
              endLeft = (startLeft + startWidth + minSeparation).clamp(
                0.0,
                totalWidth - endWidth,
              );
            }

            return SizedBox(
              height: 30,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: startLeft,
                    child: Text(startText, style: labelStyle),
                  ),
                  Positioned(
                    left: endLeft,
                    child: Text(endText, style: labelStyle),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // Measure text width efficiently
  double _measureTextWidth(String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }
}
