import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_app/models/event.model.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/widgets/EventList.dart';
import 'package:hive_app/view_model/event.vm.dart';
import 'package:hive_app/view/widgets/SearchBar.dart';
import 'package:hive_app/data/remote/response/Status.dart';
import 'package:provider/provider.dart';
import 'package:hive_app/utils/SecureStorage.dart';


class Feed extends StatefulWidget {
  static const String id = "feed_screen";

  final String userId;
  const Feed({required this.userId});

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final EventVM eventVM = EventVM();
  final SecureStorage secureStorage = SecureStorage();
  var cachedEvents;
  late final void Function() updateFunction;

  @override
  void initState() {
    void Function() updateFunction(String userId) {
      return () {
        eventVM.fetchEventsForUser(userId);
      };
    }
    this.updateFunction = updateFunction(widget.userId);
    this.updateFunction();
    this.getLocalEvents();
    super.initState();
  }

  void getLocalEvents() {
    secureStorage.readSecureData("feedEvents").then((eventsJSON){
      if (eventsJSON != null && eventsJSON.isNotEmpty) {
        var eventsRaw = json.decode(eventsJSON);
        var events = json.encode(eventsRaw['events']);
        this.cachedEvents = eventModelFromJson(events).events;
      }
      else {
        this.cachedEvents = [];
      }
    });
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
                    this.getLocalEvents();
                    return Expanded(child:
                    Column(
                      children: [
                        Center(
                        child: LinearProgressIndicator(),
                        ),  
                        Expanded(
                        child: EventList(
                            userId: widget.userId,
                            eventList: this.cachedEvents,
                            eventVM: eventVM,
                            updateFunction: this.updateFunction))
                      ]
                    ));
                  case Status.ERROR:
                    print("Log :: ERROR");
                    return Container(
                      child: Center(
                        child: Text("Error"),
                      ),
                    );
                  case Status.COMPLETED:
                    print("Log :: COMPLETED");
                    secureStorage.writeSecureData('feedEvents', eventModelToJson(viewModel.eventModel.data!));
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
