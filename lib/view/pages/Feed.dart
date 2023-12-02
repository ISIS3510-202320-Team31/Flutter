import 'package:flutter/material.dart';
import 'package:hive_app/models/event.model.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/widgets/EventList.dart';
import 'package:hive_app/view_model/event.vm.dart';
import 'package:hive_app/view/widgets/SearchBar.dart';
import 'package:hive_app/data/remote/response/Status.dart';
import 'package:provider/provider.dart';

class Feed extends StatefulWidget {
  static const String id = "feed_screen";

  final String userId;
  const Feed({required this.userId});

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final EventVM eventVM = EventVM();

  Future<List<Event>>? storedEventsFuture;
  String _filter = "Sin filtro";
  late final void Function() updateFunction;

  @override
  void initState() {
    super.initState();
    storedEventsFuture = eventVM.getLocalEventsFeed();
    eventVM.fetchEventsForUser(widget.userId);

    updateFunction = () {
      eventVM.fetchEventsForUser(widget.userId);
    };
    updateFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [appTheme.primaryColor, appTheme.secondaryHeaderColor],
        ),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Search(userId: widget.userId, callbackFilter: this.callbackFilter),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          ChangeNotifierProvider<EventVM>(
            create: (BuildContext context) => eventVM,
            child: Consumer<EventVM>(
              builder: (context, viewModel, _) {
                switch (viewModel.eventModel.status) {
                  case Status.LOADING:
                    print("Log :: LOADING");
                    storedEventsFuture = eventVM.getLocalEventsFeed();
                    return FutureBuilder<List<Event>>(
                        future: storedEventsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return Container();
                          else if (snapshot.hasError) {
                            return Container();
                          } else if (snapshot.hasData) {
                            return Expanded(
                                child: Column(children: [
                              Center(
                                child: LinearProgressIndicator(),
                              ),
                              Expanded(
                                  child: EventList(
                                      userId: widget.userId,
                                      eventList: filterEvents(snapshot.data!),
                                      eventVM: eventVM,
                                      updateFunction: this.updateFunction))
                            ]));
                          } else
                            return Container();
                        });
                  case Status.OFFLINE:
                    print("Log :: OFFLINE");
                    storedEventsFuture = eventVM.getLocalEventsFeed();
                    return FutureBuilder<List<Event>>(
                        future: storedEventsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return Container();
                          else if (snapshot.hasError) {
                            return Container();
                          } else if (snapshot.hasData) {
                            return Expanded(
                                child: Column(children: [
                              Center(
                                child: Text(
                                  "SIN INTERNET",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  "Revisa tu conexión y refresca la página",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              Expanded(
                                  child: EventList(
                                      userId: widget.userId,
                                      eventList: filterEvents(snapshot.data!),
                                      eventVM: eventVM,
                                      updateFunction: this.updateFunction))
                            ]));
                          } else
                            return Container();
                        });
                  case Status.ERROR:
                    print("Log :: ERROR");
                    storedEventsFuture = eventVM.getLocalEventsFeed();
                    return FutureBuilder<List<Event>>(
                        future: storedEventsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return Container();
                          else if (snapshot.hasError) {
                            return Container();
                          } else if (snapshot.hasData) {
                            return Expanded(
                                child: Column(children: [
                              Center(
                                child: Text(
                                    "Estamos presentando errores... Intenta refrescar"),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              Expanded(
                                  child: EventList(
                                      userId: widget.userId,
                                      eventList: filterEvents(snapshot.data!),
                                      eventVM: eventVM,
                                      updateFunction: this.updateFunction))
                            ]));
                          } else
                            return Container();
                        });
                  case Status.COMPLETED:
                    print("Log :: COMPLETED");
                    eventVM.saveLocalEventsFeed();
                    storedEventsFuture = eventVM.getLocalEventsFeed();
                    return FutureBuilder<List<Event>>(
                        future: storedEventsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return Container();
                          else if (snapshot.hasError) {
                            return Container();
                          } else if (snapshot.hasData) {
                            return Expanded(
                                child: Column(children: [
                              Expanded(
                                  child: EventList(
                                      userId: widget.userId,
                                      eventList: filterEvents(snapshot.data!),
                                      eventVM: eventVM,
                                      updateFunction: this.updateFunction))
                            ]));
                          } else
                            return Container();
                        });
                  default:
                    return Container();
                }
              },
            ),
          )
        ],
      ),
    );
  }

  void callbackFilter(String value) {
    setState(() {
      _filter = value;
    });
  }

  List<Event> filterEvents(List<Event> eventList) {
    List<Event> filteredList = List.from(eventList);
    if (_filter == "Académico") {
      filteredList.removeWhere((element) => element.category != "ACADEMIC");
    } else if (_filter == "Cultural") {
      filteredList.removeWhere((element) => element.category != "CULTURAL");
    } else if (_filter == "Deportivo") {
      filteredList.removeWhere((element) => element.category != "SPORTS");
    } else if (_filter == "Entretenimiento") {
      filteredList
          .removeWhere((element) => element.category != "ENTERTAINMENT");
    } else if (_filter == "Otros") {
      filteredList.removeWhere((element) => element.category != "OTHER");
    }
    return filteredList;
  }
}
