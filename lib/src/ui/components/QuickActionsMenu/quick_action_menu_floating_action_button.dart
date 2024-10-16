import 'package:fingen/src/ui/components/QuickActionsMenu/quick_action_icon.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapCancel: () => widget.close(),
      onTap: () => {
        if (widget.isOpen) {
          widget.close()
        } else {
          widget.open()
        }
      },
      child: AnimatedScale(
        scale: widget.isOpen ? 0.8 : 1.0,
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