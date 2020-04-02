import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarCustom extends StatefulWidget {
  @override
  _CalendarCustomState createState() => _CalendarCustomState();
}
String dataFormatada;

class _CalendarCustomState extends State<CalendarCustom> with TickerProviderStateMixin{
  CalendarController calendarController = CalendarController();
  double alturaCalendar = 0;
  bool visibleCalendar = false;
  //Firestore bd = Firestore.instance;
  //FirebaseController fc =FirebaseController();
  var formatterDataString = new DateFormat('dd/MM/yyyy');
  
  String dataFormatadaFirebase;
  var dataAtual = new DateTime.now();
  double sizeData = 15;
  double sizeHOJE = 50;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //dataFormatada = formatterDataString.format(dataAtual);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AnimatedSize(
                        curve: Curves.ease,
                        vsync: this,
                        duration: Duration(milliseconds: 300),
                        child: Text(
                          "Hoje",
                          style: TextStyle(
                              fontSize: sizeHOJE, fontWeight: FontWeight.bold),
                        ),
                      ),
                      AnimatedSize(
                        curve: Curves.ease,
                        vsync: this,
                        duration: Duration(milliseconds: 300),
                        child: Text(
                          " ${dataFormatada}",
                          style: TextStyle(
                              fontSize: sizeData,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        //visibleCalendar = !visibleCalendar;
                        if (visibleCalendar == false) {
                          visibleCalendar = true;
                          alturaCalendar = 350;
                        } else {
                          visibleCalendar = false;
                          alturaCalendar = 0;
                        }
                      });
                    },
                    child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15)),
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
              SizedBox(
                height: 10,
              ),
              AnimatedSize(
                duration: Duration(milliseconds: 400),
                vsync: this, curve: Curves.easeInOut,
                reverseDuration: Duration(milliseconds: 10),                
                child: Container(
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
                    initialCalendarFormat: CalendarFormat.month,
                    onDaySelected: (date, List days) {
                      setState(() {
                        
                        dataFormatada = formatterDataString.format(date);
                        
                        if (dataFormatada !=
                            formatterDataString.format(DateTime.now())) {
                          sizeData = 40;
                          sizeHOJE = 0;
                        } else {
                          sizeData = 15;
                          sizeHOJE = 50;
                        }
                      });
                      print("DIA SELECIONADO $dataFormatada");
                      print("DATA NOW " +formatterDataString.format(DateTime.now()));
                    },
                  ),
                ),
              ),
      ],
    );
  }
}