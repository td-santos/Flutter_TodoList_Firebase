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

  const HomePage({Key key, this.user, this.dark}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  

  CalendarController calendarController = CalendarController();
  DateFormat formatterDataString = new DateFormat('dd/MM/yyyy');
  DateTime dataAtual = new DateTime.now();
  String data = "";
  //SharedPreferences prefs = SharedPreferences.getInstance();
  bool darkMode ;
  TemaDark temaDark =TemaDark();

  HomeStore homeStore = HomeStore();


  salvarShared(bool darkmode) async {
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("darkMode", darkmode);

    print("(SalvarPrefs): ");
    //initState();
  }

  initPrefs()async{
    final prefs = await SharedPreferences.getInstance();
    darkMode = prefs.getBool("darkMode");
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
    
    darkMode = widget.dark;
    //initPrefs();
    

    data = formatterDataString.format(dataAtual);
    homeStore.setDataFormatada(data);
    

    ///homeStore.resetAlturaListView(0);
  }

  @override
  Widget build(BuildContext context) {

    double alturaTotal = MediaQuery.of(context).size.height;
    //homeStore.setAlturaListView(alturaTotal);
    //homeStore.resetAlturaListView(0);

    return Scaffold(
      //backgroundColor: darkMode == true ?temaDark.scafoldcolor: null,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),

          color: darkMode == true ?temaDark.scafoldcolor: Colors.white,
          /*decoration: BoxDecoration(
            image:DecorationImage(
              image: AssetImage("assets/peoples_vector.png"),
              alignment: Alignment.center,
              fit: BoxFit.contain)
          ),*/
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
                            color: darkMode ==true ? temaDark.buttomAddcolor:Colors.grey[200],
                            borderRadius: BorderRadius.circular(15)),
                        child: Icon(
                          Icons.add,
                          color: darkMode == true ? temaDark.iconAddcolor: Colors.blue[600],
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
                      Observer(
                        builder: (_) {
                          return AnimatedSize(
                            curve: Curves.ease,
                            vsync: this,
                            duration: Duration(milliseconds: 300),
                            child: Text(
                              "Hoje",
                              style: TextStyle(
                                color: darkMode == true ?temaDark.textDiaAtualcolor: null,
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
                            homeStore.setAlturaCalendar(350);
                          } else {
                            homeStore.setVisibleCalendar();
                            homeStore.setAlturaCalendar(0);
                          }
                        },
                        child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(15)),
                            child: homeStore.visibleCalendar ==
                                    false //visibleCalendar == false
                                ? Icon(
                                    Icons.calendar_today,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  )),
                      );
                    },
                  )
                ],
              ),
              SizedBox(
                height: 10,
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
                          titleTextStyle: TextStyle(color: darkMode == true ? temaDark.calendarHeadcolor : null),
                          formatButtonShowsNext: false,
                          formatButtonVisible: false,
                          centerHeaderTitle: true,
                        ),
                        calendarStyle: CalendarStyle(

                          outsideDaysVisible: false,
                          //weekendStyle: TextStyle(color: Colors.yellow),
                          weekdayStyle: TextStyle(color: darkMode == true ? temaDark.calendarDayscolor:null) 
                          ),
                        initialCalendarFormat: CalendarFormat.month,
                        onDaySelected: (date, List days) {
                          if (homeStore.dataFormatada !=
                              formatterDataString.format(date)) {
                            homeStore.dataFormatada =
                                formatterDataString.format(date);
                            //homeStore.setAlturaListView(alturaTotal);
                            if (homeStore.dataFormatada !=
                                formatterDataString.format(DateTime.now())) {
                              homeStore.setAturaData(40);
                              homeStore.setAturaHOJE(0);
                            } else {
                              homeStore.setAturaData(15);
                              homeStore.setAturaHOJE(50);
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
                        height: alturaTotal,//homeStore.alturaListView,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: Firestore.instance
                              .collection("tarefa_bd")
                              .document(widget.user.uid)
                              .collection(homeStore.dataFormatada.replaceAll("/", "-")).orderBy("data")
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

                                    if(documents.length<1){
                                      return Container();//return Container(child: Image.asset("assets/peoples_vector.png",fit: BoxFit.scaleDown,),);
                                    }else{

                                return ListView.builder(
                                  padding: EdgeInsets.only(bottom: 200),
                                  itemCount: documents.length,
                                  
                                  itemBuilder: (context, index) {
                                    return TaskItem(
                                      title: documents[index].data["tarefa"],
                                      concluido:
                                          documents[index].data["concluido"],
                                      selectedDOC: documents[index].documentID,
                                      dados: documents[index],
                                      user: widget.user,
                                      data: homeStore.dataFormatada,
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
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: FloatingActionButton(
          child: Icon(Icons.settings),
          onPressed: (){
            if(darkMode == null){
                darkMode =false;
              }

            setState(() {
              
              darkMode =!darkMode;
              salvarShared(darkMode);
              print("DarkMode= $darkMode");
            });
            
            

          },
          ),),
      
      
    );
  }
}
