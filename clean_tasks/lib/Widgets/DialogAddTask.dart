import 'package:clean_tasks/Controllers/FirebaseController.dart';
import 'package:clean_tasks/Model/TarefaModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DialogAddTask extends StatefulWidget {

  final FirebaseUser user;

  const DialogAddTask({Key key, this.user}) : super(key: key);
  @override
  _DialogAddTaskState createState() => _DialogAddTaskState();
}

class _DialogAddTaskState extends State<DialogAddTask> {
  CalendarController calendarController = CalendarController();
  TextEditingController _textController = TextEditingController();
  var visibleCalendar = true;
  var formatterDataString = new DateFormat('dd/MM/yyyy');
  var dataFormatada;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataFormatada = formatterDataString.format(DateTime.now());
    print(dataFormatada);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(width * 0.030)),
      title: Text(
        "Adicionar",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      backgroundColor: Colors.white,
      actions: <Widget>[
        Container(
          width: width,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.green,
            border: Border.all(color: Colors.white,width:1),
            borderRadius: BorderRadius.circular(15)
          ),
          child: Center(
            child: Text("Salvar",style: TextStyle(color: Colors.white),),
          ),
        )
      ],
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    maxLines: 15,
                    minLines: 1,
                    autofocus: false,
                    controller: _textController,
                    onSubmitted: (_){
                      TarefaModel tm = TarefaModel(_textController.text, dataFormatada, false);
                      FirebaseController fc = FirebaseController();
                      fc.saveFirebase(tm, widget.user, dataFormatada);
                      Navigator.pop(context);
                    },
                  ),
                ),
                
                
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              visible: visibleCalendar,
              child: Container(
                width: width,
                height: 300,
                child: TableCalendar(
                  calendarController: calendarController,
                  locale: "pt_BR",
                  headerStyle: HeaderStyle(
                    formatButtonShowsNext: false,
                    formatButtonVisible: false,
                    centerHeaderTitle: true,
                  ),
                  calendarStyle: CalendarStyle(outsideDaysVisible: false),
                  daysOfWeekStyle: DaysOfWeekStyle(
                      //weekdayStyle: TextStyle(color: Colors.transparent),
                      //weekendStyle: TextStyle(color: Colors.transparent),
                      ),
                  //rowHeight: 0,
                  initialCalendarFormat: CalendarFormat.month,
                  //initialSelectedDay: DateTime.now(),

                  onDaySelected: (date, List days) {
                    dataFormatada = formatterDataString.format(date);
                    print(dataFormatada);
                    setState(() {
                      //visibleCalendar = false;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
