import 'package:clean_tasks/Controllers/FirebaseController.dart';
import 'package:clean_tasks/Model/TarefaModel.dart';
import 'package:clean_tasks/Screens/Login.dart';

import 'package:clean_tasks/Widgets/DialogAddTask.dart';
import 'package:clean_tasks/Widgets/TaskItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser user;

  const HomePage({Key key, this.user}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  CalendarController calendarController = CalendarController();
  double alturaCalendar = 0;
  bool visibleCalendar = false;
  Firestore bd = Firestore.instance;
  FirebaseController fc =FirebaseController();
  var formatterDataString = new DateFormat('dd/MM/yyyy');
  String dataFormatada;
  String dataFormatadaFirebase;
  var dataAtual = new DateTime.now();
  double sizeData = 15;
  double sizeHOJE = 50;

  _saveFirebase() async {
    
    bd
        .collection("tarefa_bd")
        .document(widget.user.uid)
        .collection(dataFormatada.replaceAll("/", "-"))
        .snapshots()
        .listen((onData) {
      onData.documents.forEach((d) {
        print("FIREBASE:" + d.data.toString());
      });
    });
  }

  _dialodAddTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogAddTask(
            user: widget.user,
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //visibleCalendar = false;
    dataFormatada = formatterDataString.format(dataAtual);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onLongPress: () {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      auth.signOut();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Container(
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          widget.user.photoUrl,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //_saveFirebase();
                      _dialodAddTask();
                      //_bottomSheetAddTask();
                    },
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
              SizedBox(
                height: 15,
              ),
              
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("tarefa_bd").document(widget.user.uid)
                    .collection(dataFormatada.replaceAll("/", "-")).snapshots(),
                    //fc.getTarefasFirebase(widget.user, dataFormatada),
                builder: (context, snapshot){
                  switch(snapshot.connectionState){
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(
                        
                      ),
                    );
                    
                    default:
                    List<DocumentSnapshot> documents = snapshot.data.documents;

                    return ListView.builder(
                      padding: EdgeInsets.only(bottom: 200),
                      itemCount: documents.length,
                      itemBuilder: (context, index){
                        return TaskItem(
                          title: documents[index].data["tarefa"],
                          concluido: documents[index].data["concluido"],
                          color: Colors.white//index %2 ==0 ? Colors.blue :Colors.orange
                        );
                        //return ListTile(
                        //  title: Text(documents[index].data["tarefa"]),
                        //);
                      },
                    );

                  }
                },
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
