import 'package:flutter/material.dart';

class MechanicIcon extends StatelessWidget {
  const MechanicIcon({
    super.key,
    required this.iconData,
    required this.color,
  });

  final IconData iconData;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      size: 100,
      color: color,
    );
  }
}
