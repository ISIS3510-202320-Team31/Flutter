import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartGraph extends StatefulWidget {
  final data;

  const PieChartGraph({required this.data});

  @override
  _PieChartGraphState createState() => _PieChartGraphState();
}

class _PieChartGraphState extends State<PieChartGraph> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        margin: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10, top: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        elevation: 8,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Center(child: Text("Eventos por categoría",
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0), // Ajusta el color del texto según sea necesario
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),)),
            SizedBox(height: MediaQuery.of(context).size.height * 0.10),
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
                          widget.data.length,
                          (index) => PieChartSectionData(
                            color: widget.data[index]["color"],
                            value: widget.data[index]["value"],
                            title: widget.data[index]["value"].toString()+"%",
                            radius: 120,
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Expanded(
                    flex: 2,
                    child: LegendList(data: widget.data),
                  ),
          ],
        ),
      ),
    );
  }

}
class LegendList extends StatelessWidget {
  final List<dynamic> data;

  LegendList({required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: data[index]["color"],
                ),
                SizedBox(width: 16),
                Text(data[index]["category"]),
              ],
            ),
          ),
        );
      },
    );
  }
}
