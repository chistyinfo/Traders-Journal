import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_database_example/model/note.dart';
import 'package:sqflite_database_example/widget/variables.dart';

//Box Colors Assigned


final _lightColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100
];

class NoteCardWidget extends StatelessWidget {

  
  NoteCardWidget({
    Key? key,
    required this.note,
    required this.index,
  }) : super(key: key);

  final Note note;
  final int index;

  


  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final color = _lightColors[index % _lightColors.length];
    final time = DateFormat.yMMM().format(note.createdTime);
    final minHeight = getMinHeight(index);

     var res = updateWinR();
      print(res);
    
    
 




    

    return Container(
        child: Column(children: [
      Center(
        child: Row(
          children: [
            Text(
              'Win Rate % : ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$res',
              style:TextStyle(
               fontSize:22,fontWeight: FontWeight.bold,color: firozcolor(res),
              ),
            ),
          ],
        ),
      ),
      Card(
        color: color,
        child: Container(
          constraints: BoxConstraints(minHeight: minHeight),
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: TextStyle(color: Colors.grey.shade700),
              ),
              SizedBox(height: 4),
              Center(
                child: Text(
                  note.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Text(
                        note.won,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Won')
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text(
                        note.lost,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Lost')
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      )
    ]));
  }

  int updateWinR() {
    var iwon = int.parse(note.won);
    var ilost = int.parse(note.lost);
    var winR = iwon / (iwon + ilost) * 100;
    final res = winR.round();
    return res;
  }

  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 120;
      case 2:
        return 110;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}
