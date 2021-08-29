import 'package:flutter/material.dart';
import 'package:nhl_league_2019_eric/widgets/team_card.dart';
import 'dart:math';
import 'dart:async';

// List<Map> teamData = [
//   {
//     'name': 'Blues',
//     'image': 'assets/images/blues_logo.png',
//   },
//   {
//     'name': 'Bruins',
//     'image': 'assets/images/bruins_logo.png',
//   },
//   {
//     'name': 'Sharks',
//     'image': 'assets/images/sharks_logo.png',
//   },
//   {
//     'name': 'Hurricanes',
//     'image': 'assets/images/hurricanes_logo.png',
//   },
//   {
//     'name': 'Avalanche',
//     'image': 'assets/images/avalanche_logo.png',
//   },
//   {
//     'name': 'Stars',
//     'image': 'assets/images/stars_logo.png',
//   },
//   {
//     'name': 'Blue Jackets',
//     'image': 'assets/images/blue_jackets_logo.png',
//   },
//   {
//     'name': 'Islanders',
//     'image': 'assets/images/islanders_logo.png',
//   },
//   {
//     'name': 'Capitals',
//     'image': 'assets/images/capitals_logo.png',
//   },
//   {
//     'name': 'Maple Leafs',
//     'image': 'assets/images/maple_leafs_logo.png',
//   },
//   {
//     'name': 'Golden Knights',
//     'image': 'assets/images/golden_knights_logo.jpeg',
//   },
//   {
//     'name': 'Predators',
//     'image': 'assets/images/predators_logo.png',
//   },
//   {
//     'name': 'Jets',
//     'image': 'assets/images/jets_logo.png',
//   },
//   {
//     'name': 'Flames',
//     'image': 'assets/images/flames_logo.png',
//   },
//   {
//     'name': 'Penguins',
//     'image': 'assets/images/penguins_logo.png',
//   },
//   {
//     'name': 'Lightning',
//     'image': 'assets/images/lightning_logo.png',
//   },
// ];

Map teamData2 = {
  'Blues': 'assets/images/blues_logo.png',
  'Bruins': 'assets/images/bruins_logo.png',
  'Sharks': 'assets/images/sharks_logo.png',
  'Hurricanes': 'assets/images/hurricanes_logo.png',
  'Avalanche': 'assets/images/avalanche_logo.png',
  'Stars': 'assets/images/stars_logo.png',
  'Blue Jackets': 'assets/images/blue_jackets_logo.png',
  'Islanders': 'assets/images/islanders_logo.png',
  'Capitals': 'assets/images/capitals_logo.png',
  'Maple Leafs': 'assets/images/maple_leafs_logo.png',
  'Golden Knights': 'assets/images/golden_knights_logo.jpeg',
  'Predators': 'assets/images/predators_logo.png',
  'Jets': 'assets/images/jets_logo.png',
  'Flames': 'assets/images/flames_logo.png',
  'Penguins': 'assets/images/penguins_logo.png',
  'Lightning': 'assets/images/lightning_logo.png',
};
List titles = [
  'Entries',
  'First Round',
  'Second Round',
  'Semi Final',
  'Final',
  ''
  // '2019 NHL PLAY OFF WINNER !!'
];

class LeagueScreen extends StatefulWidget {
  const LeagueScreen({Key? key}) : super(key: key);

  @override
  _LeagueScreenState createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeagueScreen>
    with SingleTickerProviderStateMixin {
  bool? _isRoundDone;
  List? score;

  List<Map>? leagueResult;
  List<Map>? leagueResult2;
  Random? random;
  int? winCount;
  int? lostCount;

  int? _count;

  bool _visible = true;

  Map<int, List>? _league = {0: [], 1: [], 2: [], 3: [], 4: []};

  AnimationController? _animationController;

  Map? _showLeagueScore;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isRoundDone = false;
    score = [];
    random = new Random();
    winCount = 0;
    lostCount = 0;
    leagueResult = [{}, {}, {}, {}, {}];

    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    Timer(Duration(milliseconds: 200), () => _animationController!.forward());
    // leagueResult2 = [{}, {}, {}, {}, {}];

    // teamData..shuffle();

    // teamData.forEach((element) {
    //   _league![0]!.add(element['name']);
    // });

    _count = 0;
    getresult();

    _showLeagueScore = {
      for (var item in teamData2.keys.toList()) '$item': false
    };
  }

