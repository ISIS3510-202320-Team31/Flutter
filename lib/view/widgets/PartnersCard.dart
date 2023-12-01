import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/remote/response/Status.dart';
import '../../view_model/event.vm.dart';
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
      child: ChangeNotifierProvider<UserVM>(
        create: (BuildContext context) => userVM,
        child: Consumer<UserVM>(
          builder: (context, viewModel, _) {
            switch (viewModel.partners.status) {
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
                  child:
                      Text("Estamos presentando errores... Intenta refrescar"),
                );
              case Status.COMPLETED:
                print("Log :: COMPLETED");
                // eventVM.saveLocalEventsFeed();
                return Padding(
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
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: viewModel.partners.data!.length,
                        itemBuilder: (context, index) {
                          final person = viewModel.partners.data?[index];
                          return Container(
                            child: Center(
                              child: Text(
                                person,
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 30.0),
                    ],
                  ),
                );
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
