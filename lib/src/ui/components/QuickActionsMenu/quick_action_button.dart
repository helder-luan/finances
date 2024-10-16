import 'dart:math';

import 'package:fingen/src/ui/components/QuickActionsMenu/quick_action.dart';
import 'package:fingen/src/ui/components/QuickActionsMenu/quick_action_icon.dart';
import 'package:flutter/material.dart';

class QuickActionButton extends StatefulWidget {
  final QuickAction action;
  final bool isOpen;
  final int index;
  final Function() close;

  const QuickActionButton(
    this.action, {
    required this.isOpen,
    required this.index,
    required this.close,
    super.key
  });

  @override
  State<QuickActionButton> createState() => _QuickActionButtonState();
}

class _QuickActionButtonState extends State<QuickActionButton> {
  final _radius = 100.0;
  final _offset = -10.0;

  double degreesToRadians(double degrees) => degrees * pi / 180.0;
  double get _range => 90.0 - _offset;
  double get _alpha => _offset / 2 + widget.index * _range / 2;
  double get _radian => degreesToRadians(_alpha);
  double get _a => _radius * cos(_radian);
  double get _b => _radius * sin(_radian);

  final Duration _duration = const Duration(milliseconds: 250);
  var _isPressed = false;

  _pressDown() {
    setState(() {
      _isPressed = true;
    });
  }

  _pressUp() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: _duration,
      right: widget.isOpen ? _a : 0.0,
      bottom: widget.isOpen ? _b : 0.0,
      curve: Curves.easeOut,
      child: Padding(
        padding: const EdgeInsets.all(16.0).copyWith(bottom: MediaQuery.of(context).padding.bottom + 16),
        child: AnimatedRotation(
          turns: widget.isOpen ? 0.0 : 0.1,
          alignment: Alignment.center,
          curve: Curves.easeOut,
          duration: _duration * 1.5,
          child: AnimatedOpacity(
            opacity: widget.isOpen ? 1.0 : 0.0,
            duration: _duration,
            child: AnimatedScale(
              scale: _isPressed ? 0.95 : 1.0,
              duration: _duration,
              child: GestureDetector(
                onTapDown: (_) => _pressDown(),
                onTapUp: (_) => _pressUp(),
                onTapCancel: () => _pressUp(),
                onTap: () {
                  widget.close();
                  widget.action.onTap();
                },
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        offset: Offset(0, 2),
                        color: Colors.black26,
                      ),
                    ]
                  ),
                  child: QuickActionIcon(
                    icon: Icon(
                      widget.action.icon,
                      size: 30,
                      color: widget.action.iconColor ?? Colors.black,
                    ),
                    backgroundColor: widget.action.backgroundColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}