import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nba_api_app/models/team_model.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List<Team> teams = [];

  Future<dynamic> getTeams() async {
    var url = Uri.parse('https://www.balldontlie.io/api/v1/teams');
    //var response = await http.get(Uri.https('balldontlie.io', '/api/v1/teams')); // variant method without the need to parse an url
    var response = await http.get(url);
    var jsonData = jsonDecode(response
        .body); // response.body is a String , and jsonDecode takes the string and returns the corresponding JSON object.
    //print(jsonData['meta']);
    for (var teamItem in jsonData['data']) {
      final team = Team(
          abbreviation: teamItem['abbreviation'],
          fullName: teamItem['full_name'],
          city: teamItem['city']);
      teams.add(team);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getTeams(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: teams.length,
                    itemBuilder: (context, index) => Card(
                          child: ListTile(
                              title: Text(teams[index].abbreviation),
                              subtitle: Text(teams[index].city),
                              trailing: Text(teams[index].fullName)),
                        ));
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
