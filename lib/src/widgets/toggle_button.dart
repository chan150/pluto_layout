import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  const ToggleButton({
    required this.title,
    required this.enabled,
    this.icon,
    this.trailing,
    this.changed,
    this.textStyle,
    this.padding,
    super.key,
  });

  final String title;

  final bool enabled;

  final Widget? icon;

  final Widget? trailing;

  final void Function(bool)? changed;

  final TextStyle? textStyle;
  final EdgeInsets? padding;

  void onTap() {
    if (changed != null) changed!(!enabled);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final style = TextButton.styleFrom(
      foregroundColor: enabled ? theme.colorScheme.secondary : theme.disabledColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
    );

    Widget label = Text(title);

    if (trailing != null) {
      label = Row(children: [label, trailing!]);
    }

    return icon != null
        ? TextButton.icon(
            style: style.copyWith(
              textStyle: WidgetStatePropertyAll(textStyle),
              padding: WidgetStatePropertyAll(padding),
              minimumSize: WidgetStatePropertyAll(padding == null ? null : Size.zero),
            ),
            icon: icon!,
            onPressed: onTap,
            label: label,
          )
        : TextButton(
            // style: style,
            style: style.copyWith(
              textStyle: WidgetStatePropertyAll(textStyle),
              padding: WidgetStatePropertyAll(padding),
              minimumSize: WidgetStatePropertyAll(padding == null ? null : Size.zero),
            ),
            onPressed: onTap,
            child: label,
          );
  }
}
