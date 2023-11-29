import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/widgets/QRscanner.dart';
import 'package:intl/intl.dart';

class Search extends StatelessWidget {
  final String userId;
  const Search({required this.userId});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        // Icono de filtro a la izquierda
        IconButton(
          icon: Icon(
            Icons.center_focus_weak,
            color: appTheme.focusColor,
            size: 30.0,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => QRscanner(userId: userId)),
            );
          },
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.25),
        Text(Intl.message('helloWorld'),
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
        // Expanded(
        //   child: Container(
        //     padding: EdgeInsets.only(left: 10, right: 10),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(30),
        //       color: Colors.white,
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.black.withOpacity(0.1),
        //           offset: Offset(0, 3),
        //           blurRadius: 5,
        //         ),
        //       ],
        //     ),
        //     child: TextField(
        //       style: TextStyle(
        //         fontSize: 16.0,
        //         color: Colors.black,
        //       ),
        //       cursorColor: appTheme.primaryColor,
        //       decoration: InputDecoration(
        //         border: InputBorder.none,
        //         hintText: "Buscar...",
        //         hintStyle: TextStyle(
        //           color: Colors.grey,
        //         ),
        //         prefixIcon: Icon(
        //               Icons.search,
        //               color: Color.fromARGB(255, 33, 150, 243),
        //               size: 25
        //             ),
        //       ),
        //     ),
        //   ),
        // ),
        // SizedBox(width: MediaQuery.of(context).size.width*0.02),
        // IconButton(
        //   icon: Icon(
        //     Icons.filter_list,
        //     color: appTheme.hintColor,
        //     size: 30.0,
        //   ),
        //   onPressed: () {
        //     // Acción que deseas ejecutar cuando se presiona el botón izquierdo
        //   },
        //   color: appTheme.hintColor
        // ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
      ],
    );
  }
}
