import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/widgets/BeeWrapper.dart';
import 'package:hive_app/view/widgets/PartnersCard.dart';
import 'package:hive_app/view/widgets/PieChartGraph.dart';
import 'package:hive_app/view/widgets/ViewsHeader.dart';
import 'package:hive_app/view_model/event.vm.dart';
import 'package:hive_app/data/remote/response/Status.dart';
import 'package:provider/provider.dart';

class Stats extends StatefulWidget {
  final String userId;
  const Stats({required this.userId});
   @override
  _StatsState createState() => _StatsState();

}

class _StatsState extends State<Stats> {
  late final statsObject;
  final EventVM eventVM = EventVM();
  final String userId = "1";

  @override
  void initState() {
    super.initState();
    statsObject=eventVM.statsUser();
  }

  @override
  Widget build(BuildContext context) {
     return BeeWrapper(
    childBuilder: (toggleBeeFollowing) =>
     Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [appTheme.primaryColor, appTheme.secondaryHeaderColor],
        ),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: ViewsHeader(
                              titleText: "Estadisticas",
                              imageCallback: toggleBeeFollowing,
                            ),
          ),
          PieChartGraph(data: statsObject),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          PartnersCard(partners: ["Luccas","Tony","Laura"]),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          ChangeNotifierProvider<EventVM>(
            create: (BuildContext context) => eventVM,
            child: Consumer<EventVM>(
              builder: (context, viewModel, _) {
                switch (viewModel.eventModel.status) {
                  case Status.LOADING:
                    print("Log :: LOADING");
                    return Center(
                                child: LinearProgressIndicator(),
                              );
                  case Status.OFFLINE:
                    print("Log :: OFFLINE");
                    return Center(
                                child: Text(
                                  "Revisa tu conexión y refresca la página",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                  case Status.ERROR:
                    print("Log :: ERROR");
                    return Center(
                                child: Text(
                                    "Estamos presentando errores... Intenta refrescar"),
                              );
                  case Status.COMPLETED:
                    print("Log :: COMPLETED");
                    eventVM.saveLocalEventsFeed();
                    return Container();
                  default:
                    return Container();
                }
              },
            ),
          ) // Aquí incluye el EventList
        ],
      ),
     )
    );
  }
}