  getresult() {
    List temp = [];
    temp = teamData2.keys.toList();
    temp..shuffle();
    // print(temp);

    _league![0] = temp;

    // for (int j = 0; j < 4; j++) {
    //   for (int i = 0; i < _league![j]!.length; i = i + 2) {
    //     buildMatchResult(_league![j]![i], _league![j]![i + 1], j);
    //   }
    //   buildNextLeague(j);
    // }

    buildMatchResult2(
      _league![0]!,
      0,
      0,
    );
    // print(leagueResult2![2]);

    // print(leagueResult![0]);
    // print(leagueResult2![3]);
  }

  // buildMatchResult(
  //   String team1,
  //   String team2,
  //   int matchNumber,
  // ) {
  //   int randomNumber1 = random!.nextInt(10); // from
  //   int randomNumber2 = random!.nextInt(10);

  //   if (_isRoundDone!) {
  //     setState(() {
  //       if (winCount == 4)
  //         leagueResult![matchNumber].addAll({team1 + '.' + team2: score});
  //       else
  //         leagueResult![matchNumber].addAll({team2 + '.' + team1: score});
  //       winCount = 0;
  //       lostCount = 0;
  //     });
  //     _isRoundDone = false;
  //     score = [];

  //     return;
  //   }
  //   if (!_isRoundDone!) {
  //     if (randomNumber2 != randomNumber1) {
  //       if (randomNumber1 > randomNumber2) {
  //         winCount = winCount! + 1;
  //       } else {
  //         lostCount = lostCount! + 1;
  //       }
  //       score!.add({team1: randomNumber1, team2: randomNumber2});
  //     }
  //   }

  //   if (winCount! >= 4 || lostCount! >= 4) {
  //     _isRoundDone = true;
  //   }

  //   buildMatchResult(team1, team2, matchNumber);
  // }

  buildMatchResult2(
    List teams,
    int index,
    int matchNumber,
  ) {
    int randomNumber1 = random!.nextInt(10); // from
    int randomNumber2 = random!.nextInt(10);

    if (_isRoundDone!) {
      // print(score);
      // setState(() {
      if (winCount == 4)
        leagueResult![matchNumber]
            .addAll({teams[index] + '.' + teams[index + 1]: score});
      else
        leagueResult![matchNumber]
            .addAll({teams[index + 1] + '.' + teams[index]: score});
      winCount = 0;
      lostCount = 0;
      // });
      _isRoundDone = false;
      score = [];

      index = index + 2;

      // print('index :  $index, matchumber: $matchNumber');

      if (index == teams.length) {
        index = 0;
        teams = [];

        leagueResult![matchNumber].forEach((key, value) {
          // _leagueSecondTeamleagueResult!.add(key.split(".")[0]);
          teams.add(key.split(".")[0]);
        });
        matchNumber = matchNumber + 1;
        _league![matchNumber] = teams;
        // print(teams);

        if (teams.length == 1) {
          return;
        } else {
          buildMatchResult2(
            teams,
            index,
            matchNumber,
          );
        }
      } else {
        return buildMatchResult2(
          teams,
          index,
          matchNumber,
        );
      }
    } else {
      if (!_isRoundDone!) {
        if (randomNumber2 != randomNumber1) {
          if (randomNumber1 > randomNumber2) {
            winCount = winCount! + 1;
          } else {
            lostCount = lostCount! + 1;
          }
          // score!.add({team1: randomNumber1, team2: randomNumber2});
          score!.add(
              {teams[index]: randomNumber1, teams[index + 1]: randomNumber2});
        }
      }

      if (winCount! >= 4 || lostCount! >= 4) {
        _isRoundDone = true;
      }
      buildMatchResult2(
        teams,
        index,
        matchNumber,
      );
    }
  }

