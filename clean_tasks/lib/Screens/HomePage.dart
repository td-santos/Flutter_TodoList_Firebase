import 'package:clean_tasks/Controllers/FirebaseController.dart';
import 'package:clean_tasks/Controllers/GoogleLogin.dart';
import 'package:clean_tasks/Screens/Login.dart';
import 'package:clean_tasks/Stores/home_store.dart';
import 'package:clean_tasks/TemaDark.dart';
import 'package:clean_tasks/Widgets/DialogAddTask.dart';
import 'package:clean_tasks/Widgets/TaskItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser user;
  final bool dark;
  final bool orderAsc;

  const HomePage({Key key, this.user, this.dark, this.orderAsc})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  CalendarController calendarController = CalendarController();
  DateFormat formatterDataString = new DateFormat('dd/MM/yyyy');
  DateTime dataAtual = new DateTime.now();
  String data = "";
  
  bool darkMode;
  bool orderAsc;
  TemaDark temaDark = TemaDark();
  bool dadosFirebase;

  HomeStore homeStore = HomeStore();

  salvarShared(bool darkmode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("darkMode", darkmode);

    print("(SalvarPrefs Dark): $darkmode");
    
  }

  salvarOrderListShared(bool orderasc) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("orderAsc", orderasc);

    print("(SalvarPrefs order): $orderAsc");
  }

  initPrefs() async {
    homeStore.setDarkMode(widget.dark);
    homeStore.setOrderCres(widget.orderAsc);
    print("INITPREFS HOME DARK: ${homeStore.darkMode}");
    print("INITPREFS HOME ORDER ASC: ${homeStore.orderAsc}");
  }

  _dialodAddTask() {
    showDialog(
        context: context,
        builder: (context) {
          
          print("DarkMODE homeStore Dialog ADD: ${homeStore.darkMode}");

          return DialogAddTask(
            
            user: widget.user,
            darkMode: homeStore.darkMode,
          );
        });
  }

  Future<bool> _dialodConta() {
    showDialog(
        context: context,
        builder: (context) {
          return _dialogPerfil(MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
          
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();    
    initPrefs();
    data = formatterDataString.format(dataAtual);
    homeStore.setDataFormatada(data);
    //homeStore.setAturaHOJE(width * 0.12);
    //homeStore.setAturaData(width * 0.032);
  }

  @override
  Widget build(BuildContext context) {

    

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    //homeStore.setAlturaListView(alturaTotal);
    //homeStore.resetAlturaListView(0);
    

    return WillPopScope(
      onWillPop: _dialodConta,
      child: Scaffold(        
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Observer(builder: (_) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),              
              decoration: BoxDecoration(
                color: homeStore.darkMode == true
                    ? temaDark.scafoldcolor
                    : Colors.white,
                /*image:DecorationImage(
              image:dadosFirebase == true? AssetImage(""): AssetImage("assets/phone_people.png"),
              alignment: Alignment.center,
              fit: BoxFit.contain)*/
              ),
              padding: EdgeInsets.only(left: width * 0.03, right: width * 0.03, top: width * 0.15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            
                            child: Container(
                              height: height * 0.06,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(width * 0.035),
                                child: Image.network(
                                  widget.user.photoUrl,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          GestureDetector(
                              onTap: () {
                                _dialodConta();
                              },
                              child: Icon(
                                Icons.sort,
                                size: width * 0.07,
                                color: homeStore.darkMode == true
                                    ? Colors.black
                                    : Colors.grey[400],
                              ))
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          //_saveFirebase();
                          _dialodAddTask();
                          //_bottomSheetAddTask();
                        },
                        child: Container(
                          padding: EdgeInsets.all(width * 0.04),
                            //height: height * 0.055,
                            //width: height * 0.055,
                            decoration: BoxDecoration(
                                color: homeStore.darkMode == true
                                    ? temaDark.buttomAddcolor
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(width * 0.035)),
                            child: Icon(
                              Icons.add,size: width * 0.05,
                              color: homeStore.darkMode == true
                                  ? temaDark.iconAddcolor
                                  : Colors.blue[600],
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Observer(
                            builder: (_) {
                              return AnimatedSize(
                                curve: Curves.ease,
                                vsync: this,
                                duration: Duration(milliseconds: 300),
                                child: Text(
                                  "Hoje",
                                  style: TextStyle(
                                      color: homeStore.darkMode == true
                                          ? temaDark.textDiaAtualcolor
                                          : Colors.grey[850],
                                      fontSize: homeStore.alturaHOJE,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            },
                          ),
                          Observer(
                            builder: (_) {
                              return AnimatedSize(
                                curve: Curves.ease,
                                vsync: this,
                                duration: Duration(milliseconds: 300),
                                child: Text(
                                  " ${homeStore.dataFormatada}", //" ${dataFormatada}",
                                  style: TextStyle(
                                      fontSize: homeStore.alturaData,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Observer(
                        builder: (_) {
                          return GestureDetector(
                            onTap: () {
                              if (homeStore.visibleCalendar == false) {
                                homeStore.setVisibleCalendar();
                                homeStore.setAlturaCalendar(width * 1.05);
                              } else {
                                homeStore.setAlturaCalendar(0);
                                homeStore.setVisibleCalendar();
                                
                              }
                            },
                            child: Container(
                                //duration: Duration(milliseconds: 000),
                                padding: EdgeInsets.all(width * 0.03),
                                //height: height * 0.055,
                                //width: height * 0.055,
                                decoration: BoxDecoration(
                                    color: homeStore.darkMode == true
                                        ? Colors.blue[800]
                                        : Colors.blue,
                                    borderRadius: BorderRadius.circular(width * 0.035)),
                                child: homeStore.visibleCalendar == false //visibleCalendar == false
                                    ? Icon(
                                        Icons.calendar_today,//size: width * 0.055,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        Icons.close,//size: width * 0.055,
                                        color: Colors.white,
                                      )),
                          );
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Observer(
                    builder: (_) {
                      return AnimatedSize(
                        duration: Duration(milliseconds: 400),
                        vsync: this,
                        curve: Curves.easeInOut,
                        reverseDuration: Duration(milliseconds: 10),
                        child: Container(
                          height: homeStore.alturaCalendar, //alturaCalendar,
                          child: TableCalendar(
                            availableGestures: AvailableGestures.none,
                            calendarController: calendarController,
                            locale: "pt_BR",
                            headerStyle: HeaderStyle(
                              titleTextStyle: TextStyle(
                                  color: homeStore.darkMode == true
                                      ? temaDark.calendarHeadcolor
                                      : null),
                              formatButtonShowsNext: false,
                              formatButtonVisible: false,
                              centerHeaderTitle: true,
                            ),
                            calendarStyle: CalendarStyle(
                                outsideDaysVisible: false,
                                //weekendStyle: TextStyle(color: Colors.yellow),
                                weekdayStyle: TextStyle(
                                    color: homeStore.darkMode == true
                                        ? temaDark.calendarDayscolor
                                        : null)),
                            initialCalendarFormat: CalendarFormat.month,
                            onDaySelected: (date, List days) {
                              if (homeStore.dataFormatada !=
                                  formatterDataString.format(date)) {
                                homeStore.dataFormatada =
                                    formatterDataString.format(date);
                                //homeStore.setAlturaListView(alturaTotal);
                                if (homeStore.dataFormatada !=
                                    formatterDataString
                                        .format(DateTime.now())) {
                                  homeStore.setAturaData(width * 0.09);
                                  homeStore.setAturaHOJE(0);
                                } else {
                                  homeStore.setAturaData(width * 0.032);
                                  homeStore.setAturaHOJE(width * 0.12);
                                }
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Observer(
                    builder: (_) {
                      return AnimatedSize(
                        duration: Duration(milliseconds: 300),
                        vsync: this,
                        child: SizedBox(
                            height: height, //homeStore.alturaListView,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: Firestore.instance
                                  .collection("tarefa_bd")
                                  .document(widget.user.uid)
                                  .collection(homeStore.dataFormatada
                                      .replaceAll("/", "-"))
                                  .orderBy("data",
                                      descending: !homeStore.orderAsc)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                  case ConnectionState.waiting:
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );

                                  default:
                                    List<DocumentSnapshot> documents =
                                        snapshot.data.documents;

                                    if (documents.length < 1) {
                                      dadosFirebase = false;

                                      return Container();
                                      //return Container(child: Image.asset("assets/phone_people.png",fit: BoxFit.contain,),);
                                    } else {
                                      dadosFirebase = true;
                                      return ListView.builder(
                                        physics: ClampingScrollPhysics(),
                                        padding: EdgeInsets.only(bottom: 200),
                                        itemCount: documents.length,
                                        itemBuilder: (context, index) {
                                          return TaskItem(
                                            title:
                                                documents[index].data["tarefa"],
                                            concluido: documents[index]
                                                .data["concluido"],
                                            selectedDOC:
                                                documents[index].documentID,
                                            dados: documents[index],
                                            user: widget.user,
                                            data: homeStore.dataFormatada,
                                            darkMode: homeStore.darkMode,
                                            lastItem: documents[index] ==
                                                    documents.last
                                                ? true
                                                : false,
                                          );
                                        },
                                      );
                                    }
                                }
                              },
                            )),
                      );
                    },
                  ),
                  SizedBox(
                    height: 200,
                  )
                ],
              ),
            );
          }),
        ),
        
      ),
    );
  }

  /////////////////////////////////////////////////////////////////////////////////////////

  Widget _dialogPerfil(double width, double heigth) {
    return AlertDialog(

      backgroundColor: Colors.transparent,
      content: SingleChildScrollView(
        child: Observer(builder: (contex) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: width,
          decoration: BoxDecoration(
              color: homeStore.darkMode == true
                  ? temaDark.dialogColor
                  : Colors.white,
              borderRadius: BorderRadius.circular(width * 0.05)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: width * 0.02, left: width * 0.02, bottom: width * 0.02,right: width * 0.02),
                child: Container(
                  height: heigth * 0.1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(width * 0.035),
                    child: Image.network(
                      widget.user.photoUrl,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.02, right: width * 0.02, bottom: 0),
                child: Text(
                  widget.user.displayName,
                  style: TextStyle(
                      fontSize: width * 0.04,
                      color: homeStore.darkMode == true
                          ? Colors.grey[400]
                          : Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.02, right: width * 0.02, bottom: width * 0.02),
                child: Text(
                  widget.user.email,
                  style: TextStyle(
                      fontSize: width * 0.03,
                      color: homeStore.darkMode == true
                          ? Colors.grey[600]
                          : Colors.grey[600]),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: width * 0.02,  top: width * 0.02, ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Modo Escuro",
                      style: TextStyle(
                          fontSize: width * 0.035,
                          color: homeStore.darkMode == true
                              ? Colors.grey[400]
                              : Colors.black),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.01),
                      child: Switch(

                          value: homeStore.darkMode,
                          onChanged: (value) {
                            darkMode = value;
                            homeStore.setDarkMode(value);
                            salvarShared(homeStore.darkMode);
                          }),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: width * 0.01, left: width * 0.02, right: width * 0.02, bottom: width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Ordenação Crescente",
                      style: TextStyle(
                          fontSize: width * 0.035,
                          color: homeStore.darkMode == true
                              ? Colors.grey[400]
                              : Colors.black),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.01),
                      child: Observer(builder: (contex) {
                        return Switch(
                            value: homeStore.orderAsc,
                            onChanged: (value) {
                              orderAsc = value;
                              //value = !value;
                              homeStore.setOrderCres(value);
                              salvarOrderListShared(homeStore.orderAsc);
                            });
                      }),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: width * 0.04),
                child: GestureDetector(
                  onTap: () {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    auth.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Container(
                    width: width,
                    height: heigth * 0.06,
                    decoration: BoxDecoration(
                        color: Colors.red[400],
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(width * 0.05),
                            bottomRight: Radius.circular(width * 0.05))),
                    child: Center(
                      child: AnimatedDefaultTextStyle(
                        child: Text(
                        "Fazer LogOff",
                        
                      ), 
                        style: TextStyle(
                            fontSize: width * 0.04,
                            color:homeStore.darkMode == true? Colors.grey[850] : Colors.grey[300],
                            fontWeight: FontWeight.w500), 
                        duration: Duration(milliseconds: 300)),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      })),
    );
  }
}
