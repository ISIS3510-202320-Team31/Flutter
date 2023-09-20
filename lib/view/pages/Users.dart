import 'package:flutter/material.dart';
import 'package:hive_app/utils/ColorPalette.dart';

import 'package:hive_app/view/pages/UserCard.dart'; 
import 'package:hive_app/view_model/user.vm.dart';
import 'package:hive_app/models/user.model.dart';
import 'package:provider/provider.dart';
import 'package:hive_app/data/remote/response/Status.dart';
import 'package:hive_app/utils/ColorPalette.dart';

class Users extends StatefulWidget {
  static const String id = "home_screen";

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<Users> {
  final UserVM viewModel = UserVM();

  @override
  void initState() {
    viewModel.fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HIVE"),
        backgroundColor: appTheme.primaryColor,
      ),
      body: ChangeNotifierProvider<UserVM>(
        create: (BuildContext context) => viewModel,
        child: Consumer<UserVM>(builder: (context, viewModel, _) {
          switch (viewModel.userModel.status) {
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
              return Container(
                child: Center(
                  child: Text("Loaded"),
                ),
              );
              // return _getUsersListView(viewModel.userModel.data?.users);
            default:
          }
          return Container();
        }),
      ),
    );
  }

  // Widget _getUsersListView(List<User>? users) {
  //   return ListView.builder(
  //       itemCount: users?.length,
  //       itemBuilder: (context, position) {
  //         return _getUserListItem(users![position]);
  //       });
  // }

  // Widget _getUserListItem(User item) {
  //   return Card(
  //     shape: RoundedRectangleBorder(
  //         side: BorderSide(color: Colors.grey, width: 1.0),
  //         borderRadius: BorderRadius.all(Radius.circular(10))),
  //     child: ListTile(

  //       title: MyTextView(label: item.name ?? "NA"),
  //       subtitle: Column(children: [
  //         Align(
  //           alignment: Alignment.centerLeft,
  //           child: MyTextView(label: item.note ?? "NA"),
  //         ),
  //         Align(
  //           alignment: Alignment.centerLeft,
  //           child: MyTextView(label: item.phone ?? "NA"),
  //         ),
  //       ]),
  //       onTap: () {
  //         _goToDetailScreen(context, item);
  //       },
  //     ),
  //     elevation: context.resources.dimension.lightElevation,
  //   );
  // }

  // void _goToDetailScreen(BuildContext context, User item) {
  //   Navigator.pushNamed(context, UserDetailsScreen.id, arguments: item);
  // }
}