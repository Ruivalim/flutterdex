import 'package:flutter/material.dart';
import 'package:pokedex/functions.dart';
import 'package:pokedex/models/Pokemons.dart';
import 'package:pokedex/pages/Home.dart';

class PokemonPage extends State<PokemonView>{
	@override
	Widget build(BuildContext context){
	 return Scaffold(
			appBar: AppBar(
				leading: new IconButton(
					icon: Icon(
						Icons.arrow_back_ios,
						color: Colors.white,
						size: 24.0,
						semanticLabel: 'Back',
					),
					onPressed: () {
						Navigator.pop(context);
					},
				),
				title: Text(capitalize(widget.pokemon.name)),
				backgroundColor: getTypeColors(widget.pokemon.types),
				brightness: Brightness.dark,
				elevation: 0.0,
			),
			body: Column(
				children: <Widget>[
					Center(
						child: Image(
							height: 300.0,
							image: widget.pokemon.image != null ? NetworkImage(widget.pokemon.image) : NetworkImage("https://getgoingabd.com/wp-content/uploads/2020/06/No_Image_Available.jpg"),
						),
					)
				],
			)
		);
	}
}

class PokemonView extends StatefulWidget {
	final Pokemon pokemon;

	const PokemonView({this.pokemon});

	@override
	createState() => PokemonPage();
}
