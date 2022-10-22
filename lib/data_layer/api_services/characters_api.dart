
import 'package:breakingbad_bloc/constant/string_constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
class CharactersApi{
  late Dio dio;
  CharactersApi(){
    BaseOptions options=BaseOptions(
      baseUrl: baseUrl,
      //دى بتعطينى معلومات لو عندى اخطا بيقولى اية الى بيحصل
      receiveDataWhenStatusError: true,
      // is meaning must load as 60 secand 60*1000
      connectTimeout:20*1000 ,
      receiveTimeout:20*1000 ,
    );
    dio=Dio(options);
  }
  //up is تظبيط ال dio

  Future<List<dynamic>>getAllCharacters()async {
    try {
      Response response = await dio.get('characters');
      if (kDebugMode) {
        print(response.data.toString());
      }
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      //فى حاله وجود خطا طلع ليه ليست فاضيه
      return [];
    }
  }


    Future<List<dynamic>>getCharactersQuotes(String charName)async{
      try{
        Response response=await dio.get('quote',queryParameters: {'author':charName});
        if (kDebugMode) {
          print(response.data.toString());
        }
        return response.data;
      }catch(e){
        if (kDebugMode) {
          print(e.toString());
        }
        //فى حاله وجود خطا طلع ليه ليست فاضيه
        return [];
      }



  }

}