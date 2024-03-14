import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuickActionMenu extends StatefulWidget {
  final Function() onTap;
  final IconData icon;
  final Color backgroundColor;
  final Widget child;
  final List<QuickAction> actions;

  const QuickActionMenu({
    required this.onTap,
    required this.icon,
    required this.backgroundColor,
    required this.child,
    required this.actions,
    super.key
  }) : assert(actions.length == 3, 'QuickActionMenu requires exactly 3 actions');

  @override
  State<QuickActionMenu> createState() => _QuickActionMenuState();
}

class _QuickActionMenuState extends State<QuickActionMenu> {
  var _isOpen = false;

  _open() {
    setState(() {
      HapticFeedback.lightImpact();
      _isOpen = true;
    });
  }

  _close() {
    setState(() {
      HapticFeedback.lightImpact();
      _isOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        widget.child,
        IgnorePointer(
          ignoring: !_isOpen,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            opacity: _isOpen ? 1 : 0,
            child: GestureDetector(
              onTap: _close,
              child: Container(
                color: Colors.white.withOpacity(0.6)
              )
            ),
          ),
        ),
        ...widget.actions.map(
          (action) => QuickActionButton(
            action,
            isOpen: _isOpen,
            index: widget.actions.indexOf(action),
            close: _close
          )
        ),
        QuickActionMenuFloatingActionButton(
          open: _open,
          close: _close,
          onTap: widget.onTap,
          isOpen: _isOpen,
          icon: widget.icon,
          backgroundColor: widget.backgroundColor,
        )
      ],
    );
  }
}

class QuickActionMenuFloatingActionButton extends StatefulWidget {
  final Function() open;
  final Function() close;
  final Function() onTap;
  final bool isOpen;
  final IconData icon;
  final Color backgroundColor;

  const QuickActionMenuFloatingActionButton({
    required this.open,
    required this.close,
    required this.onTap,
    required this.isOpen,
    required this.icon,
    required this.backgroundColor,
    super.key
  });

  @override
  State<QuickActionMenuFloatingActionButton> createState() => _QuickActionMenuFloatingActionButtonState();
}

class _QuickActionMenuFloatingActionButtonState extends State<QuickActionMenuFloatingActionButton> {
  final Duration _duration = const Duration(milliseconds: 200);
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
    return GestureDetector(
      onTapDown: (_) => _pressDown(),
      onTapUp: (_) => _pressUp(),
      onTapCancel: () => _pressUp(),
      onTap: () => widget.isOpen ? widget.close() : widget.onTap(),
      onLongPress: () {
        if (!widget.isOpen) {
          widget.open();
          _pressUp();
        }
      },
      child: AnimatedScale(
        scale: _isPressed || widget.isOpen ? 0.8 : 1.0,
        duration: _duration,
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
          child: Stack(
            children: [
              QuickActionIcon(
                icon: Icon(
                  Icons.close_rounded,
                  size: 30,
                  color: widget.backgroundColor
                ),
                backgroundColor: Colors.white,
              ),
              AnimatedOpacity(
                opacity: widget.isOpen ? 0 : 1,
                duration: _duration,
                child: QuickActionIcon(
                  icon: Icon(
                    widget.icon,
                    size: 30,
                    color: Colors.white,
                  ),
                  backgroundColor: widget.backgroundColor
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionButtonState extends State<QuickActionButton> {
  final _radius = 130.0;
  final _offset = 10.0;

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

class QuickActionIcon extends StatelessWidget {
  final Icon icon;
  final Color backgroundColor;

  const QuickActionIcon({
    required this.icon,
    required this.backgroundColor,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container (
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.hardEdge,
      child: Center(
        child: icon,
      ),
    );
  }
}

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

class QuickAction {
  final IconData icon;
  final Color backgroundColor;
  final Color? iconColor;
  final Function() onTap;

  const QuickAction({
    required this.icon,
    this.backgroundColor = Colors.white,
    this.iconColor,
    required this.onTap,
  });
}