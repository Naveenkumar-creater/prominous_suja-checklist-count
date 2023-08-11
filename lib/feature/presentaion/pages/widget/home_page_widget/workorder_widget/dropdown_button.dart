import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suja_shoie_app/asset_list.dart';
import 'package:suja_shoie_app/feature/presentaion/api_services/checklist_status_count_service.dart';
import '../../../../providers/checklist_status_count_provider.dart';
import '../../../../providers/theme_providers.dart';

class DropdownMenuExample extends StatefulWidget {
  final Widget Open;
  final Widget inProgress;
  final Widget complete;
  final Widget overdue;
  final List<int> widgetList;

  const DropdownMenuExample({
    Key? key,
    required this.Open,
    required this.inProgress,
    required this.complete,
    required this.overdue,
    required this.widgetList,
  }) : super(key: key);

  @override
  _DropdownMenuExampleState createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  int selectedValueIndex = 0;

  List<String> dropdownOptions = [
    'Open',
    'In Progress',
    'Complete',
    'Overdue',
  ];

  List<Color> valueColors = [
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.red,
  ];

  List<FontWeight> fontWeights = [
    FontWeight.normal,
    FontWeight.normal,
    FontWeight.normal,
    FontWeight.normal,
  ];

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeProvider>(context);
    return Center(
      child: Column(
        children: [
          Container(
            width: 110,
            height: 30,
            child: DropdownButton<int>(
              isExpanded: true,
              elevation: 5,
              underline: Container(),
              value: selectedValueIndex,
              icon: Icon(Icons.arrow_drop_down),
              iconEnabledColor: themeState.isDarkTheme
                  ? Colors.blue
                  : Colors.blue, // Remove the default dropdown icon
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
                color: themeState.isDarkTheme ? Colors.white : Colors.black,
              ),
              dropdownColor: themeState.isDarkTheme
                  ? const Color(0xFF424242)
                  : Colors.white,
              onChanged: (newValueIndex) {
                setState(() {
                  selectedValueIndex = newValueIndex!;
                  bool isLoading =
                      true; // Set isLoading to true while fetching data

                  ChecklistStatusService()
                      .getStatusCount(
                    context: context,
                    count: newValueIndex + 1,
                  )
                      .then((_) {
                    final checklistStatusCountProvider =
                        Provider.of<CheckListStatusCountProvider>(context,
                            listen: false);

                    setState(() {
                      widget.widgetList[newValueIndex] =
                          checklistStatusCountProvider.user?.count ?? 0;
                      bool isLoading =
                          false; // Set isLoading to false when data is fetched
                    });
                  });
                });
              },

              items: List.generate(
                dropdownOptions.length,
                (index) => DropdownMenuItem<int>(
                  value: index,
                  child: Row(
                    children: [
                      Text(
                        dropdownOptions[index],
                      ),
                      const Spacer(), // Add spacing between hint text and value text
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _showBottomSheet(context);
            },
            child: RichText(
              text: TextSpan(
                text: '${widget.widgetList[selectedValueIndex]}',
                style: TextStyle(
                    fontSize: 60,
                    color: valueColors[selectedValueIndex],
                    fontWeight: FontWeight.w100),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    String text;
    Widget content;

    switch (selectedValueIndex) {
      case 0:
        text = 'Open';
        content = AssetList();
        break;
      case 1:
        text = 'In Progress';
        content = widget.inProgress;
        break;
      case 2:
        text = 'Complete';
        content = widget.complete;
        break;
      case 3:
        text = 'Overdue';
        content = widget.overdue;
        break;
      default:
        text = '';
        content = const SizedBox();
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CustomBottomSheet(
          text: text,
          content: content,
        );
      },
    );
  }
}

class CustomBottomSheet extends StatelessWidget {
  final String text;
  final Widget content;

  const CustomBottomSheet({
    required this.text,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            content,
          ],
        ),
      ),
    );
  }
}
