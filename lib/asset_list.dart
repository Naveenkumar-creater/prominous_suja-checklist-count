import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'feature/presentaion/providers/machine_list_provider.dart';

class AssetList extends StatelessWidget {
  const AssetList({Key? key});

  @override
  Widget build(BuildContext context) {
    final machineListProvider = Provider.of<MachineList>(context);

    if (machineListProvider.data == null) {
      machineListProvider.getData(context);
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // Check if assetListForChecklist is null or empty
    if (machineListProvider.data!.assetListForChecklist == null ||
        machineListProvider.data!.assetListForChecklist!.isEmpty) {
      return const Center(
        child: Text("No asset data available."),
      );
    }

    final List<DataRow> dataRows = _buildDataRows(
      machineListProvider.data!.assetListForChecklist!,
      context,
    );

    return Container(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Your Title",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  DataTable(
                    showCheckboxColumn:
                        false, // Set to false to remove checkboxes
                    columnSpacing: MediaQuery.of(context).size.width * 0.15,
                    headingTextStyle: TextStyle(color: Colors.white),
                    dataTextStyle: TextStyle(color: Colors.black),
                    // Adjust the spacing between columns as needed
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => Color(0xFF1a1f3c)),
                    dataRowColor: MaterialStateColor.resolveWith(
                        (states) => Colors.grey.shade100),
                    columns: const [
                      DataColumn(
                        label: Text(
                          "S.No",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        tooltip: "represent No of machine",
                      ),
                      DataColumn(
                        label: Text(
                          "Asset Type",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        tooltip: "represent Asset type",
                        // Adjust the flex value to control column width
                      ),
                      DataColumn(
                        label: Text(
                          "Asset Name",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        tooltip: "represent Asset",
                        // Adjust the flex value to control column width
                      ),
                      DataColumn(
                        label: Text(
                          "Location",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        tooltip: "represent Machine Location",
                        // Adjust the flex value to control column width
                      ),
                    ],
                    rows: dataRows,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DataRow> _buildDataRows(List assetList, BuildContext context) {
    return assetList
        .asMap() // Convert the list to a map with index and item
        .map((index, data) => MapEntry(
              index,
              DataRow(
                // Set a custom color based on the index of the row
                color: MaterialStateColor.resolveWith((states) =>
                    index % 2 == 0 ? Colors.white : Colors.grey.shade200),
                cells: [
                  DataCell(
                    Text((index + 1)
                        .toString()), // Index value in the first DataCell
                  ),
                  DataCell(Text(data.assetTypeName ?? '')),
                  DataCell(Text(data.assetName ?? '')),
                  DataCell(Text(data.locName ?? '')),
                ],
                // Wrap the DataRow in an InkWell and handle the onTap callback
                onSelectChanged: (_) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MachineDetailsPage(data.assetId),
                    ),
                  );
                },
              ),
            ))
        .values // Get only the values (DataRows) from the map
        .toList();
  }
}

class MachineDetailsPage extends StatelessWidget {
  final int assetId;

  MachineDetailsPage(this.assetId);

  @override
  Widget build(BuildContext context) {
    // You can use the asset_id to fetch machine details and display them here
    return Scaffold(
      appBar: AppBar(
        title: Text("Machine Details"),
      ),
      body: Center(
        child: Text("Machine ID: $assetId"),
      ),
    );
  }
}
