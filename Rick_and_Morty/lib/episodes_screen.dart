import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rickandmorty/character_tile.dart';
import 'package:http/http.dart' as http;
import 'package:rickandmorty/models.dart';

class EpisodesScreen extends StatelessWidget {
  const EpisodesScreen({super.key, this.id});
  final int? id;
  Future<List<Character>> fetchEpisodes() async {
    final response =
        await http.get(Uri.parse('https://rickandmortyapi.com/api/episode'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      final results = jsonData['results'] as List<dynamic>;
      return results
          .map((characterJson) => Character.fromJson(characterJson))
          .toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rick and Morty Episodes')),
      body: FutureBuilder(
        future: fetchEpisodes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final episodes = snapshot.data!;
            return ListView.builder(
              itemCount: episodes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    '* ${episodes[index].name!}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
