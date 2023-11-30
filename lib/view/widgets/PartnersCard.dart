import 'package:flutter/material.dart';

import '../../view_model/user.vm.dart';

class PartnersCard extends StatefulWidget {
  final userId;

  const PartnersCard({required this.userId});

  @override
  _PartnersCardState createState() => _PartnersCardState();
}

class _PartnersCardState extends State<PartnersCard> {
  final UserVM userVM = UserVM();

  @override
  void initState() {
    super.initState();
    userVM.getPartners(widget.userId);
  }
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
              "Personas que más asisten conmigo a eventos",
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            // ListView.builder(
            //   shrinkWrap: true,
            //   itemCount: widget.partners.length,
            //   itemBuilder: (context, index) {
            //     final person = widget.partners[index];
            //     return Container(
            //       child: Center(
            //         child: Text(person,style: TextStyle(
            //     color: const Color.fromARGB(255, 0, 0, 0),
            //     fontSize: 16.0,
            //   ),),
            //       ),
            //     );
            //   },
            // ),
            SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
