import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:suja_shoie_app/feature/data/core/checklist_status_api_client.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/checklist_status_data_source.dart';
import 'package:suja_shoie_app/feature/data/data_source/checklist_status_data_source_impl.dart';
import 'package:suja_shoie_app/feature/data/repository/checklist_status_repository_impl.dart';
import 'package:suja_shoie_app/feature/domain/entity/checklist_status_count_entity.dart';
import 'package:suja_shoie_app/feature/domain/repository/checklist_status_count_repository.dart';
import 'package:suja_shoie_app/feature/domain/usecase/checklist_status_count_usecase.dart';
import 'package:suja_shoie_app/feature/presentaion/providers/checklist_status_count_provider.dart';

class ChecklistStatusService {
  Future<void> getStatusCount({
    required BuildContext context,
    required int count,
  }) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString("client_token") ?? "";

      DateTime now = DateTime.now();
      String toDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

      // String token = "admin-580";

      CheckListStatusClient checkListClient = CheckListStatusClient();
      CheckListDataSource CheckListData =
          CheckListDataSourceimpl(checkListClient);
      CheckListStausRepository checklistRepository =
          ChecklistRepositoryImpl(CheckListData);
      CheckListStatusCountUseCase checkListUseCase =
          CheckListStatusCountUseCase(checklistRepository);

      ChecklistStatusEntity user =
          await checkListUseCase.execute(count, toDate, token);

      var checkliststatus =
          Provider.of<CheckListStatusCountProvider>(context, listen: false);

      checkliststatus.setUser(user);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

void showSnackBar(BuildContext? context, String message) {
  if (context != null) {
    final snackBar = SnackBar(
      backgroundColor: Colors.amber[400],
      content:
          Center(child: Text(message, style: TextStyle(color: Colors.black))),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
