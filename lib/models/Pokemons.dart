import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonData{
	final num base_happiness;
	final num capture_rate;
	final String description;
	final String evolurionChainUrl;


	PokemonData({this.base_happiness, this.capture_rate, this.description, this.evolurionChainUrl});

	factory PokemonData.fromJson(Map<String,dynamic> json){
		String description;

		for(final txt in json['flavor_text_entries']) {
			if( txt['language']['name'] == "en" ){
				description = txt['flavor_text'];
				break;
			}
		};

		return PokemonData(
			base_happiness: json['base_happiness'],
			capture_rate: json['capture_rate'],
			description: description,
			evolurionChainUrl: json['evolution_chain']['url']
		);
	}

	Future<PokemonData> getPokemonData(String pokemon) async{
		final response = await http.get(pokemon);
		final result = json.decode(response.body);

		return PokemonData.fromJson(result);
	}
}

class Pokemon{
	final String name;
	final String image;
	final List types;
	final num id;
	final String speciesUrl;
	final num height;
	final num weight;

	Pokemon({this.name, this.image, this.types, this.id, this.speciesUrl, this.height, this.weight});

	factory Pokemon.fromJson(Map<String,dynamic> json) {
		return Pokemon(
			name: json['name'],
			image: json['sprites']['other']['official-artwork']['front_default'],
			types: json['types'],
			id: json['id'],
			speciesUrl: json['species']['url'],
			height: json['height'] / 10,
			weight: json['weight'] / 10
		);
	}
}

class Pokemons{
	final Pokemon pokemon;

	Pokemons({this.pokemon});

	factory Pokemons.fromJson(Pokemon pokemon) {
		return Pokemons(
			pokemon: pokemon,
		);
	}

	Future<Pokemon> getPokemon(pokemon) async{
		final response = await http.get(pokemon['url']);
		final result = json.decode(response.body);

		return Pokemon.fromJson(result);
	}

	Future<List<Pokemons>> getPokemons(skip) async{
		final response = await http.get("https://pokeapi.co/api/v2/pokemon?limit=20&offset="+skip.toString());
		final result = json.decode(response.body);
		Iterable pokemons = result['results'];

		return Future.wait(pokemons.map((model) async	=>Pokemons.fromJson(await Pokemons().getPokemon(model))));
	}

	Future<List<Pokemons>> getAllPokemonsFiltered(String filter) async{
		final response = await http.get("https://pokeapi.co/api/v2/pokemon?limit=2000");
		final result = json.decode(response.body);
		Iterable pokemons = result['results'];

		final pokeFiltered = pokemons.where((p) => p['name'].toLowerCase().contains(filter.toLowerCase())).toList();

		return Future.wait(pokeFiltered.map((model) async => Pokemons.fromJson(await Pokemons().getPokemon(model))));
	}

	Future<List<Pokemons>> getAllPokemonsFilteredByType(String filter) async{
		Map types_urls = {
			"Normal": "https://pokeapi.co/api/v2/type/1/",
			"Fire": "https://pokeapi.co/api/v2/type/10/",
			"Water": "https://pokeapi.co/api/v2/type/11/",
			"Electric": "https://pokeapi.co/api/v2/type/13/",
			"Grass": "https://pokeapi.co/api/v2/type/12/",
			"Ice": "https://pokeapi.co/api/v2/type/15/",
			"Fighting": "https://pokeapi.co/api/v2/type/2/",
			"Poison": "https://pokeapi.co/api/v2/type/4/",
			"Ground": "https://pokeapi.co/api/v2/type/5/",
			"Flying": "https://pokeapi.co/api/v2/type/3/",
			"Psychic": "https://pokeapi.co/api/v2/type/14/",
			"Bug": "https://pokeapi.co/api/v2/type/7/",
			"Rock": "https://pokeapi.co/api/v2/type/6/",
			"Ghost": "https://pokeapi.co/api/v2/type/8/",
			"Dragon": "https://pokeapi.co/api/v2/type/16/",
			"Steel": "https://pokeapi.co/api/v2/type/9/",
			"Dark": "https://pokeapi.co/api/v2/type/17/",
			"Fairy": "https://pokeapi.co/api/v2/type/18/"
		};

		final response = await http.get(types_urls[filter]);
		final result = json.decode(response.body);
		Iterable pokemons = result['pokemon'];

		return Future.wait(pokemons.map((model) async	=>Pokemons.fromJson(await Pokemons().getPokemon(model['pokemon']))));
	}
}
