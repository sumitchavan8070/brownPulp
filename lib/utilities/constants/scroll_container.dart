import 'dart:async';

import 'package:flutter/material.dart';

class Marquee extends StatefulWidget {
  const Marquee({
    Key? key,
    required this.children,
    this.offset = 40.0,
    this.maxHeight = 40.0,
  })  : itemBuilder = null,
        itemCount = children.length,
        super(key: key);

  const Marquee.builder({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    this.offset = 40.0,
    this.maxHeight = 40.0,
  })  : children = const [],
        super(key: key);

  final List<Widget> children;
  final double offset;
  final double maxHeight;
  final NullableIndexedWidgetBuilder? itemBuilder;
  final int? itemCount;

  @override
  State<Marquee> createState() => _MarqueeState();
}

class _MarqueeState extends State<Marquee> {
  final ScrollController _scrollController = ScrollController();
  late Timer _scrollTimer;
  bool _isScrolling = true;

  @override
  void initState() {
    super.initState();

    startContinuousScroll();
  }

  void startContinuousScroll() {
    const scrollDuration = Duration(seconds: 2);
    _scrollTimer = Timer.periodic(scrollDuration, (timer) {
      if (_scrollController.hasClients && _isScrolling) {
        double newScrollOffset = _scrollController.offset + widget.offset;
        _scrollController.animateTo(
          newScrollOffset,
          duration: scrollDuration,
          curve: Curves.linear,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.maxHeight,
      child: GestureDetector(
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            final indexes = index % (widget.itemCount ?? 1);

            return GestureDetector(
              onTapDown: (_) {
                _isScrolling = false;
                _scrollTimer.cancel();
              },
              onTapUp: (_) {
                _isScrolling = true;
                startContinuousScroll();
              },
              child: widget.itemBuilder != null
                  ? widget.itemBuilder!(context, indexes)
                  : widget.children[indexes],
            );
          },
        ),
      ),
    );
  }
}
