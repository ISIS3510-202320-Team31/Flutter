import 'package:flutter/material.dart';

class PartnersCard extends StatefulWidget {
  final partners;

  const PartnersCard({required this.partners});

  @override
  _PartnersCardState createState() => _PartnersCardState();
}

class _PartnersCardState extends State<PartnersCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Personas que más asisten a mis eventos",
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.partners.length,
              itemBuilder: (context, index) {
                final person = widget.partners[index];
                return Container(
                  child: Center(
                    child: Text(person,style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 16.0,
              ),),
                  ),
                );
              },
            ),
            SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
