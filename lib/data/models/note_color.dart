import 'dart:convert';

import 'package:flutter/material.dart';

class NoteColor {
  final int id;
  final Color color;
  NoteColor({
    required this.id,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'color': color.value,
    };
  }

  factory NoteColor.fromMap(Map<String, dynamic> map) {
    return NoteColor(
      id: map['id']?.toInt(),
      color: Color(map['color']),
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteColor.fromJson(String source) =>
      NoteColor.fromMap(json.decode(source));
}
