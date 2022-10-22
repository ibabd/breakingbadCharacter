import 'package:bloc/bloc.dart';
import 'package:breakingbad_bloc/data_layer/model/characters_model.dart';
import 'package:breakingbad_bloc/data_layer/model/quote.dart';
import 'package:breakingbad_bloc/data_layer/repository/character_repository.dart';
import 'package:meta/meta.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  //cubit take data from repository so that i take object from repository
  final CharactersRepository charactersRepository;
  List<Character>myCharacters=[];
  List<Quote>myQuotes=[];
  CharacterCubit(this.charactersRepository) : super(CharacterInitial());
  List<Character>getAllCharacters(){
    charactersRepository.fetchAllCharacters().then((characters) {
      //emit is meaning ابتعد انطلق بمعنى خد ياui dtat that you need
      //cubit بيعمل emit لل state الى انت عاوزها
      emit(CharactersLoaded(characters));
      myCharacters=characters;
    });
    return myCharacters;
  }
  List<Quote>getQuotes(String charName){
    charactersRepository.fetchCharacterQuotes(charName).then((quotes) {
      //emit is meaning ابتعد انطلق بمعنى خد ياui dtat that you need
      //cubit بيعمل emit لل state الى انت عاوزها
      emit(QuotesLoaded(quotes));
      myQuotes=quotes;
    });
    return myQuotes;
  }
}
