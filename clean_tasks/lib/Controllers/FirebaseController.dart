

import 'package:clean_tasks/Model/TarefaModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseController{

  Firestore bd = Firestore.instance;
  

  FirebaseController();

  saveFirebase(TarefaModel tarefa, FirebaseUser fbUser, String data)async{
    await bd.collection("tarefa_bd").document(fbUser.uid).collection(data.replaceAll("/", "-")).add(tarefa.toMap());
  }


  updateTarefaTitleFirebase(FirebaseUser fbUser, String data, String selectedDoc,String tarefaTitle)async{
    await bd.collection("tarefa_bd").document(fbUser.uid).collection(data.replaceAll("/", "-")).document(selectedDoc).updateData({"tarefa":tarefaTitle} );
  }


  updadeStatusFirebase(FirebaseUser fbUser, String data,String selectedDoc, bool concluido)async{
    await bd.collection("tarefa_bd").document(fbUser.uid).collection(data.replaceAll("/", "-")).document(selectedDoc).updateData({"concluido":concluido} );            
  }

  
  deleteTarefaFirebase(FirebaseUser fbUser,String data, String selectedDoc)async{
    await bd.collection("tarefa_bd").document(fbUser.uid).collection(data.replaceAll("/", "-")).document(selectedDoc).delete();
  }
  

 

}