import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:provider/provider.dart';
import 'package:hive_app/data/remote/response/Status.dart';
import 'package:hive_app/view_model/user.vm.dart';
import 'package:hive_app/view/widgets/OfflineWidget.dart';

class TopCreatorsCard extends StatefulWidget {
  @override
  _TopCreatorsCardState createState() => _TopCreatorsCardState();
}

class _TopCreatorsCardState extends State<TopCreatorsCard> {
  UserVM userVM = UserVM();
  Future<List<dynamic>>? localTopCreators;
  @override
  void initState() {
    userVM.fetchTopCreators();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10, top: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        elevation: 8,
        child: ChangeNotifierProvider<UserVM>(
          create: (BuildContext context) => userVM,
          child: Consumer<UserVM>(
            builder: (context, viewModel, _) {
              switch (viewModel.topCreators.status) {
                case Status.LOADING:
                  localTopCreators = userVM.getLocalTopCreators();
                  print("Log :: LOADING");
                  if (localTopCreators == []) {
                    return OfflineWidget();
                  }
                  return FutureBuilder<List<dynamic>>(
                      future: localTopCreators,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return Container();
                        else if (snapshot.hasError) {
                          return Container();
                        } else if (snapshot.hasData) {
                          return Container(
                            child: showTopCreatorsCard(context, snapshot.data!),
                          );
                        } else
                          return Container();
                      });
                case Status.ERROR:
                  localTopCreators = userVM.getLocalTopCreators();
                  print("Log :: ERROR");
                  if (localTopCreators == []) {
                    return OfflineWidget();
                  }
                  return FutureBuilder<List<dynamic>>(
                      future: localTopCreators,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return Container();
                        else if (snapshot.hasError) {
                          return Container();
                        } else if (snapshot.hasData) {
                          return Container(
                            child: showTopCreatorsCard(context, snapshot.data!),
                          );
                        } else
                          return Container();
                      });
                case Status.OFFLINE:
                  localTopCreators = userVM.getLocalTopCreators();
                  print("Log :: OFFLINE");
                  if (localTopCreators == []) {
                    return OfflineWidget();
                  }
                  return FutureBuilder<List<dynamic>>(
                      future: localTopCreators,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return Container();
                        else if (snapshot.hasError) {
                          return Container();
                        } else if (snapshot.hasData) {
                          return Container(
                            child: showTopCreatorsCard(context, snapshot.data!),
                          );
                        } else
                          return Container();
                      });
                case Status.COMPLETED:
                  userVM.saveLocalTopCreators();
                  print("Log :: COMPLETED");
                  final topCreators = viewModel.topCreators.data!;
                  return Container(
                    child: showTopCreatorsCard(context, topCreators),
                  );
                default:
                  return Container();
              }
            },
          ),
        ));
  }

  // Función para mostrar el cuadro de diálogo de detalles del evento
  showTopCreatorsCard(BuildContext context, List<dynamic> topCreator) {
    print(topCreator);
    return Container(
        child: Column(
      children: [
        Icon(
          Icons.person,
          size: MediaQuery.of(context).size.width * 0.5,
          color: Colors.black,
        ),
        TextButton(
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              backgroundColor: appTheme.unselectedWidgetColor),
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.only(
                left: 30.0, right: 30.0, top: 5.0, bottom: 5.0),
            child: Text(
              "Top Creadores",
              style: TextStyle(color: Colors.black, fontSize: 30.0),
            ),
          ),
        ),
        SizedBox(height: 40.0),
        showCreator(context, topCreator[0], "1"),
        SizedBox(height: 20.0),
        showCreator(context, topCreator[1], "2"),
        SizedBox(height: 20.0),
        showCreator(context, topCreator[2], "3"),
        SizedBox(height: 20.0),
        showCreator(context, topCreator[3], "4"),
        SizedBox(height: 20.0),
        showCreator(context, topCreator[4], "5"),
        SizedBox(height: 40.0),
        Icon(
          Icons.verified_outlined,
          size: MediaQuery.of(context).size.width * 0.3,
          color: Colors.amber,
        ),
        SizedBox(height: 30.0),
      ],
    ));
  }
}

showCreator(BuildContext context, dynamic creator, String num) {
  print(creator);
  return Container(
      child: Text(
    num + ". " + creator["name"],
    style: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
  ));
}
