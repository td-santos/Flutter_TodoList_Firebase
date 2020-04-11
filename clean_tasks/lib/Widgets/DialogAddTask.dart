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
    double height = MediaQuery.of(context).size.height;

    return AlertDialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(width * 0.05)),
      
      content: SingleChildScrollView(
          child: Container(
        width: width,
        decoration: BoxDecoration(
            color: widget.darkMode == true? temaDark.dialogColor: Colors.white, 
            borderRadius: BorderRadius.circular(width * 0.05)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: width * 0.02, right: width * 0.02, top: width * 0.04),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: TextField(

                      style: TextStyle(
                        color: widget.darkMode==true ?Colors.grey[300]:Colors.black,
                        fontSize: 17,//width * 0.0476
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 15,
                      minLines: 1,
                      autofocus: true,
                      controller: _textController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(width * 0.04),
                                  bottomLeft: Radius.circular(width * 0.04)))),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (visibleCalendar == false) {
                          visibleCalendar = !visibleCalendar;
                          alturaCalendar = height * 0.4;
                          //homeStore.setAlturaCalendar(350);
                        } else {
                          visibleCalendar = !visibleCalendar;
                          alturaCalendar = 0;
                          //homeStore.setAlturaCalendar(0);
                        }
                      });
                    },
                    child: Container(
                        height: 60,//height * 0.072,
                        width: width * 0.13,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(width * 0.04),
                                bottomRight: Radius.circular(width * 0.04))),
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
              height: height * 0.01,
            ),
            AnimatedSize(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              vsync: this,
              child: Container(
                width: width,
                height: alturaCalendar,
                child: TableCalendar(
                  availableGestures: AvailableGestures.none,
                  calendarController: calendarController,
                  locale: "pt_BR",
                  headerStyle: HeaderStyle(
                    titleTextStyle: TextStyle(
                      fontSize: 12,
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
                      fontSize: 12,
                      color: widget.darkMode == true ? temaDark.calendarDayscolor : null),
                    weekendStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.red
                    ),
                    todayStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.white
                    ),
                    selectedStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.white
                    )
                    ),

                    
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekendStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 12
                    ),
                    weekdayStyle: TextStyle(
                      color: widget.darkMode == true ?Colors.grey: Colors.black,
                      fontSize: 12,
                    ),

                  ),
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
              height: visibleCalendar ==true? 0 : height * 0.02,
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
                height: height * 0.06,
                decoration: BoxDecoration(
                    color: widget.titleTarefa ==null? Colors.green:Colors.orange,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(width * 0.05),
                        bottomRight: Radius.circular(width * 0.05))),
                child: Center(
                  child: Text(
                    widget.titleTarefa == null ? "Salvar" : "Editar",
                    style: TextStyle(fontSize: width * 0.05, color: Colors.white),
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
