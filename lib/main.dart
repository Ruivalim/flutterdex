import 'package:flutter/material.dart';
import 'package:pokedex/constants.dart';
import 'package:pokedex/pages/Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			debugShowCheckedModeBanner: false,
			title: 'FlutterDex',
			theme: ThemeData(
				scaffoldBackgroundColor: backgroundColor,
				primaryColor: primaryColor
			),
			home: PokemonsList(),
		);
	}
}
