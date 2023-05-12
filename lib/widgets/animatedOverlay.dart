import 'dart:async';
import 'package:flutter/material.dart';

class OverlayWidget extends StatefulWidget {
  const OverlayWidget({
    super.key,
    // required this.parentOverlayReference,
    required this.title,
    required this.content,
    required this.actions,
  });

  // final OverlayEntry parentOverlayReference;
  final Widget title, content;
  final List<Widget> actions;

  @override
  OverlayWidgetState createState() => OverlayWidgetState();
}

class OverlayWidgetState extends State<OverlayWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacityAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 450),
    );

    opacityAnimation = Tween<double>(begin: 0.0, end: 0.4).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.fastOutSlowIn,
      ),
    );

    scaleAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  Future<void> startDisposal() async {
    await controller.reverse();
    // widget.parentOverlayReference.remove();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: startDisposal,
          child: Container(
            color: Colors.black.withOpacity(opacityAnimation.value),
          ),
        ),
        ScaleTransition(
          scale: scaleAnimation,
          child: Padding(
            padding: MediaQuery.of(context).viewInsets +
                const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 24.0,
                ),
            child: MediaQuery.removeViewInsets(
              removeLeft: true,
              removeTop: true,
              removeRight: true,
              removeBottom: true,
              context: context,
              child: Center(
                child: Container(
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 280.0),
                    child: IntrinsicWidth(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              24.0,
                              24.0,
                              24.0,
                              0.0,
                            ),
                            child: DefaultTextStyle(
                              style: Theme.of(context).textTheme.titleLarge!,
                              child: Semantics(
                                namesRoute: true,
                                container: true,
                                child: widget.title,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                24.0,
                                12.0,
                                24.0,
                                0.0,
                              ),
                              child: DefaultTextStyle(
                                style: Theme.of(context).textTheme.titleMedium!,
                                child: widget.content,
                              ),
                            ),
                          ),
                          ButtonBar(
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: startDisposal,
                                child: Text(
                                  "Close",
                                  style: TextStyle(
                                    color: Colors.tealAccent[700],
                                  ),
                                ),
                              ),
                            ]..insertAll(0, widget.actions),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AnimatedOverlay {
  const AnimatedOverlay({
    required this.title,
    required this.content,
    required this.actions,
  });

  final Widget title;
  final Widget content;
  final List<Widget> actions;

  OverlayEntry call() {
    OverlayEntry modal;

    modal = OverlayEntry(
      builder: (BuildContext context) {
        return OverlayWidget(
          // parentOverlayReference: modal,
          title: title,
          content: content,
          actions: actions,
        );
      },
    );

    return modal;
  }
}
