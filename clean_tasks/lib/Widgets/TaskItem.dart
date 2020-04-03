import 'dart:math';

import 'package:clean_tasks/Controllers/FirebaseController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'DialogAddTask.dart';

class TaskItem extends StatefulWidget {

  final bool concluido;
  final String title;
  final Color color;
  final String selectedDOC;
  final String data;
  final FirebaseUser user;
  final DocumentSnapshot dados;
  

  const TaskItem({Key key, this.concluido , this.title, this.color, this.selectedDOC, this.data, this.user, this.dados}) : super(key: key);
  
  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool checked ;
  //List<Color> colors =[Colors.blue, Colors.orange,Colors.purple,Colors.yellow,Colors.pink,Colors.red,Colors.green];
  //int cor;
  //var random = Random();
  Color cor;

 _dialodAddTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogAddTask(
            user: widget.user,
            titleTarefa: widget.title,
            datatarefa: widget.dados.data["data"],
            selectedDOC: widget.selectedDOC,
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checked = widget.concluido;
    //cor = random.nextInt(colors.length) ;
    cor = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        
        AnimatedContainer(
          duration: Duration(milliseconds: 400),
          //padding: EdgeInsets.only(top: 0,bottom: 12),
          width: double.infinity,
          decoration: BoxDecoration(
              color:checked == true? Colors.orange[100]:Colors.orange[300],//cor.withOpacity(0.35): cor.withOpacity(0.7),//colors[cor].withOpacity(0.3): colors[cor].withOpacity(0.7),
              borderRadius: BorderRadius.circular(15),
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
            //mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Checkbox(
                    value: checked,
                    activeColor: Colors.transparent,
                    checkColor: Colors.green,
                    //groupValue: radioValue,
                    onChanged: (bool value){
                      
                      setState(() {

                        checked = value;

                        FirebaseController fc = FirebaseController();
                        fc.updadeStatusFirebase(widget.user, widget.data, widget.selectedDOC,checked);
                        print(checked);
                      });
                    },
                  ),//groupValue: widget.concluido == true ? null:1,),
                  Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 11,bottom: 11),
                        width: 260,
                        child: GestureDetector(
                          onTap: (){
                            print("DATA ENVIADA ${widget.dados.data["data"]}");
                            _dialodAddTask();
                            },
                          child: Text(widget.title,style: TextStyle(fontSize: 20),)),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 10,right: 15,top: 10),
                child: Icon(Icons.sort),
              )
            ],
          )
          /*ListTile(
            
            title: Text("Iniciar Projeto",style: TextStyle(
              fontSize: 20
            ),),
            leading: Radio(
              groupValue: 1,
            ),
            trailing: GestureDetector(
                  child: Icon(Icons.sort),
                ),
          )*/
        ),
        SizedBox(height: 10,),
      ],
    );
  }
}
