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
    // return Icon(
    //   iconData,
    //   size: 100,
    //   color: color,
    // );
  }
}

final mechanicIcons = <String, IconData>{
  "Auction": Icons.money,
  "Deck Building": Icons.style,
  "Worker Placement": Icons.engineering,
};

// class MechanicSelectedEffect extends StatefulWidget {
//   const MechanicSelectedEffect({super.key});

//   @override
//   State<StatefulWidget> createState() {
//     return _MechanicSelectedEffect();
//   }
// }

// class _MechanicSelectedEffect extends State<MechanicSelectedEffect>
//     with SingleTickerProviderStateMixin {
//   Animation<double>? animation;
//   AnimationController? animationcontroller;

//   @override
//   void initState() {
//     animationcontroller =
//         AnimationController(vsync: this, duration: const Duration(seconds: 1));

//     animationcontroller?.play();

//     animation = Tween<double>(begin: 0, end: 100).animate(animationcontroller ??
//         AnimationController(vsync: this, duration: const Duration(seconds: 1)));

//     animation?.addListener(() {
//       setState(() {});
//     });

//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     animationcontroller?.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: const EdgeInsets.all(20),
//         alignment: Alignment.center,
//         height: 100,
//         child: Container(
//           decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(width: 2, color: Colors.green)),
//           height: animation?.value,
//           width: animation?.value,
//         ),
//       ),
//     );
//   }
// }
