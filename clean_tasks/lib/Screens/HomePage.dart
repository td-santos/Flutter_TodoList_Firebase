import 'package:clean_tasks/Widgets/TaskItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser user;

  const HomePage({Key key, this.user}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  
  CalendarController calendarController = CalendarController();

  double alturaCalendar =0;
  bool visibleCalendar=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //visibleCalendar = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        widget.user.photoUrl,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15)),
                        child: Icon(
                          Icons.add,
                          color: Colors.blue[600],
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Hoje",
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        " 04/04/2020",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        //visibleCalendar = !visibleCalendar;
                        if(visibleCalendar==false){
                          visibleCalendar = true;
                          alturaCalendar=400;
                        }else{
                          visibleCalendar = false;
                          alturaCalendar=0;
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
                vsync: this,curve: Curves.easeInOut,
                reverseDuration:Duration(milliseconds: 10),
                //visible: visibleCalendar,
                child: Container(
                  height: alturaCalendar,
                  child: TableCalendar(
                  calendarController: calendarController,
                  //locale: "pt_BR",
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
                  onVisibleDaysChanged:
                      (dateFirst, dateLast, CalendarFormat cf) {
                    //print(dateFirst);

                    //dataFormatada = formatterCalendar.format(dateFirst);
                    //_allMovMes(dataFormatada);

                    //print("DATA FORMATADA CALENDAR $dataFormatada");

                    //print("Data Inicial: $dateFirst ....... Data Final: $dateLast");
                  },
                  onDaySelected: (date, List days) {
                    setState(() {
                      //visibleCalendar = false;
                    });
                    print("DIA SELECIONADO $date");
                  },
                ),
                ),
              ),
              SizedBox(height: 15,),
              TaskItem(
                concluido: false,
                title: "Iniciar Projeto Flutter",
              ),
              SizedBox(height: 15,),
              TaskItem(
                concluido: true,
                title: "Verificar erros na aplicação",
              ),
              SizedBox(height: 15,),
              TaskItem(
                concluido: true,
                title: "Palavras aleatórias para verificar  tamanho do texto dentro da Box!",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
