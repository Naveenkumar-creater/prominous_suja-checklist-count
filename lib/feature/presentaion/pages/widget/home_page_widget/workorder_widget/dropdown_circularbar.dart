import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/theme_providers.dart';
import '../../../../../../constant/utils/theme_styles.dart';

class DropdownMenuCircular extends StatefulWidget {
  final Widget option;
  final Widget inProgress;
  final Widget complete;
  final Widget overdue;
  final List<Widget> widgetOptions;

  const DropdownMenuCircular({
    Key? key,
    required this.option,
    required this.inProgress,
    required this.complete,
    required this.overdue,
    required this.widgetOptions,
  }) : super(key: key);

  @override
  _DropdownMenuCircularState createState() => _DropdownMenuCircularState();
}

class _DropdownMenuCircularState extends State<DropdownMenuCircular> {
  int selectedValueIndex = 0;

  List<String> dropdownOptions = [
    'Option',
    'In Progress',
    'Complete',
    'Overdue',
  ];

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeProvider>(context);
    return Center(
      child: Column(
        children: [
          Container(
            width: 130,
            child: DropdownButton<int>(
              isExpanded: true,
              elevation: 5,
              underline: const SizedBox(),
              value: selectedValueIndex,
              iconEnabledColor:
                  themeState.isDarkTheme ? Colors.blue : Colors.blue,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: themeState.isDarkTheme ? Colors.white : Colors.black,
              ),
              dropdownColor: themeState.isDarkTheme
                  ? const Color(0xFF424242)
                  : Colors.white,
              onChanged: (newValueIndex) {
                setState(() {
                  selectedValueIndex = newValueIndex!;
                });
              },
              items: List.generate(
                dropdownOptions.length,
                (index) => DropdownMenuItem<int>(
                  value: index,
                  child: Text(
                    dropdownOptions[index],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding * 3),
          GestureDetector(
            onTap: () {
              _showBottomSheet(context);
            },
            child: widget.widgetOptions[selectedValueIndex],
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
        text = 'Option';
        content = widget.option;
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
        padding: const EdgeInsets.all(defaultPadding),
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
            const SizedBox(height: defaultPadding),
            content,
          ],
        ),
      ),
    );
  }
}
