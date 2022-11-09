import 'package:flutter/material.dart';

Widget fieldcoin(
    TextEditingController controller, String label, String ex, Function f,
    {String? pre, Icon? icon}) {
  return TextField(
    controller: controller,
    keyboardType: TextInputType.number,
    onChanged: (value) => f(value),
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      hintText: ex,
      labelText: label,
      prefix: pre != null ? Text(pre) : const Text(''),
      prefixIcon: icon,
    ),
  );
}
