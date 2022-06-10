import 'package:flutter/material.dart';

class KRadioTile extends StatelessWidget {
  final Object value;
  final String title;
  final String? subtitle;
  final IconData icon;
  final Object? groupValue;
  dynamic Function(Object?)? onChanged;
  KRadioTile({
    Key? key,
    required this.value,
    required this.title,
    this.subtitle,
    required this.icon,
    this.groupValue,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      value: value,
      groupValue: groupValue,
      controlAffinity: ListTileControlAffinity.trailing,
      contentPadding: const EdgeInsets.all(0),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle ?? '') : null,
      secondary: Icon(icon),
      enableFeedback: true,
      visualDensity: VisualDensity.compact,
      onChanged: onChanged,
    );
  }
}
