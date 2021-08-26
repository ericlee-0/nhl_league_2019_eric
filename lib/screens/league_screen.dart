import 'package:flutter/material.dart';
import 'package:nhl_league_2019_eric/widgets/team_card.dart';
import 'dart:math';

List<Map> teamData = [
  {
    'name': 'Blues',
    'image': 'assets/images/blues_logo.png',
  },
  {
    'name': 'Bruins',
    'image': 'assets/images/bruins_logo.png',
  },
  {
    'name': 'Sharks',
    'image': 'assets/images/sharks_logo.png',
  },
  {
    'name': 'Hurricanes',
    'image': 'assets/images/hurricanes_logo.png',
  },
  {
    'name': 'Avalanche',
    'image': 'assets/images/avalanche_logo.png',
  },
  {
    'name': 'Stars',
    'image': 'assets/images/stars_logo.png',
  },
  {
    'name': 'Blue Jackets',
    'image': 'assets/images/blue_jackets_logo.png',
  },
  {
    'name': 'Islanders',
    'image': 'assets/images/islanders_logo.png',
  },
  {
    'name': 'Capitals',
    'image': 'assets/images/capitals_logo.png',
  },
  {
    'name': 'Maple Leafs',
    'image': 'assets/images/maple_leafs_logo.png',
  },
  {
    'name': 'Golden Knights',
    'image': 'assets/images/golden_knights_logo.jpeg',
  },
  {
    'name': 'Predators',
    'image': 'assets/images/predators_logo.png',
  },
  {
    'name': 'Jets',
    'image': 'assets/images/jets_logo.png',
  },
  {
    'name': 'Flames',
    'image': 'assets/images/flames_logo.png',
  },
  {
    'name': 'Penguins',
    'image': 'assets/images/penguins_logo.png',
  },
  {
    'name': 'Lightning',
    'image': 'assets/images/lightning_logo.png',
  },
];

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

class LeagueScreen extends StatefulWidget {
  const LeagueScreen({Key? key}) : super(key: key);

  @override
  _LeagueScreenState createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeagueScreen> {
  bool? _isRoundDone;
  List? score;

  List<Map>? leagueResult;
  Map? leagueResult2;
  Random? random;
  int? winCount;
  int? lostCount;

  int? _count;

  bool _visible = true;

  Map<int, List>? _league = {0: [], 1: [], 2: [], 3: [], 4: []};
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
    leagueResult2 = {};

    teamData..shuffle();

    teamData.forEach((element) {
      _league![0]!.add(element['name']);
    });

    _count = 0;
    getresult();
  }

  getresult() {
    for (int j = 0; j < 4; j++) {
      for (int i = 0; i < _league![j]!.length; i = i + 2) {
        buildMatchResult(_league![j]![i], _league![j]![i + 1], j);
      }
      buildNextLeague(j);
    }
  }

  buildMatchResult(String team1, String team2, int matchNumber) {
    int randomNumber1 = random!.nextInt(10); // from
    int randomNumber2 = random!.nextInt(10);

    if (_isRoundDone!) {
      setState(() {
        if (winCount == 4)
          leagueResult![matchNumber].addAll({team1 + '.' + team2: score});
        else
          leagueResult![matchNumber].addAll({team2 + '.' + team1: score});
        winCount = 0;
        lostCount = 0;
      });
      _isRoundDone = false;
      score = [];

      return;
    }
    if (!_isRoundDone!) {
      if (randomNumber2 != randomNumber1) {
        if (randomNumber1 > randomNumber2) {
          winCount = winCount! + 1;
        } else {
          lostCount = lostCount! + 1;
        }
        score!.add({team1: randomNumber1, team2: randomNumber2});
      }
    }

    if (winCount! >= 4 || lostCount! >= 4) {
      _isRoundDone = true;
    }

    buildMatchResult(team1, team2, matchNumber);
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
        height: 550,
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

  buildFinal(int index) {
    List<Widget>? _resultList = [
      buildLeague(_league![0]!, 0, false, 200, 200),
      buildLeague(_league![0]!, 0, true, 100, 100),
      buildLeague(_league![1]!, 1, true, 120, 120),
      buildLeague(_league![2]!, 2, true, 150, 200),
      buildLeague(_league![3]!, 3, true, 300, 450),
      buildLeague(_league![4]!, 4, true, 300, 800),
    ];
    return _resultList[index];
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: const Text('League is Done')),
            // content: SingleChildScrollView(
            //   child: ListBody(
            //     children: const <Widget>[
            //       // Text('This is a demo alert dialog.'),
            //       // Text('Would you like to approve of this message?'),
            //     ],
            //   ),
            // ),
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
  Widget build(BuildContext context) {
    // print(score);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // backgroundColor: Color(0x44000000),
        elevation: 0,
        title: Text(
          _count! == 5 ? '2019 NHL PLAY OFF WINNER !!' : '',
          style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            // color: Colors.yellow,
            image: DecorationImage(
              image: _count! < 3
                  ? AssetImage("assets/images/background_3.jpeg")
                  : AssetImage("assets/images/background_4.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
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
