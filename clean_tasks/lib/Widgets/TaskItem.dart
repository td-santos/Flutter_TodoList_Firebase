import 'dart:math';

import 'package:flutter/material.dart';

class TaskItem extends StatefulWidget {

  final bool concluido;
  final String title;
  final Color color;
  

  const TaskItem({Key key, this.concluido , this.title, this.color}) : super(key: key);
  
  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool checked ;
  //List<Color> colors =[Colors.blue, Colors.orange,Colors.purple,Colors.yellow,Colors.pink,Colors.red,Colors.green];
  //int cor;
  //var random = Random();
  Color cor;


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
                        print(checked);
                      });
                    },
                  ),//groupValue: widget.concluido == true ? null:1,),
                  Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 11,bottom: 11),
                        width: 260,
                        child: Text(widget.title,style: TextStyle(fontSize: 20),),
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
