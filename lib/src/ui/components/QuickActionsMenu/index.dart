import 'package:fingen/src/ui/components/QuickActionsMenu/quick_action.dart';
import 'package:fingen/src/ui/components/QuickActionsMenu/quick_action_button.dart';
import 'package:fingen/src/ui/components/QuickActionsMenu/quick_action_menu_floating_action_button.dart';
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