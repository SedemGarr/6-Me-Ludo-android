import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WayOutWidget extends StatelessWidget {
  final double width;

  const WayOutWidget({Key? key, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          'wayyy out! games',
          style: GoogleFonts.quantico(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}