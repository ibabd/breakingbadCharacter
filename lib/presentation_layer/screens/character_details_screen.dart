import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breakingbad_bloc/business_layer/character_cubit.dart';
import 'package:breakingbad_bloc/constant/color_constant.dart';
import 'package:breakingbad_bloc/data_layer/model/characters_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;
  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);

  Widget buildSliverAppBar() {
    return SliverAppBar(
      //sliverAppBar دة الى بتحكم فى الصورة والتكست بقدر اعمل زووم كل دة من خلال ٍ
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.nickName,
          style: const TextStyle(
            color: MyColors.myWhite,
          ),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [
        TextSpan(
          text: title,
          style: const TextStyle(
            color: MyColors.myWhite,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        TextSpan(
          text: value,
          style: const TextStyle(
            color: MyColors.myWhite,
            fontSize: 16,
          ),
        ),
      ]),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: MyColors.myYellow,
      thickness: 2,
    );
  }

  Widget checkIfQuotesIsLoaded(CharacterState state){
    if(state is QuotesLoaded){
      return displayRandomQuoteOrEmptySpace(state);
    }else{
      return showProgressIndicator();
    }
  }
  Widget showProgressIndicator(){
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget displayRandomQuoteOrEmptySpace(state){
    var quotes=(state).quotes;
    if(quotes.length !=0){
      //generate number random
      int randomQuoteIndex=Random().nextInt(quotes.length-1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            color: MyColors.myWhite,
            shadows: [
              Shadow(
                blurRadius: 7,
                color: MyColors.myYellow,
                offset:Offset (0,0),
              )
            ]
          ), child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            FlickerAnimatedText(quotes[randomQuoteIndex].quote),
          ],
        ),
        ),
      );
    }else{
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharacterCubit>(context).getQuotes(character.name);
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //join is function تطبق على string انا بفصل بين كل وظيفه ووظيفه ب /
                  characterInfo('job : ', character.jobs.join(' / ')),
                  //315.0 عبارة عن المسافه الفاضيه
                  buildDivider(315.0),
                  characterInfo(
                      'Appeared in : ', character.categoryForTwoSeries),
                  buildDivider(250),
                  characterInfo(
                      'seasons : ', character.appearanceOfSeasons.join(' / ')),
                  buildDivider(280),
                  characterInfo('status : ', character.statusIfDeadOrAlive),
                  buildDivider(300),
                  character.betterCallSaulAppearance.isEmpty
                      ? Container()
                      : characterInfo('Better Call saul Seasons : ',
                          character.betterCallSaulAppearance.join(' / ')),
                  //دة شرط علشان مش يرسم الdivider وهو فاضى
                  character.betterCallSaulAppearance.isEmpty?
                  Container():
                  buildDivider(150),
                  characterInfo(
                      'Actor /Actress : ', character.acotrName),
                  buildDivider(235),
                  const SizedBox(height: 20,),
                  BlocBuilder<CharacterCubit,CharacterState>(
                      builder: (context,state){
                        return checkIfQuotesIsLoaded(state);
                      },
                  ),
                ],
              ),
            ),
                const SizedBox(height: 500,),
          ],
              ),
          ),
        ],
      ),
    );
  }
}
