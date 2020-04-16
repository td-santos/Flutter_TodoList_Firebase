import 'dart:math';

import 'package:clean_tasks/Controllers/FirebaseController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'DialogAddTask.dart';

class TaskItem extends StatefulWidget {
  final bool darkMode;
  final bool concluido;
  final String title;

  final String selectedDOC;
  final String data;
  final FirebaseUser user;
  final DocumentSnapshot dados;
  final bool lastItem;

  const TaskItem(
      {Key key,
      this.concluido,
      this.title,
      this.selectedDOC,
      this.data,
      this.user,
      this.dados, this.lastItem, this.darkMode})
      : super(key: key);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool checked;

  

  _dialodAddTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogAddTask(
            user: widget.user,
            titleTarefa: widget.title,
            datatarefa: widget.dados.data["data"],
            selectedDOC: widget.selectedDOC,
            darkMode: widget.darkMode,
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        AnimatedContainer(
            
            duration: Duration(milliseconds: 400),
            
            width: width,
            decoration: BoxDecoration(
              color:widget.darkMode==true
              ? widget.concluido == true ? Colors.orange[200] : Colors.orange
              : widget.concluido == true ? Colors.orange[100] : Colors.orange[300],
              borderRadius: BorderRadius.circular(width * 0.045),
              /*boxShadow: [BoxShadow(
                color: Colors.grey[300],
                blurRadius: 2,
                spreadRadius: 0,
                offset: Offset(2, 2)
              )]*/
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Checkbox(
                      value: widget.concluido,
                      activeColor: Colors.transparent,
                      checkColor: Colors.green,
                      onChanged: (bool value) {
                        setState(() {
                          checked = value;

                          FirebaseController fc = FirebaseController();
                          fc.updadeStatusFirebase(widget.user, widget.data,
                              widget.selectedDOC, checked);
                          print(checked);
                        });
                      },
                    ),
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: width * 0.025, bottom: width * 0.025),
                          width: width * 0.6,
                          child: GestureDetector(
                              onTap: () {
                                print(
                                    "DATA ENVIADA ${widget.dados.data["data"]}");
                                _dialodAddTask();
                              },
                              child: Text(
                                widget.title,
                                style: TextStyle(fontSize: width * 0.05),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.01, right: width * 0.025, top: width * 0.025),
                  child: GestureDetector(
                    onTap: (){
                      showDialog(context: context,
                      builder: (context){
                        return AlertDialog(
                          elevation: 40,
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * 0.030)),
                          content: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color:widget.darkMode ==true? Colors.grey[850] : Colors.white,
                              borderRadius: BorderRadius.circular(15)
                            ),
                            width: width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("  Deletar Item?",style: TextStyle(
                                  fontSize: width * 0.05,
                                  color: widget.darkMode == true ?Colors.grey[300]: Colors.white
                                ),),
                                SizedBox(width: 10,),
                                GestureDetector(
                                  onTap: (){
                                    FirebaseController fc = FirebaseController();
                                    fc.deleteTarefaFirebase(widget.user, widget.data, widget.selectedDOC);
                                    

                                    Navigator.pop(context);
                                    
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Icon(Icons.check,color: Colors.white,),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                    },
                    child: Icon(Icons.sort),
                  ),
                )
              ],
            )),
        SizedBox(
          height: widget.lastItem ==true ?100:10,
        ),
      ],
    );
  }
}
