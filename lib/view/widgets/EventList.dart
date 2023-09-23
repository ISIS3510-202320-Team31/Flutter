import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_app/models/event.model.dart';
import 'package:hive_app/view_model/event.vm.dart';
import 'package:hive_app/data/remote/response/Status.dart';
import 'package:hive_app/view/widgets/EventCard.dart';

class EventList extends StatefulWidget {
  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventList> {
  final EventVM eventVM = EventVM();

  @override
  void initState() {
    eventVM.fetchEventData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventVM>(
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
              return _buildEventListView(viewModel.eventModel.data?.events);
            default:
              return Container();
          }
        },
      ),
    );
  }

  Widget _buildEventListView(List<Event>? events) {
  return Container(
    height: MediaQuery.of(context).size.height*0.7615, // Asigna un tamaño fijo o usa restricciones adecuadas
    child: ListView(
      shrinkWrap: true,
      children: [
        for (final event in events ?? [])
          EventCard(
            event: event,
          ),
      ],
    ),
  );
}

}
