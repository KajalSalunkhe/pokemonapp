import 'package:flutter/material.dart';
import 'package:pokemonapp/model/pokemon_data.dart';
import 'package:pokemonapp/repo/pokemon_repo.dart';
import 'package:pokemonapp/screens/pokemon_detail_screen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late Future<List<Pokemon>> pokemonDataFuture;

  @override
  void initState() {
    super.initState();
    // Fetch data from the repository
    pokemonDataFuture = PokemonRepo.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon'),
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: pokemonDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            // Display data using GridView.builder
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final pokemon = snapshot.data![index];
                  return _buildPokemonCard(pokemon, context);
                },
              ),
            );
          } else {
            return Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}

Widget _buildPokemonCard(Pokemon pokemon, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PokemonDetailScreen(
                    pokemon: pokemon,
                  )));
    },
    child: Card(
      child: Column(
        children: [
          Image.network(
            pokemon.img ?? "",
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Text(
            pokemon.name ?? "",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    ),
  );
}
