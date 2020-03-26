import 'package:flutter/material.dart';

void pushPage(context, page) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => page),
  );
}