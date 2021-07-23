import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  final bool? isImportant;
  final int? number;
  final String? won;
  final String? lost;
  final String? title;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedWon;
  final ValueChanged<String> onChangedLost;
  final ValueChanged<String> onChangedTitle;
  

  const NoteFormWidget({
    Key? key,
    this.isImportant = false,
    this.number = 0,
    this.won = '',
    this.lost = '',
    this.title = '',
    required this.onChangedImportant,
    required this.onChangedNumber,
    required this.onChangedWon,
    required this.onChangedLost,
    required this.onChangedTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Switch(
                    value: isImportant ?? false,
                    onChanged: onChangedImportant,
                  ),
                  Expanded(
                    child: Slider(
                      value: (number ?? 0).toDouble(),
                      min: 0,
                      max: 5,
                      divisions: 5,
                      onChanged: (number) => onChangedNumber(number.toInt()),
                    ),
                  )
                ],
              ),
              buildTitle(),
              SizedBox(height: 8),
              buildWon(),
              SizedBox(height: 8),
              buildLost(),
              SizedBox(height: 8),
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Pattern Name',
          hintStyle: TextStyle(color: Colors.white70),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The pattern name cannot be empty' : null,
        onChanged: onChangedTitle,
      );

  Widget buildWon() => TextFormField(
        maxLines: 1,
        initialValue: won,
        style: TextStyle(color: Colors.white60, fontSize: 18),
        decoration: InputDecoration(
          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
          hintText: 'Type win numbers...',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (won) => won != null && won.isEmpty
            ? 'The lost field cannot be empty'
            : null,
        onChanged: onChangedWon,
      );    

  Widget buildLost() => TextFormField(
        maxLines: 1,
        initialValue: lost,
        style: TextStyle(color: Colors.white60, fontSize: 18),
        decoration: InputDecoration(
          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
          hintText: 'Type lost numbers.........',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (lost) => lost != null && lost.isEmpty
            ? 'The win field cannot be empty'
            : null,
        onChanged: onChangedLost,
      );    

  
  
  
}
