import 'package:flutter/material.dart';
import 'package:pokedex/functions.dart';
import 'package:pokedex/models/Pokemons.dart';

class PokemonPage extends State<PokemonView>{
	PokemonData pokeData = PokemonData(
		description: "Loading..."
	);
	bool getting = true;

	@override
	void initState() {
		super.initState();
		_getPokemonData();
	}

	void _getPokemonData(){
		PokemonData().getPokemonData(widget.pokemon.speciesUrl).then((pokedata) => {
			setState(() => {
				pokeData = pokedata,
				getting = false
			})
		});
	}

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
					),
					Row(
						mainAxisAlignment: MainAxisAlignment.center,
						children: widget.pokemon.types.map((type) {
							return new Container(
								margin: const EdgeInsets.all(10.0),
								color: getTypeColor(type['type']['name']),
								padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
								child: Text(
									capitalize(type['type']['name']),
									style: TextStyle(color: Colors.white, fontSize: 25)
								)
							);
						}).toList(),
					),
					Container(
						padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 20.0),
						child: Text(
							"\""+normalize(pokeData.description)+"\"",
							style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)
						)
					),
					Container(
						padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
						child: Row(
							children: [
								Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Text(
											"Height: " + widget.pokemon.height.toString() + "m",
											style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)
										),
										Text(
											"Weight: " + widget.pokemon.weight.toString() + "kg",
											style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)
										),
										Text(
											"Capture Rate: " + pokeData.capture_rate.toString() + "%",
											style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)
										),
									],
								),
							],
						)
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
