import 'package:pokedex/constants.dart';

String capitalize(String text) {
	return "${text[0].toUpperCase()}${text.substring(1)}";
}

dynamic getTypeColors(List pokeType){
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

	return types_colors[pokeType[0]['type']['name']];
}
