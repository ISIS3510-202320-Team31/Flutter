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
          Search(userId: widget.userId),
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
                                      eventList: snapshot.data!,
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
                                      eventList: snapshot.data!,
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
                                      eventList: snapshot.data!,
                                      eventVM: eventVM,
                                      updateFunction: this.updateFunction))
                            ]));
                          } else
                            return Container();
                        });
                  case Status.COMPLETED:
                    print("Log :: COMPLETED");
                    eventVM.saveLocalEventsFeed();
                    return Expanded(
                        child: EventList(
                            userId: widget.userId,
                            eventList: viewModel.eventModel.data!.events,
                            eventVM: eventVM,
                            updateFunction: this.updateFunction));
                  default:
                    return Container();
                }
              },
            ),
          ) // Aquí incluye el EventList
        ],
      ),
    );
  }
}
