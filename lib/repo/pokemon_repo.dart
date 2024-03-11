import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:pokemonapp/model/pokemon_data.dart';

class PokemonRepo {
 static Future<List<Pokemon>> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json'));
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        print("response: ${response.body}");
        final data = PokemonData.fromJson(jsonDecode(response.body));
        // Log the entire list of Pokemon
        log("All Pokemon: ${jsonEncode(data.pokemon)}");
        log("Total number of Pokemon: ${data.pokemon?.length}");

        // Log details of each Pokemon
        data.pokemon?.forEach((pokemon) {
          log("Pokemon ID: ${pokemon.id}, Name: ${pokemon.name}, Num: ${pokemon.num}");
          // Log other properties as needed...
        });

        return data.pokemon ?? [];
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      rethrow;
    }
  }
}
