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
  final UserVM userVM = UserVM();

  @override
  void initState() {
    userVM.fetchUserData();
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
        create: (BuildContext context) => userVM,
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
              return _getUsersListView(viewModel.userModel.data?.users);
              // return _getUsersListView(viewModel.userModel.data?.users);
            default:
              return Container();
          }
        }),
      ),
    );
  }

  Widget _getUsersListView(List<User>? users) {
    return ListView.builder(
        itemCount: users?.length,
        itemBuilder: (context, position) {
          return UserCard(
            name: users?[position].career ?? "",
          );
        });
  }

}