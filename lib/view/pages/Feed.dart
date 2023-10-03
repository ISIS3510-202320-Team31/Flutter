import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';
import 'package:hive_app/view/widgets/EventList.dart';
import 'package:hive_app/view_model/event.vm.dart';
import 'package:hive_app/view/widgets/SearchBar.dart';
import 'package:hive_app/data/remote/response/Status.dart';
import 'package:provider/provider.dart';

class Feed extends StatefulWidget {
  static const String id = "feed_screen";

  final String? userId;
  const Feed({this.userId});

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final EventVM eventVM = EventVM();

  @override
  void initState() {
    eventVM.fetchEventsForUser(widget.userId!);
    super.initState();
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
          Search(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          ChangeNotifierProvider<EventVM>(
            create: (BuildContext context) => eventVM,
            child: Consumer<EventVM>(
              builder: (context, viewModel, _) {
                switch (viewModel.eventModel.status) {
                  case Status.LOADING:
                    print("Log :: LOADING");
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                      height: MediaQuery.of(context).size.height * 0.7,
                    );
                  case Status.ERROR:
                    print("Log :: ERROR");
                    return Container(
                      child: Center(
                        child: Text("Error"),
                      ),
                    );
                  case Status.COMPLETED:
                    print("Log :: COMPLETED");
                    return Expanded(
                        child: EventList(
                            eventList: viewModel.eventModel.data!.events));
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
