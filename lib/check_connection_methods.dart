import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group_project/theme/colors.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

void buildDialog(BuildContext context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('No internet connection'),
      content: const Text(
          'Please, check your internet connection, and refresh the page'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text(
            'OK',
            style: TextStyle(color: CustomColors.green),
          ),
        ),
      ],
    ),
  );
}

void checkConnection(Function refreshData, BuildContext context) async {
  bool result = await InternetConnectionChecker().hasConnection;
  if (!result) {
    buildDialog(context);
  } else {
    refreshData();
  }
}
