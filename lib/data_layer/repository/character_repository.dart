import 'package:breakingbad_bloc/data_layer/api_services/characters_api.dart';
import 'package:breakingbad_bloc/data_layer/model/characters_model.dart';
import 'package:breakingbad_bloc/data_layer/model/quote.dart';

class CharactersRepository{
 final CharactersApi charactersApi;

  CharactersRepository(this.charactersApi);
 Future<List<Character>>fetchAllCharacters()async{
   //عاوز اعمل mapping to json
   final characters=await charactersApi.getAllCharacters();
   return characters.map((character) => Character.fromJson(character)).toList();
   //character is meaning every element {}
 }

 Future<List<Quote>>fetchCharacterQuotes(String charName)async{
   //عاوز اعمل mapping to json
   final quote=await charactersApi.getCharactersQuotes(charName);
   return quote.map((charQuote) => Quote.fromJson(charQuote)).toList();
   //character is meaning every element {}
 }
}