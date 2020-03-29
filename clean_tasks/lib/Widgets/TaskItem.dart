import 'package:flutter/material.dart';

class TaskItem extends StatefulWidget {

  final bool concluido;
  final String title;

  const TaskItem({Key key, this.concluido, this.title}) : super(key: key);
  
  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color:widget.concluido == true? Colors.orange[100]: Colors.orange[300],
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Radio(groupValue: widget.concluido == true ? null:1,),
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
    );
  }
}
