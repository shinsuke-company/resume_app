import 'package:flutter/material.dart';
import 'package:resume_app/utils/size_config.dart';
import 'home_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopScreen extends StatelessWidget {
  const TopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                return HomeScreen();
              }, transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                final Offset begin = Offset(0.0, 1.0);
                final Offset end = Offset.zero;
                final Animatable<Offset> tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: Curves.easeInOut));
                final Animation<Offset> offsetAnimation =
                    animation.drive(tween);
                return SlideTransition(position: offsetAnimation, child: child);
              }),
            );
          },
          child: Text('ログイン'),
        ),
      ),
    );
  }
}
