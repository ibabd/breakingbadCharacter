 part of 'character_cubit.dart';

@immutable
abstract class CharacterState {}

class CharacterInitial extends CharacterState {}
class CharactersLoaded extends CharacterState{
  //فى حاله البيانات اتحملت الكونستركتور هيكون فية ليست من البيانات
  final List<Character>characters;

  CharactersLoaded(this.characters);

}
 class QuotesLoaded extends CharacterState{
   //فى حاله البيانات اتحملت الكونستركتور هيكون فية ليست من البيانات
   final List<Quote>quotes;

   QuotesLoaded(this.quotes);

 }
