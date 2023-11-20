import 'package:flutter/material.dart';

class MechanicIcon extends StatelessWidget {
  const MechanicIcon({
    super.key,
    required this.iconData,
    required this.color,
  });

  final IconData? iconData;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2, color: Colors.green)),
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Icon(
          iconData,
          size: 80,
          color: color,
        ),
      ),
    );
  }
}

final mechanicIcons = <String, IconData>{
  "Auction": Icons.money,
  "Deck Building": Icons.style,
  "Worker Placement": Icons.engineering,
};
