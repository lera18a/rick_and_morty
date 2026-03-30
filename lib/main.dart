import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/di/injector.dart';
import 'package:rick_and_morty/rick_and_morty_app.dart';

void main() {
  configureDependencies();
  runApp(const RickAndMortyApp());
}
