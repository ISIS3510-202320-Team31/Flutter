import 'package:flutter/material.dart';
import 'package:hive_app/models/event.model.dart';
import 'package:hive_app/view/pages/Home.dart';
import 'package:hive_app/view/widgets/EventCard.dart';
import 'package:hive_app/view_model/event.vm.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EventList extends StatefulWidget {
  final List<Event> eventList;
  final updateFunction;
  final String userId;
  final EventVM eventVM;

  EventList({required this.eventList, required this.userId, required this.eventVM, required this.updateFunction});

  _EventList createState() => _EventList(eventList: eventList, eventVM: eventVM, updateFunction: updateFunction);
}

class _EventList extends State<EventList> {
  final RefreshController refreshController = RefreshController(initialRefresh: false);
  var eventList;
  final updateFunction;

  final EventVM eventVM;
  _EventList({required this.eventList, required this.eventVM, required this.updateFunction});

  Future<bool> _handleRefresh() async {
    setState(() {
      updateFunction();
    });
    return true;

  }

  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      onRefresh: () {_handleRefresh();},
      enablePullUp: true,
      onLoading: () {_handleRefresh();},
        child:ListView.builder(
          padding: EdgeInsets.only(
            top: 0,
            left: MediaQuery.of(context).size.width * 0.02,
            right: MediaQuery.of(context).size.width * 0.02,
          ),
          itemCount: eventList.length,
          itemBuilder: (context, index) {
            final event = eventList[index];
            return EventCard(
              userId: widget.userId,
              event: event,
            );
          },
        )
      );
  }
}
