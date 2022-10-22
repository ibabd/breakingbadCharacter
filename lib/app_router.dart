import 'package:breakingbad_bloc/business_layer/character_cubit.dart';
import 'package:breakingbad_bloc/constant/string_constant.dart';
import 'package:breakingbad_bloc/data_layer/api_services/characters_api.dart';
import 'package:breakingbad_bloc/data_layer/model/characters_model.dart';
import 'package:breakingbad_bloc/data_layer/repository/character_repository.dart';
import 'package:breakingbad_bloc/presentation_layer/screens/character_details_screen.dart';
import 'package:breakingbad_bloc/presentation_layer/screens/character_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AppRouter{
  late CharactersRepository charactersRepository;
  late CharacterCubit characterCubit;
  AppRouter(){
    charactersRepository=CharactersRepository(CharactersApi());
    characterCubit=CharacterCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings){
  switch(settings.name){
    case characterScreen:
      return MaterialPageRoute(builder: (_)=>BlocProvider(
          create: (BuildContext context)=>
              characterCubit,
        child: const CharacterScreen(),
      ),
      );
    case characterDetailsScreen:
      //انا عاوز اباصى الداتا او الاوبجكت بتاع الcharacter الى بيعرض كل item فى شاشه التفاصيل
      // دة الاوبجكت بتاع الى المفروض اباصيه لما اجى اروح ل details screen
      final character=settings.arguments as Character;
      return MaterialPageRoute(builder: (_)=>
          BlocProvider(
            create: (BuildContext context)=>
                //هنا بنشئ كيوبت جديد مختلف عن الكيوبت ال فوق بداتا مختلفه
                CharacterCubit(charactersRepository),
              child: CharacterDetailsScreen(character: character, )));
  }
  return null;
  }
}

// انا عارف ان اى حاجه فى فلاتر هى ويدجت فبتالى characterScreen is widget && characterDetailsScreen is a widget
// احنا عارفين ان الى هيوفر لية البلوك او الى هينشئه هو blocProvider فانا هحط البلوك بوفيد علشان يتشاف فى الى تحته
//blocProvider هو الى ماسك الويدجت ترى من فوق انشئ ليه بلوك الى هو characterCubit ثم بعد ذالك اعطى child الصفحه الى تعتبر ويدجت
