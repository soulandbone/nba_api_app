import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nba_api_app/models/team_model.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List<Team> teams = [];

  Future<dynamic> getTeams() async {
    var url = Uri.parse('https://www.balldontlie.io/api/v1/teams');
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    //print(jsonData['meta']);
    for (var team in jsonData['data']) {
      teams.add(Team(
          abbreviation: team['abbreviation'], fullName: team['full_name']));
    }
  }

  @override
  Widget build(BuildContext context) {
    getTeams();
    return Scaffold(
        body: FutureBuilder(
      future: getTeams(),
      builder: (context, snapshot) => ListView.builder(
          itemCount: teams.length,
          itemBuilder: (context, index) => Card(
                child: Text(teams[index].abbreviation),
              )),
    ));
  }
}
