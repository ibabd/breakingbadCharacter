import 'package:breakingbad_bloc/constant/color_constant.dart';
import 'package:breakingbad_bloc/constant/string_constant.dart';
import 'package:breakingbad_bloc/data_layer/model/characters_model.dart';
import 'package:flutter/material.dart';
class CharacterItem extends StatelessWidget {
  final Character character;
  const CharacterItem({Key? key,required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, characterDetailsScreen,arguments: character);
        },
        child: GridTile(
          child: Hero(
            tag: character.charId,
            child: Container(
              color: MyColors.myGrey,
              child: character.image.isNotEmpty ?
                  //عقبال مالصورة تيجى يعرض الlooding
               FadeInImage.assetNetwork(
                 width: double.infinity,
                  height: double.infinity,
                  placeholder: 'assets/images/loading.gif',
                  image: character.image,
                 fit: BoxFit.cover,

              ):Image.asset('assets/images/svg.png'),
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            color: Colors.black45,
            alignment: Alignment.bottomCenter,
            child: Text(character.name,style: const TextStyle(
            height: 1.3,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: MyColors.myWhite,
            ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
