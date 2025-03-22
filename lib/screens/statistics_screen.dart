import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:xxx/model/user_model.dart';
import 'package:xxx/services/db_services.dart';
import 'package:xxx/widgets/custom_appbar.dart';
import 'package:xxx/widgets/response_list_widget.dart';
import 'package:xxx/widgets/statistics_widget.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  late Future<UserModel> _userData;

  @override
  void initState() {
    super.initState();
    _userData = DBServices().getInfo();
  }

  @override
  Widget build(BuildContext context) {
    List<double> listEmotions = [];
    List<String> responses = [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(title: "statistics".tr()),
      body: FutureBuilder(
        future: _userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(
              child: Text("Data fetch error"),
            );
          }

          UserModel user = snapshot.data!;

          listEmotions = user.emotions;
          responses = user.responses;

          return Column(
            children: [
              StatisticsWidget(
                  listEmotions: listEmotions, responses: responses),
              ResponseListWidget(
                  listEmotions: listEmotions.reversed.toList(),
                  responses: responses.reversed.toList())
            ],
          );
        },
      ),
    );
  }
}
