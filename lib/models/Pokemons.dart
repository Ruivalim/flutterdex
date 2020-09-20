import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Pokemon{
	final String name;
	final String image;
	final List types;
	final num id;

	Pokemon({this.name, this.image, this.types, this.id});

	factory Pokemon.fromJson(Map<String,dynamic> json) {
		return Pokemon(
			name: json['name'],
			image: json['sprites']['other']['official-artwork']['front_default'],
			types: json['types'],
			id: json['id']
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
}
