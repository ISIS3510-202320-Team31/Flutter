import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/widgets/TopCreatorsCard.dart';
import 'package:hive_app/view/widgets/ViewsHeader.dart';

class TopCreators extends StatefulWidget {
  @override
  _TopCreatorsState createState() => _TopCreatorsState();
}

class _TopCreatorsState extends State<TopCreators> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          appTheme.primaryColor,
                          appTheme.secondaryHeaderColor,
                        ],
                      ),
                    ),
      child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: ListView(children: [
                    ViewsHeader(
                      titleText: "Top creadores",
                    ),
                    TopCreatorsCard()
                  ])))),
    );
  }
}
