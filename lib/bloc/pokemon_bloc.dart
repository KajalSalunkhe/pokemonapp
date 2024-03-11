// import 'package:bloc/bloc.dart';
// import 'package:pokemonapp/model/pokemon_data.dart';
// import 'package:pokemonapp/repo/pokemon_repo.dart';

// part 'pokemon_event.dart';
// part 'pokemon_state.dart';

// class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
//   PokemonBloc() : super(PokemonInitial()) {
//     on<FetchPokemonData>((event, emit) async {
//       // TODO: implement event handler
//       emit(PokemonInitial());
//       try {
//         final data = await PokemonRepo.fetchData();
//         print(data.toString());
//         emit(PokemonLoaded(data));
//       } catch (err) {
//         rethrow;
//       }
//     });
//   }
// }
