import 'package:flutter/material.dart';
import 'dart:html' as html;

class ButtonsPage extends StatefulWidget {
  final int numberOfButtons;

  const ButtonsPage({Key key, @required this.numberOfButtons}) : super(key: key);

  @override
  _ButtonsPageState createState() => _ButtonsPageState();
}

class _ButtonsPageState extends State<ButtonsPage> with SingleTickerProviderStateMixin {
  AnimationController controller;
  List<Animation<Color>> buttonColorAnimations = [];
  List<Animation<double>> gradientAnimations = [];

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));

    buildAnimations();
    controller.repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          boxShadow: [BoxShadow(blurRadius: 8.0, offset: Offset(4.0, 4.0), color: Colors.black26)],
        ),
        child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            onTap: () {
              html.window.location.href = 'https://github.com/savioserra/staggered-animations-example';
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.network(
                "https://github.githubassets.com/images/modules/logos_page/GitHub-Logo.png",
                fit: BoxFit.scaleDown,
                width: 100,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 140.0),
        child: LayoutBuilder(
          builder: (ctx, cts) {
            var buttonWidth = cts.maxWidth / widget.numberOfButtons - 10;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (var i = 0; i < widget.numberOfButtons; i++)
                      AnimatedBuilder(
                        animation: controller,
                        builder: (ctx, child) => Button(
                          width: buttonWidth,
                          color: buttonColorAnimations[i].value,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 10.0),
                AnimatedBuilder(
                  animation: controller,
                  builder: (ctx, child) => Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      gradient: LinearGradient(
                        colors: [Colors.green, Colors.greenAccent],
                        stops: [gradientAnimations[0].value, gradientAnimations[1].value],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  void buildAnimations() {
    var interval = 1.0 / widget.numberOfButtons;
    var initialInterval = 0.0;

    for (int i = 0; i < widget.numberOfButtons; i++) {
      buttonColorAnimations.add(
        ColorTween(begin: Colors.transparent, end: Colors.green).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              initialInterval,
              initialInterval + interval,
              curve: Curves.ease,
            ),
          ),
        ),
      );

      initialInterval += interval;
    }

    gradientAnimations.addAll([
      Tween(begin: 0.2, end: 1.0).animate(controller),
      Tween(begin: 0.8, end: 1.0).animate(controller),
    ]);
  }
}

class Button extends StatelessWidget {
  final double width;
  final Color color;

  const Button({Key key, this.width, this.color = Colors.red}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
    );
  }
}
