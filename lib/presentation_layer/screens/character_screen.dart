import 'package:breakingbad_bloc/business_layer/character_cubit.dart';
import 'package:breakingbad_bloc/constant/color_constant.dart';
import 'package:breakingbad_bloc/data_layer/model/characters_model.dart';
import 'package:breakingbad_bloc/presentation_layer/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({Key? key}) : super(key: key);

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedForCharacter;
  bool isSearched = false;
  final _searchedTextController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchedTextController,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
        hintText: 'Find a character ...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myGrey, fontSize: 18),
      ),
      style: const TextStyle(color: MyColors.myGrey, fontSize: 18),
      onChanged: (searchedCharacter) {
        //الفانكشن دى هتاخد الى حاجه الى ببحث عنها وتجيب لية كل العناصر الى بتبدا بالحرف دة
        addSearchedForItemsToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedForItemsToSearchedList(String searchedCharacter) {
    //دى ليسته عاوز احط فيها الحاجات الى عاوز املاها
    //where is meaning condition such as if
    searchedForCharacter = allCharacters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (isSearched) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.clear,
              color: MyColors.myGrey,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearch,
            icon: const Icon(
              Icons.search,
              color: MyColors.myGrey,
            ))
      ];
    }
  }

  void _startSearch() {
    // this is mean navigate to another screen or provide stack
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      isSearched = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      isSearched = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchedTextController.clear();
    });
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'characters',
      style: TextStyle(color: MyColors.myGrey),
    );
  }

  @override
  void initState() {
    super.initState();
    allCharacters = BlocProvider.of<CharacterCubit>(context).getAllCharacters();
    // this line is meaning ui is request from cubit or bloc give her the data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: MyColors.myYellow,
          title: isSearched ? _buildSearchField() : _buildAppBarTitle(),
          actions: _buildAppBarActions(),
          leading: isSearched
              ? const BackButton(
                  color: MyColors.myGrey,
                )
              : Container()),
      //هعمل البلوك بيلدر علشان اشغل البلوك
      body: OfflineBuilder(connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        final bool connected = connectivity != ConnectivityResult.none;
        if (connected) {
          return buildBlocWidget();
        } else {
          return buildNoInternet();
        }
      },
        child: showLoadingIndicator(),
      ),

      //
    );
  }

  Widget buildNoInternet() {
    return Center(
      child: Container(
        color:Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'can\t connect ... check The Internet ',
              style: TextStyle(fontSize: 22.0, color: MyColors.myGrey),
            ),
            Image.asset('assets/images/No Internet.png')
          ],
        ),
      ),
    );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharacterCubit, CharacterState>(
        builder: (context, state) {
      //انا عند state وحدة اسمهاcharactersLoaded
      if (state is CharactersLoaded) {
        allCharacters = (state).characters;
        return buildLoadedList();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget buildLoadedList() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharacterList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharacterList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: _searchedTextController.text.isEmpty
          ? allCharacters.length
          : searchedForCharacter.length,
      itemBuilder: (context, index) {
        return CharacterItem(
          character: _searchedTextController.text.isEmpty
              ? allCharacters[index]
              : searchedForCharacter[index],
        );
      },
    );
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }
}
