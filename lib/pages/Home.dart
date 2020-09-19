import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex/models/Pokemons.dart';
import 'package:pokedex/pages/Pokemon.dart';
import 'package:pokedex/functions.dart';

class HomePage extends State<PokemonsList>{
	ScrollController _controller = ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);

	List<Pokemons> _pokemons = List<Pokemons>();
	num skip = 0;
	bool getting = false;

	@override
	void initState() {
		super.initState();
		_populatePokemons();
	}

	HomePage(){
		_controller.addListener(() {
			var isEnd = _controller.position.pixels > ( _controller.position.maxScrollExtent - 150 );
			if (isEnd && getting == false){
				setState(() => {
					getting = true
				});
				_populatePokemons();
			}
		});
	}

	void _populatePokemons(){
		Pokemons().getPokemons(skip).then((pokemons) => {
			setState(() => {
				_pokemons += pokemons,
				skip = skip + 20,
				getting = false
			})
		});
	}

	ListTile _buildItemsForListView(BuildContext context, int index) {
		return ListTile(
			title: Container(
				color: getTypeColors(_pokemons[index].pokemon.types),
				margin: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
				padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
				child: Row(
					mainAxisAlignment: MainAxisAlignment.spaceAround,
					children: <Widget>[
						Text(
							capitalize(_pokemons[index].pokemon.name),
							style: TextStyle(color: Colors.white)
						),
						Image(
							height: 80,
							image: NetworkImage(_pokemons[index].pokemon.image),
						),
					],
				),
			),
			onTap: () {
				Navigator.push(
					context,
					MaterialPageRoute(
						builder: (context) => PokemonView(pokemon: _pokemons[index].pokemon),
					),
				);
			}
		);
	}

	loading() {
		if( getting == true ){
			return CircularProgressIndicator();
		}else{
			return Container();
		}
	}

	@override
	Widget build(BuildContext context){
		return Scaffold(
			appBar: PreferredSize(
				preferredSize: Size.fromHeight(20.0),
				child: AppBar(
					backgroundColor: Colors.white,
					brightness: Brightness.light,
					elevation: 0.0,
				)
			),
			body:	Column(
				children: <Widget>[
					new Padding(
						padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
						child: new TextField(
							decoration: new InputDecoration(
									hintText: "Search"
							),
							onChanged: (searchValue) {
								print(searchValue);
							},
						)
					),
					new Expanded(
						child: ListView.builder(
							itemCount: _pokemons.length,
							itemBuilder: _buildItemsForListView,
							controller: _controller
						),
					),
					new Padding(
						padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
						child: loading()
					)
				]
			)
		);
	}
}

class PokemonsList extends StatefulWidget {
	@override
	createState() => HomePage();
}
