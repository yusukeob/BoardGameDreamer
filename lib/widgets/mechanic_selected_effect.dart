import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class MechanicSelectedEffect extends StatefulWidget {
  const MechanicSelectedEffect({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MechanicSelectedEffect();
  }
}

class _MechanicSelectedEffect extends State<MechanicSelectedEffect>
    with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? animationcontroller;

  @override
  void initState() {
    animationcontroller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    animationcontroller?.play();

    animation = Tween<double>(begin: 100, end: 0).animate(animationcontroller ??
        AnimationController(vsync: this, duration: const Duration(seconds: 1)));

    animation?.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    animationcontroller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: 100,
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 2, color: Colors.green)),
          height: animation?.value,
          width: animation?.value,
        ),
      ),
    );
  }
}
