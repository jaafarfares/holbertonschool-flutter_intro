import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rickandmorty/character_tile.dart';
import 'package:rickandmorty/models.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List<Character>> fetchBbCharacters() async {
    final response =
        await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Rick and Morty',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: FutureBuilder<List<Character>>(
        future: fetchBbCharacters(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final character = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CharacterTile(character: character),
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