  buildResult(String teamName, int number) {
    List<Widget>? result = [];
    leagueResult![number].forEach((key, value) {
      if (key!.contains('$teamName')) {
        // result!.add(Text(value)
        for (int i = 0; i < value.length; i++) {
          if (value[i] != null) {
            result.add(Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${value[i][teamName]}',
                    style: TextStyle(fontSize: 18),
                  )
                ]));
          }
        }
      }
    });
    // print('result?');

    return result;
  }

  buildNextLeague(int leagueNumber) {
    leagueResult![leagueNumber].forEach((key, value) {
      // _leagueSecondTeamData!.add(key.split(".")[0]);
      _league![leagueNumber + 1]!.add(key.split(".")[0]);
    });
  }

  buildLeague(List data, int leagueNumber, bool showResult, double hsize,
      double wsize) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 100),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (context, index) {
              // print(data[index]);
              return Container(
                  height: hsize,
                  width: wsize,
                  child: Column(
                    children: [
                      // buildLeague(),
                      leagueNumber >= 4
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 50,
                                ),
                                TeamCard(
                                  // isIcon: leagueNumber == 0 ? true : false,
                                  isIcon: false,
                                  image: teamData2[data[index]],
                                  teamName: data[index],
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Final Winner !!',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                ...buildResult(data[index], leagueNumber),
                              ],
                            )
                          : Column(
                              children: [
                                TeamCard(
                                  isIcon: false,
                                  image: teamData2[data[index]],
                                  teamName: data[index],
                                ),
                                showResult
                                    ? Column(
                                        children: [
                                          Container(
                                            child: Text('score'),
                                          ),
                                          ...buildResult(
                                              data[index], leagueNumber),
                                          Divider(),
                                          _league![leagueNumber + 1]!
                                                  .contains(data[index])
                                              ? Text(
                                                  'Win',
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 20),
                                                )
                                              : Text('Lost'),
                                        ],
                                      )
                                    : SizedBox.shrink(),
                              ],
                            )
                    ],
                  ));
            }),
      ),
    );
  }

  buildLeague2(List data, int leagueNumber) {
    List<Widget> result = [];
    // print(data);
    for (int i = 0; i < data.length; i = i + 2) {
      result.add(buildSingleMatch(data[i], data[i + 1], leagueNumber));
    }
    return Center(
      child: Container(
        padding: leagueNumber == 3
            ? EdgeInsets.fromLTRB(170, 100, 0, 0)
            : leagueNumber >= 2
                ? EdgeInsets.fromLTRB(100, 100, 0, 0)
                : EdgeInsets.only(top: 100),
        height: leagueNumber >= 3 ? 750 : 600,
        width: double.infinity,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: result.length,
            itemBuilder: (context, index) {
              // print(data[index]);
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: result[index],
              );
            }),
      ),
    );
  }

  buildFinal(int index) {
    List<Widget>? _resultList = [
      buildSlide(
        buildLeague(_league![0]!, 0, false, 200, 200),
      ),
      buildLeague2(_league![0]!, 0),
      buildLeague2(_league![1]!, 1),
      buildLeague2(_league![2]!, 2),
      buildLeague2(_league![3]!, 3),
      buildLeague(_league![4]!, 4, true, 300, 800),
    ];
    return _resultList[index];
  }

  buildSlide(Widget _child) {
    return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(1, 0),
          end: Offset.zero,
          // end: Offset(-1, 0),
        ).animate(_animationController!),
        child: FadeTransition(
          opacity: _animationController!,
          child: Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: _child,
          ),
        ));
  }

  resetShowScore() {
    _showLeagueScore = {
      for (var item in teamData2.keys.toList()) '$item': false
    };
  }

  buildCard(String teamName, leagueNumber) {
    return Container(
      padding: EdgeInsets.all(10),
      // margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          TeamCard(
            isIcon: leagueNumber <= 2 ? true : false,
            // isIcon: true,
            image: teamData2[teamName],
            teamName: teamName,
          ),
        ],
      ),
    );
  }

  buildScore(
      String teamName1, String teamName2, int leaguNumber, bool showDetail) {
    List<Widget>? result = [];
    int winCountTeam1 = 0;
    int winCountTeam2 = 0;

    leagueResult![leaguNumber].forEach((key, value) {
      if (key!.contains('$teamName1')) {
        // print('key: ${leagueResult![leaguNumber][key]}');
        // result!.add(Text(value)
        for (int i = 0; i < value.length; i++) {
          if (value[i][teamName1] > value[i][teamName2])
            winCountTeam1++;
          else
            winCountTeam2++;
          if (showDetail) if (value[i] != null) {
            result.add(Container(
              margin: EdgeInsets.all(2),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 35),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.yellow, width: 4),
              ),
              child: Row(
                children: [
                  Text(
                    '${value[i][teamName1]}',
                    style: TextStyle(
                        fontSize: 18,
                        color: value[i][teamName1] > value[i][teamName2]
                            ? Colors.blue
                            : Colors.black),
                  ),
                  Text('           -          '),
                  Text(
                    '${value[i][teamName2]}',
                    style: TextStyle(
                        fontSize: 18,
                        color: value[i][teamName1] < value[i][teamName2]
                            ? Colors.blue
                            : Colors.black),
                  )
                ],
              ),
            ));
          }
        }
      }
    });
    // print('result?');

    return Container(
      padding: EdgeInsets.all(20),
      // decoration: BoxDecoration(border: Border.all()),
      child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...result,
            Divider(),
            winCountTeam1 > winCountTeam2
                ? Text(
                    '$teamName1 Wins $winCountTeam1 - $winCountTeam2',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  )
                : Text(
                    '$teamName2 Wins $winCountTeam2 - $winCountTeam1',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
          ]),
    );
  }

  buildSingleMatch(String teamName1, String teamName2, int leaguNumber) {
    return Container(
      child: Column(children: [
        InkWell(
          onTap: () {
            setState(() {
              _showLeagueScore![teamName1] = !_showLeagueScore![teamName1];
            });
          },
          child: Container(
            child: Row(
              children: [
                // buildSlide(
                buildCard(teamName1, leaguNumber),
                // SizedBox(height: 150),
                SizedBox(
                  width: 50,
                ),
                Text(
                  'VS',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
                SizedBox(
                  width: 50,
                ),
                buildCard(teamName2, leaguNumber),
              ],
            ),
          ),
        ),
        // SizedBox(height: 20),
        _showLeagueScore![teamName1]
            ? buildScore(teamName1, teamName2, leaguNumber, true)
            // : SizedBox.shrink(),
            : buildScore(teamName1, teamName2, leaguNumber, false)
      ]),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: const Text('League is Done')),
            actions: <Widget>[
              TextButton(
                child: const Text('BACK HOME'),
                onPressed: () {
                  // Navigator.of(context).popUntil((route) => '/');
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  // Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(score);

    // print(_showLeagueScore);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // backgroundColor: Color(0x44000000),
        elevation: 0,
        title: Text(
          // _count! == 5 ? '2019 NHL PLAY OFF WINNER !!' : '',
          titles[_count!],
          style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              color: _count == 5 ? Colors.blueAccent : Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          // padding: EdgeInsets.only(top: 100),
          // height: 550,s
          // width: double.infinity,
          decoration: BoxDecoration(
            // color: Colors.yellow,
            image: DecorationImage(
              image: _count! < 5
                  ? AssetImage("assets/images/background_3.jpeg")
                  : AssetImage("assets/images/background_5.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            // alignment: Alignment.bottomCenter,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Center(
                  child: AnimatedOpacity(
                    opacity: _visible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 1000),
                    // The green box must be a child of the AnimatedOpacity widget.
                    child: buildFinal(_count!),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        label: Text(_count! == 0 ? 'Start!' : 'Next',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold)),
        onPressed: () async {
          setState(() {
            _visible = !_visible;
          });

          if (_count == 5) {
            _showMyDialog();
          }
          resetShowScore();

          Future.delayed(const Duration(milliseconds: 1500), () {
            if (mounted) {
              setState(() {
                _count = _count! + 1;

                if (_count == 6) {
                  _count = 0;
                }

                _visible = !_visible;
              });
            }
          });
        },
        //  _incrementCounter,
        tooltip: 'Increment',
        // label: Text('Approve'),/
        icon: Icon(Icons.check),
      ), //
    );
  }
}
