import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../models/Asset_List_for_Checklist_model.dart';

class MachineList extends ChangeNotifier {
  AssetLists? data;

  Future getData(context) async {
    var response = await DefaultAssetBundle.of(context)
        .loadString('assets/raw/machinelist.json');
    print(response);

    var machinejson = jsonDecode(response);
    print(machinejson);

    data = AssetLists.fromJson(machinejson);

    // Verify if the data is fetched correctly
    print("AssetList Length: ${data?.assetListForChecklist?.length}");

    notifyListeners();
  }
}
