import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/widgets/BeeWrapper.dart';
import 'package:hive_app/view/widgets/PartnersCard.dart';
import 'package:hive_app/view/widgets/PieChartGraph.dart';
import 'package:hive_app/view/widgets/ViewsHeader.dart';

class ListTopCreator extends StatefulWidget {
  final String userId;
  const ListTopCreator({required this.userId});
  @override
  _ListTopCreatorState createState() => _ListTopCreatorState();
}

class _ListTopCreatorState extends State<ListTopCreator> {
  final String userId = "1";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BeeWrapper(
        childBuilder: (toggleBeeFollowing) => Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [appTheme.primaryColor, appTheme.secondaryHeaderColor],
              ),
            ),
            child: Container(
                child: Column(children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: ViewsHeader(
                  titleText: "Estadisticas",
                  imageCallback: toggleBeeFollowing,
                ),
              ),
              PieChartGraph(userId: widget.userId),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              PartnersCard(userId: widget.userId),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ]
            )
          )
        )
      );
  }
}
