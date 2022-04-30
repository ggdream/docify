import 'package:flutter/material.dart';

class BackBtn<T> extends StatelessWidget {
  const BackBtn({
    Key? key,
    this.color,
    this.data,
  }) : super(key: key);

  final Color? color;
  final T? data;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(data),
      icon: const Icon(Icons.arrow_back_ios_rounded),
    );
  }
}
