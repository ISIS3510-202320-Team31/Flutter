import 'package:flutter/material.dart';
import 'package:hive_app/models/user.model.dart';
import 'package:hive_app/view_model/event.vm.dart';
import 'package:hive_app/view_model/user.vm.dart';
import 'package:provider/provider.dart';

import '../../data/remote/response/Status.dart';

class TopCreators extends StatefulWidget {
  final String userId;
  @override
  const TopCreators({required this.userId});
  _TopCreatorsState createState() => _TopCreatorsState();
}

class _TopCreatorsState extends State<TopCreators> {
  final EventVM eventVM = EventVM();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventVM>(
      create: (BuildContext context) => eventVM,
      child: Consumer<EventVM>(
        builder: (context, viewModel, _) {
          switch (viewModel.stats.status) {
            case Status.LOADING:
              print("Log :: LOADING");
              return Center(
                child: CircularProgressIndicator(),
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
                child: Text("Estamos presentando errores... Intenta refrescar"),
              );
            case Status.COMPLETED:
              print("Log :: COMPLETED");
              // eventVM.saveLocalEventsFeed();
              return Expanded(
                child: Card(
                  margin: EdgeInsets.only(
                      left: 8.0, right: 8.0, bottom: 10, top: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  elevation: 8,
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Center(
                          child: Text(
                        "Top Creadores",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0,
                              0), // Ajusta el color del texto según sea necesario
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      )),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Card(
                                //ACA COLOCAR 
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
                  ),
                ),
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}

class LegendList extends StatelessWidget {
  final List<dynamic>? data;

  LegendList({required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data?.length,
      itemBuilder: (context, index) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
              ],
            ),
          ),
        );
      },
    );
  }
}
