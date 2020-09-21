import 'package:pokedex/constants.dart';

Map types_colors = {
		"normal": typeNormal,
		"fire": typeFire,
		"water": typeWater,
		"electric": typeElectric,
		"grass": typeGrass,
		"ice": typeIce,
		"fighting": typeFighting,
		"poison": typePoison,
		"ground": typeGround,
		"flying": typeFlying,
		"psychic": typePsychic,
		"bug": typeBug,
		"rock": typeRock,
		"ghost": typeGhost,
		"dragon": typeDragon,
		"steel": typeSteel,
		"dark": typeDark,
		"fairy": typeFairy,
		"unknown": typeUnknown
	};

String capitalize(String text) {
	return "${text[0].toUpperCase()}${text.substring(1)}";
}

dynamic getTypeColor(String type){
	return types_colors[type];
}

dynamic getTypeColors(List pokeType){
	return types_colors[pokeType[0]['type']['name']];
}

String normalize(String text){
	String removedNl = text.replaceAll("\n", " ");
	String removedFl = removedNl.replaceAll("\f", " ");
	String pokeWord = removedFl.replaceAll("POKéMON", "Pokémon");

	return pokeWord;
}
