import 'package:covid19_tracker/Model/WorldModel.dart';
import 'package:covid19_tracker/Services/states_services.dart';
import 'package:covid19_tracker/View/countries_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  bool isLoading = false;
  late final AnimationController _animationController =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  final List colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: statesServices.fetchworldStatesRecords(),
                  builder: (context, AsyncSnapshot<WorldModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          controller: _animationController,
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total":
                                  double.parse(snapshot.data!.cases.toString()),
                              "Recovered": double.parse(
                                  snapshot.data!.recovered.toString()),
                              "Death":
                                  double.parse(snapshot.data!.deaths.toString()),
                            },
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            animationDuration: const Duration(seconds: 1),
                            chartType: ChartType.ring,
                            chartRadius: 150,
                            colorList: const [
                              Color(0xff1aa260),
                              Color(0xff4285F4),
                              Color(0xffde5246)
                            ],
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * .04),
                            child: Card(
                              color: Colors.grey,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 8),
                                child: Column(
                                  children: [
                                    ReusableRow(
                                        title: "Total Cases",
                                        value: snapshot.data!.cases.toString()),
                                    ReusableRow(
                                        title: "Today Cases ",
                                        value:
                                            snapshot.data!.todayCases.toString()),
                                    ReusableRow(
                                        title: "Total Recovered",
                                        value:
                                            snapshot.data!.recovered.toString()),
                                    ReusableRow(
                                        title: "Today Recovered",
                                        value: snapshot.data!.todayRecovered
                                            .toString()),
                                    ReusableRow(
                                        title: "Total Death",
                                        value: snapshot.data!.deaths.toString()),
                                    ReusableRow(
                                        title: "Today Death",
                                        value: snapshot.data!.todayDeaths
                                            .toString()),
                                    ReusableRow(
                                        title: "Total Tests",
                                        value: snapshot.data!.tests.toString()),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesListScreen()));
                            },
                            child: Container(
                              height: 60,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.black),
                              child: const Center(
                                  child: Text(
                                "Track",
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          )
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      )),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(title), Text(value)],
        ),
        const SizedBox(
          height: 5,
        ),
        const Divider(
          color: Colors.white,
        )
      ],
    );
  }
}
