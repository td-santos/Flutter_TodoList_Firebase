import 'package:clean_tasks/Controllers/FirebaseController.dart';
import 'package:clean_tasks/Model/TarefaModel.dart';
import 'package:clean_tasks/TemaDark.dart';
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
  final bool darkMode;

  const DialogAddTask({
    Key key,
    this.user,
    this.datatarefa,
    this.titleTarefa,
    this.selectedDOC, this.darkMode,
  }) : super(key: key);

  @override
  _DialogAddTaskState createState() => _DialogAddTaskState();
}

class _DialogAddTaskState extends State<DialogAddTask>
    with TickerProviderStateMixin {
  CalendarController calendarController = CalendarController();
  TextEditingController _textController = TextEditingController();
  DateFormat formatterDataString = new DateFormat('dd/MM/yyyy');
  String dataFormatada;
  bool visibleCalendar = false;
  double alturaCalendar = 0;
  DateTime selectedDate;
  TemaDark temaDark = TemaDark();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.titleTarefa != null) {
      _textController.text = widget.titleTarefa;
      selectedDate = DateTime.parse(widget.datatarefa);
    }

    dataFormatada = formatterDataString.format(DateTime.now());
    print(dataFormatada);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return AlertDialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(width * 0.040)),
      
      content: SingleChildScrollView(
          child: Container(
        width: width,
        decoration: BoxDecoration(
            color: widget.darkMode == true? temaDark.dialogColor: Colors.white, 
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5, top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      style: TextStyle(
                        color: widget.darkMode==true ?Colors.grey[300]:Colors.black,
                        fontSize: 20
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 15,
                      minLines: 1,
                      autofocus: true,
                      controller: _textController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)))),
                    ),
                  ),
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
                        height: 63.5,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15))),
                        child: visibleCalendar == false
                            ? Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.close,
                                color: Colors.white,
                              )),
                  )
                ],
              ),
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
                    titleTextStyle: TextStyle(
                              color: widget.darkMode == true
                                  ? temaDark.calendarHeadcolor
                                  : null),
                    formatButtonShowsNext: false,
                    formatButtonVisible: false,
                    centerHeaderTitle: true,
                  ),
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                    weekdayStyle: TextStyle(
                                color: widget.darkMode == true
                                    ? temaDark.calendarDayscolor
                                    : null)
                    ),
                  daysOfWeekStyle: DaysOfWeekStyle(),
                  initialCalendarFormat: CalendarFormat.month,
                  initialSelectedDay:
                      widget.datatarefa != null ? selectedDate : DateTime.now(),
                  onDaySelected: (date, List days) {
                    print(date);
                    dataFormatada = formatterDataString.format(date);
                    print(dataFormatada);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: (){
                if (widget.titleTarefa == null) {
                  TarefaModel tm = TarefaModel(_textController.text,calendarController.selectedDay.toString(),false);
                  FirebaseController fc = FirebaseController();
                  fc.saveFirebase(tm, widget.user, dataFormatada);
                  Navigator.pop(context);

                } else {
                  FirebaseController fc = FirebaseController();
                  fc.updateTarefaTitleFirebase(widget.user, dataFormatada,widget.selectedDOC, _textController.text);
                  Navigator.pop(context);

                }
              },
              child: Container(
                width: width,
                height: 60,
                decoration: BoxDecoration(
                    color: widget.titleTarefa ==null? Colors.green:Colors.orange,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Center(
                  child: Text(
                    widget.titleTarefa == null ? "Salvar" : "Editar",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
