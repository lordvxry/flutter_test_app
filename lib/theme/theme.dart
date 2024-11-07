import 'package:flutter/material.dart';

final mainTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
    useMaterial3: true,
    textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
        labelSmall: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        )
    )
);