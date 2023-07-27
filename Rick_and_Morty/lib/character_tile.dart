import 'package:flutter/material.dart';
import 'package:rickandmorty/episodes_screen.dart';
import 'package:rickandmorty/models.dart';

class CharacterTile extends StatelessWidget {
  final Character character;

  CharacterTile({required this.character});

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: Column(
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EpisodesScreen(id: character.id)),
                );
              },
              child: Image.network(
                character.img!,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                character.name!,
                style: TextStyle(color: Colors.white, fontSize: 35),
              ),
            ),
          ],
        ),
        //
      ],
    ));
  }
}
