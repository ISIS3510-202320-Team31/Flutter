import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hive_app/view/widgets/OfflineWidget.dart';
import 'package:hive_app/view_model/event.vm.dart';
import 'package:provider/provider.dart';

import '../../data/remote/response/Status.dart';

class PieChartGraph extends StatefulWidget {
  final String userId;
  @override
  const PieChartGraph({required this.userId});
  _PieChartGraphState createState() => _PieChartGraphState();
}

class _PieChartGraphState extends State<PieChartGraph> {
  final EventVM eventVM = EventVM();
  Future<List>? storedStats;
  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  @override
  void initState() {
    storedStats = eventVM.getLocalStats();
    super.initState();
    eventVM.statsUser(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        margin: EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 8,
        child: ChangeNotifierProvider<EventVM>(
          create: (BuildContext context) => eventVM,
          child: Consumer<EventVM>(
            builder: (context, viewModel, _) {
              switch (viewModel.stats.status) {
                case Status.LOADING:
                  print("Log :: LOADING");
                  return FutureBuilder<List>(
                      future: storedStats,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return Container();
                        else if (snapshot.hasError) {
                          return Container();
                        } else if (snapshot.hasData) {
                          return Column(
                            children: [
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              Center(
                                  child: Text(
                                "Eventos por categoría",
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 0, 0,
                                      0), // Ajusta el color del texto según sea necesario
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              )),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.08),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: PieChart(
                                        PieChartData(
                                          sectionsSpace: 0,
                                          centerSpaceRadius: 0,
                                          sections: List.generate(
                                            snapshot.data!.length,
                                            (index) => PieChartSectionData(
                                              color: hexToColor(snapshot
                                                  .data?[index]["color"]),
                                              value: snapshot.data?[index]
                                                  ["value"],
                                              title: snapshot.data![index]
                                                          ["value"]
                                                      .toString() +
                                                  "%",
                                              radius: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              titleStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.05),
                              Expanded(
                                flex: 2,
                                child: LegendList(data: snapshot.data),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                            ],
                          );
                        } else
                          return Container();
                      });
                case Status.OFFLINE:
                  print("Log :: OFFLINE");
                  return OfflineWidget();
                case Status.ERROR:
                  print("Log :: ERROR");
                  return Center(
                    child: Text(
                        "Estamos presentando errores... Intenta refrescar"),
                  );
                case Status.COMPLETED:
                  eventVM.saveLocalStats();
                  print("Log :: COMPLETED");
                  // eventVM.saveLocalEventsFeed();
                  return Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Center(
                          child: Text(
                        "Eventos por categoría",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0,
                              0), // Ajusta el color del texto según sea necesario
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      )),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: PieChart(
                                PieChartData(
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 0,
                                  sections: List.generate(
                                    viewModel.stats.data!.length,
                                    (index) => PieChartSectionData(
                                      color: hexToColor(viewModel
                                          .stats.data?[index]["color"]),
                                      value: viewModel.stats.data?[index]
                                          ["value"],
                                      title: viewModel
                                              .stats.data![index]["value"]
                                              .toString() +
                                          "%",
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.25,
                                      titleStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Expanded(
                        flex: 2,
                        child: LegendList(data: viewModel.stats.data),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                    ],
                  );
                default:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}

class LegendList extends StatelessWidget {
  final List<dynamic>? data;

  LegendList({required this.data});

  @override
  Widget build(BuildContext context) {
    Color hexToColor(String code) {
      return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: data?.length,
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.02,
                    backgroundColor: hexToColor(data?[index]["color"]),
                  ),
                  SizedBox(width: 10),
                  Text(data?[index]["category"]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
