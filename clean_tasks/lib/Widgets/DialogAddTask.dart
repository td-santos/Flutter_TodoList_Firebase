import 'package:clean_tasks/Controllers/FirebaseController.dart';
import 'package:clean_tasks/Model/TarefaModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DialogAddTask extends StatefulWidget {
  final FirebaseUser user;
  final String datatarefa;
  final String titleTarefa;
  final String selectedDOC;

  const DialogAddTask({
    Key key,
    this.user,
    this.datatarefa,
    this.titleTarefa, this.selectedDOC,
  }) : super(key: key);

  @override
  _DialogAddTaskState createState() => _DialogAddTaskState();
}

class _DialogAddTaskState extends State<DialogAddTask>
    with TickerProviderStateMixin {
  CalendarController calendarController = CalendarController();
  TextEditingController _textController = TextEditingController();
  var visibleCalendar = false;
  var formatterDataString = new DateFormat('dd/MM/yyyy');
  var dataFormatada;
  double alturaCalendar = 0;
  DateTime selectedDate;

  String selectedDateFormated;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.titleTarefa != null) {
      _textController.text = widget.titleTarefa;

      //selectedDateFormated = formatterDataEnviada.format(DateTime.parse(widget.datatarefa));
      //print("DATA ENVIADA FORMATADA : $selectedDateFormated");
      selectedDate = DateTime.parse(widget.datatarefa);
      //calendarController.selectedDay = DateTime.parse(widget.datatarefa);

    }
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
        //textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      backgroundColor: Colors.white,
      actions: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  if (visibleCalendar == false) {
                    visibleCalendar = !visibleCalendar;
                    alturaCalendar = 300;
                    //homeStore.setAlturaCalendar(350);
                  } else {
                    visibleCalendar = !visibleCalendar;
                    alturaCalendar = 0;
                    //homeStore.setAlturaCalendar(0);
                  }
                });
              },
              child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15)),
                  child: visibleCalendar == false //visibleCalendar == false
                      ? Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.close,
                          color: Colors.white,
                        )),
            ),
            SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                if (widget.titleTarefa == null) {
                  TarefaModel tm = TarefaModel(
                      //dataformatada
                      _textController.text,
                      calendarController.selectedDay.toString(),
                      false);
                  FirebaseController fc = FirebaseController();
                  fc.saveFirebase(tm, widget.user, dataFormatada);
                  Navigator.pop(context);
                }else{
                  FirebaseController fc = FirebaseController();
                  fc.updateTarefaTitleFirebase(widget.user, dataFormatada, widget.selectedDOC, _textController.text);
                  
                  Navigator.pop(context);
                }
              },
              child: Container(
                width: 200,
                height: 50,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Text(widget.titleTarefa == null ? "Salvar" : "Editar"),
                ),
              ),
            )
          ],
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
                    onSubmitted: (_) {
                      /*TarefaModel tm = TarefaModel(//dataformatada
                          _textController.text, calendarController.selectedDay.toString(), false);
                      FirebaseController fc = FirebaseController();
                      fc.saveFirebase(tm, widget.user, dataFormatada);*/

                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            AnimatedSize(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              vsync: this,
              child: Container(
                width: width,
                height: alturaCalendar,
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
                  initialSelectedDay:
                      widget.datatarefa != null ? selectedDate : DateTime.now(),

                  onDaySelected: (date, List days) {
                    print(date);
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
