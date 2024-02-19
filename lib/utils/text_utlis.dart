
import 'package:flutter/material.dart';

class TextUtil extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final bool? weight;

  const TextUtil({
    super.key,
    required this.text,
    this.size,
    this.color,
    this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: color ?? Colors.black,
          fontSize: size ?? 18,
          fontWeight: weight == null ? FontWeight.normal : FontWeight.bold),
    );
  }
}
