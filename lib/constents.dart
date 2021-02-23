import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'Value',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(30),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(
      Radius.circular(30),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.blueAccent,
      width: 2.0,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(32),
    ),
  ),
  filled: true,
);
